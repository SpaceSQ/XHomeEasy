import { NextResponse } from 'next/server';
import type { Database } from '@xhomeeasy/shared-types';
import { getAccountContext } from '@/lib/account/context';
import { getServiceClient } from '@/lib/supabase/admin';
import { asOne, asRows } from '@/lib/rows';
import { parseApplicationBody } from '@/lib/workbench/application-input';
import { removeClaimFiles, storeClaimFile } from '@/lib/workbench/claim-files';
import { maskEmail } from '@/lib/workbench/mask-email';

export const dynamic = 'force-dynamic';

const noStore = { 'cache-control': 'no-store' };

type DirectorySource = {
  id: string | null;
  company_name: string | null;
  city: string | null;
  postal_code: string | null;
  country_code: string | null;
};

export async function POST(request: Request) {
  const form = await request.formData().catch(() => null);
  if (!form) {
    return NextResponse.json({ error: 'missing' }, { status: 400, headers: noStore });
  }
  const body = parseApplicationBody(recordFromForm(form));
  if (!body) {
    return NextResponse.json({ error: 'missing' }, { status: 400, headers: noStore });
  }

  const account = await getAccountContext();
  if (!account.supabase) {
    return NextResponse.json({ error: 'unavailable' }, { status: 503, headers: noStore });
  }
  if (!account.userId) {
    return NextResponse.json({ error: 'session' }, { status: 401, headers: noStore });
  }
  if (account.profileError || account.role !== 'installer') {
    return NextResponse.json({ error: 'role' }, { status: 403, headers: noStore });
  }

  let companyName = body.companyName;
  let city = body.city;
  let postalCode = body.postalCode;
  let countryCode = body.countryCode;
  let targetInstallerId: string | null = null;

  if (body.kind === 'claim' || body.kind === 'dispute') {
    const service = getServiceClient();
    if (!service) {
      return NextResponse.json({ error: 'unavailable' }, { status: 503, headers: noStore });
    }
    const listed = await account.supabase
      .from('installer_directory')
      .select('id, company_name, city, postal_code, country_code')
      .eq('id', body.targetInstallerId ?? '')
      .maybeSingle();
    const row = asOne<DirectorySource>(listed.data);
    if (
      listed.error ||
      !row?.id ||
      !row.company_name ||
      !row.city ||
      !row.postal_code ||
      (row.country_code !== 'US' && row.country_code !== 'CA')
    ) {
      return NextResponse.json({ error: 'target' }, { status: 400, headers: noStore });
    }
    const target = await service.from('installers').select('id, claimed_by_user_id').eq('id', row.id).maybeSingle();
    const claimedBy =
      target.data && typeof target.data === 'object' && 'claimed_by_user_id' in target.data ? target.data.claimed_by_user_id : undefined;
    if (target.error || typeof claimedBy === 'undefined') {
      return NextResponse.json({ error: 'target' }, { status: 400, headers: noStore });
    }
    if (body.kind === 'claim' && typeof claimedBy === 'string' && claimedBy !== account.userId) {
      const maskedEmail = await claimantMask(service, claimedBy);
      return NextResponse.json({ error: 'already_claimed', maskedEmail }, { status: 409, headers: noStore });
    }
    if (body.kind === 'claim' && claimedBy === account.userId) {
      return NextResponse.json({ error: 'already_listed' }, { status: 409, headers: noStore });
    }
    if (body.kind === 'dispute' && (typeof claimedBy !== 'string' || claimedBy === account.userId)) {
      return NextResponse.json({ error: 'not_disputable' }, { status: 409, headers: noStore });
    }
    companyName = row.company_name;
    city = row.city;
    postalCode = row.postal_code;
    countryCode = row.country_code === 'CA' ? 'CA' : 'US';
    targetInstallerId = row.id;
  } else {
    const existing = await account.supabase.from('installers').select('id').eq('claimed_by_user_id', account.userId);
    if (existing.error) {
      return NextResponse.json({ error: 'failed' }, { status: 500, headers: noStore });
    }
    if (asRows<{ id: string }>(existing.data).length > 0) {
      return NextResponse.json({ error: 'already_listed' }, { status: 409, headers: noStore });
    }
  }

  const evidence = body.kind === 'new_company' ? null : await readEvidence(form, account.supabase, account.userId);
  if (evidence && 'error' in evidence) {
    return NextResponse.json({ error: 'evidence' }, { status: evidence.error === 'upload' ? 500 : 400, headers: noStore });
  }

  const payload: Database['public']['Tables']['integrator_applications']['Insert'] = {
    applicant_user_id: account.userId,
    kind: body.kind,
    target_installer_id: targetInstallerId,
    company_name: companyName,
    city,
    state: body.state,
    postal_code: postalCode,
    country_code: countryCode,
    street_address: body.streetAddress,
    public_website: body.website,
    company_email: body.companyEmail,
    card_photo_path: evidence ? evidence.card : null,
    office_photo_path: evidence ? evidence.office : null,
    extra_evidence_path: evidence ? evidence.extra : null,
    status: 'pending'
  };
  const inserted = await account.supabase.from('integrator_applications').insert(payload as never);

  if (inserted.error) {
    if (evidence) {
      await removeClaimFiles(account.supabase, [evidence.card, evidence.office, evidence.extra].filter((path): path is string => Boolean(path)));
    }
    const code = 'code' in inserted.error ? inserted.error.code : '';
    const message = inserted.error.message ?? '';
    if (message.includes('company already has a claimant')) {
      const service = getServiceClient();
      let maskedEmail = '**';
      if (service && targetInstallerId) {
        const again = await service.from('installers').select('claimed_by_user_id').eq('id', targetInstallerId).maybeSingle();
        const claimedBy =
          again.data && typeof again.data === 'object' && 'claimed_by_user_id' in again.data && typeof again.data.claimed_by_user_id === 'string'
            ? again.data.claimed_by_user_id
            : null;
        if (claimedBy) {
          maskedEmail = await claimantMask(service, claimedBy);
        }
      }
      return NextResponse.json({ error: 'already_claimed', maskedEmail }, { status: 409, headers: noStore });
    }
    if (code === '23505') {
      return NextResponse.json({ error: 'duplicate' }, { status: 409, headers: noStore });
    }
    return NextResponse.json({ error: 'failed' }, { status: 500, headers: noStore });
  }

  return NextResponse.json({ ok: true, status: 'pending' }, { headers: noStore });
}

