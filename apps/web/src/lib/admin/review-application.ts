import 'server-only';

import { geocodeAddress } from '@/lib/geocode';
import { getServiceClient } from '@/lib/supabase/admin';

export type ReviewResult = { ok: true } | { ok: false; error: string; status: number };

type ApplicationRecord = {
  id: string;
  applicant_user_id: string;
  kind: 'claim' | 'new_company' | 'dispute';
  target_installer_id: string | null;
  company_name: string;
  city: string;
  state: string;
  postal_code: string;
  country_code: 'US' | 'CA';
  street_address: string | null;
  public_website: string | null;
  status: string;
};

function asApplication(value: unknown): ApplicationRecord | null {
  if (!value || typeof value !== 'object') {
    return null;
  }
  const row = value as Record<string, unknown>;
  if (
    typeof row.id !== 'string' ||
    typeof row.applicant_user_id !== 'string' ||
    (row.kind !== 'claim' && row.kind !== 'new_company' && row.kind !== 'dispute') ||
    typeof row.company_name !== 'string' ||
    typeof row.city !== 'string' ||
    typeof row.state !== 'string' ||
    typeof row.postal_code !== 'string' ||
    (row.country_code !== 'US' && row.country_code !== 'CA') ||
    typeof row.status !== 'string'
  ) {
    return null;
  }
  return {
    id: row.id,
    applicant_user_id: row.applicant_user_id,
    kind: row.kind,
    target_installer_id: typeof row.target_installer_id === 'string' ? row.target_installer_id : null,
    company_name: row.company_name,
    city: row.city,
    state: row.state,
    postal_code: row.postal_code,
    country_code: row.country_code,
    street_address: typeof row.street_address === 'string' ? row.street_address : null,
    public_website: typeof row.public_website === 'string' ? row.public_website : null,
    status: row.status
  };
}

async function markReviewed(
  applicationId: string,
  reviewerId: string,
  status: 'approved' | 'rejected',
  note: string | null,
  resultInstallerId: string | null
): Promise<'saved' | 'conflict' | 'failed'> {
  const admin = getServiceClient();
  if (!admin) {
    return 'failed';
  }
  const { data, error } = await admin
    .from('integrator_applications')
    .update({
      status,
      staff_note: note,
      reviewed_by: reviewerId,
      reviewed_at: new Date().toISOString(),
      result_installer_id: resultInstallerId
    })
    .eq('id', applicationId)
    .eq('status', 'pending')
    .select('id')
    .maybeSingle();
  if (error) {
    return 'failed';
  }
  return data && typeof data === 'object' && 'id' in data && data.id ? 'saved' : 'conflict';
}

export async function reviewApplication(input: {
  reviewerId: string;
  applicationId: string;
  decision: 'approved' | 'rejected';
  note: string | null;
}): Promise<ReviewResult> {
  const admin = getServiceClient();
  if (!admin) {
    return { ok: false, error: 'configuration', status: 503 };
  }

  const loaded = await admin.from('integrator_applications').select('*').eq('id', input.applicationId).maybeSingle();
  if (loaded.error) {
    return { ok: false, error: 'failed', status: 500 };
  }
  const application = asApplication(loaded.data);
  if (!application) {
    return { ok: false, error: 'not_found', status: 404 };
  }
  if (application.status !== 'pending') {
    return { ok: false, error: 'not_pending', status: 409 };
  }

  if (input.decision === 'rejected') {
    const saved = await markReviewed(application.id, input.reviewerId, 'rejected', input.note, null);
    if (saved === 'saved') {
      return { ok: true };
    }
    return saved === 'conflict'
      ? { ok: false, error: 'not_pending', status: 409 }
      : { ok: false, error: 'failed', status: 500 };
  }

  if (application.kind === 'dispute') {
    if (!application.target_installer_id) {
      return { ok: false, error: 'not_found', status: 404 };
    }
    const before = await admin.from('installers').select('claimed_by_user_id').eq('id', application.target_installer_id).maybeSingle();
    const beforeClaimed =
      before.data && typeof before.data === 'object' && 'claimed_by_user_id' in before.data ? before.data.claimed_by_user_id : undefined;
    if (before.error || typeof beforeClaimed === 'undefined') {
      return { ok: false, error: 'not_found', status: 404 };
    }
    const saved = await markReviewed(application.id, input.reviewerId, 'approved', input.note, null);
    const after = await admin.from('installers').select('claimed_by_user_id').eq('id', application.target_installer_id).maybeSingle();
    const afterClaimed =
      after.data && typeof after.data === 'object' && 'claimed_by_user_id' in after.data ? after.data.claimed_by_user_id : undefined;
    if (afterClaimed === application.applicant_user_id && beforeClaimed !== application.applicant_user_id) {
      const reverted = await admin
        .from('installers')
        .update({ claimed_by_user_id: typeof beforeClaimed === 'string' ? beforeClaimed : null })
        .eq('id', application.target_installer_id)
        .eq('claimed_by_user_id', application.applicant_user_id)
        .select('id')
        .maybeSingle();
      const revertedId = reverted.data && typeof reverted.data === 'object' && 'id' in reverted.data ? reverted.data.id : null;
      if (reverted.error || !revertedId) {
        return { ok: false, error: 'claimed', status: 409 };
      }
    }
    if (saved === 'saved') {
      return { ok: true };
    }
    return saved === 'conflict'
      ? { ok: false, error: 'not_pending', status: 409 }
      : { ok: false, error: 'failed', status: 500 };
  }

  const applicant = await admin.from('profiles').select('role').eq('id', application.applicant_user_id).maybeSingle();
  const role = applicant.data && typeof applicant.data === 'object' && 'role' in applicant.data ? applicant.data.role : null;
  if (applicant.error || role !== 'installer') {
    return { ok: false, error: 'role', status: 409 };
  }

  const owned = await admin.from('installers').select('id').eq('claimed_by_user_id', application.applicant_user_id);
  if (owned.error || !Array.isArray(owned.data)) {
    return { ok: false, error: 'failed', status: 500 };
  }
  const ownedIds = owned.data.flatMap((row) => (row && typeof row === 'object' && 'id' in row && typeof row.id === 'string' ? [row.id] : []));

  if (application.kind === 'claim') {
    if (!application.target_installer_id) {
      return { ok: false, error: 'not_found', status: 404 };
    }
    if (ownedIds.some((id) => id !== application.target_installer_id)) {
      return { ok: false, error: 'already_listed', status: 409 };
    }
    const target = await admin.from('installers').select('id, claimed_by_user_id').eq('id', application.target_installer_id).maybeSingle();
    const claimedBy =
      target.data && typeof target.data === 'object' && 'claimed_by_user_id' in target.data
        ? target.data.claimed_by_user_id
        : undefined;
    if (target.error || !target.data || typeof claimedBy === 'undefined') {
      return { ok: false, error: 'not_found', status: 404 };
    }
    if (typeof claimedBy === 'string' && claimedBy !== application.applicant_user_id) {
      return { ok: false, error: 'claimed', status: 409 };
    }
    if (claimedBy == null) {
      const bound = await admin
        .from('installers')
        .update({ claimed_by_user_id: application.applicant_user_id })
        .eq('id', application.target_installer_id)
        .is('claimed_by_user_id', null)
        .select('id')
        .maybeSingle();
      const boundId = bound.data && typeof bound.data === 'object' && 'id' in bound.data ? bound.data.id : null;
      if (bound.error || !boundId) {
        const again = await admin.from('installers').select('claimed_by_user_id').eq('id', application.target_installer_id).maybeSingle();
        const againClaimed =
          again.data && typeof again.data === 'object' && 'claimed_by_user_id' in again.data ? again.data.claimed_by_user_id : null;
        if (againClaimed !== application.applicant_user_id) {
          return { ok: false, error: 'claimed', status: 409 };
        }
      }
    }
    const saved = await markReviewed(application.id, input.reviewerId, 'approved', input.note, application.target_installer_id);
    if (saved === 'saved') {
      return { ok: true };
    }
    return saved === 'conflict'
      ? { ok: false, error: 'not_pending', status: 409 }
      : { ok: false, error: 'failed', status: 500 };
  }

  if (ownedIds.length > 0) {
    return { ok: false, error: 'already_listed', status: 409 };
  }

  let latitude: number | null = null;
  let longitude: number | null = null;
  try {
    const point = await Promise.race([
      geocodeAddress({
        street: application.street_address ?? '',
        city: application.city,
        postalCode: application.postal_code,
        countryCode: application.country_code
      }),
      new Promise<null>((resolve) => setTimeout(() => resolve(null), 4000))
    ]);
    latitude = point?.latitude ?? null;
    longitude = point?.longitude ?? null;
  } catch {
    latitude = null;
    longitude = null;
  }

  const created = await admin
    .from('installers')
    .insert({
      claimed_by_user_id: application.applicant_user_id,
      company_name: application.company_name,
      country_code: application.country_code,
      city: application.city,
      postal_code: application.postal_code,
      street_address: application.street_address,
      house_number: null,
      public_website: application.public_website,
      knx_official_rank: 'Silver',
      is_contact_public: false,
      subscription_tier: 'free',
      opted_out: true,
      latitude,
      longitude
    })
    .select('id')
    .single();
  const createdId = created.data && typeof created.data === 'object' && 'id' in created.data && typeof created.data.id === 'string' ? created.data.id : null;
  if (created.error || !createdId) {
    return { ok: false, error: 'failed', status: 500 };
  }

  const saved = await markReviewed(application.id, input.reviewerId, 'approved', input.note, createdId);
  if (saved !== 'saved') {
    await admin.from('installers').delete().eq('id', createdId).eq('claimed_by_user_id', application.applicant_user_id);
    return saved === 'conflict'
      ? { ok: false, error: 'not_pending', status: 409 }
      : { ok: false, error: 'failed', status: 500 };
  }

  const published = await admin
    .from('installers')
    .update({ opted_out: false })
    .eq('id', createdId)
    .eq('claimed_by_user_id', application.applicant_user_id)
    .select('id')
    .maybeSingle();
  const publishedId = published.data && typeof published.data === 'object' && 'id' in published.data ? published.data.id : null;
  if (!published.error && publishedId) {
    return { ok: true };
  }

  await admin
    .from('integrator_applications')
    .update({
      status: 'pending',
      result_installer_id: null,
      reviewed_at: null,
      reviewed_by: null,
      staff_note: null
    })
    .eq('id', application.id)
    .eq('status', 'approved');
  await admin.from('installers').delete().eq('id', createdId).eq('claimed_by_user_id', application.applicant_user_id);
  return { ok: false, error: 'failed', status: 500 };
}