function recordFromForm(form: FormData): Record<string, unknown> {
  const record: Record<string, unknown> = {};
  for (const key of [
    'kind',
    'targetInstallerId',
    'companyName',
    'city',
    'state',
    'postalCode',
    'countryCode',
    'streetAddress',
    'website',
    'companyEmail'
  ]) {
    const value = form.get(key);
    if (typeof value === 'string') {
      record[key] = value;
    }
  }
  return record;
}

async function readEvidence(
  form: FormData,
  supabase: NonNullable<Awaited<ReturnType<typeof getAccountContext>>['supabase']>,
  userId: string
): Promise<{ card: string; office: string; extra: string | null } | { error: 'invalid' | 'upload' }> {
  const card = form.get('cardPhoto');
  const office = form.get('officePhoto');
  const extra = form.get('extraEvidence');
  if (!(card instanceof File) || !(office instanceof File)) {
    return { error: 'invalid' };
  }
  const storedCard = await storeClaimFile(supabase, userId, card, 'card');
  if ('error' in storedCard) {
    return storedCard;
  }
  const storedOffice = await storeClaimFile(supabase, userId, office, 'office');
  if ('error' in storedOffice) {
    await removeClaimFiles(supabase, [storedCard.path]);
    return storedOffice;
  }
  let extraPath: string | null = null;
  if (extra instanceof File && extra.size > 0) {
    const storedExtra = await storeClaimFile(supabase, userId, extra, 'extra');
    if ('error' in storedExtra) {
      await removeClaimFiles(supabase, [storedCard.path, storedOffice.path]);
      return storedExtra;
    }
    extraPath = storedExtra.path;
  }
  return { card: storedCard.path, office: storedOffice.path, extra: extraPath };
}

async function claimantMask(service: NonNullable<ReturnType<typeof getServiceClient>>, userId: string) {
  const user = await service.auth.admin.getUserById(userId);
  return maskEmail(user.data.user?.email);
}
