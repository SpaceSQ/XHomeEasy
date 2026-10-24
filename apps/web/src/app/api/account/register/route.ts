import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';
import { geocodeAddress } from '@/lib/geocode';
import { getServiceClient } from '@/lib/supabase/admin';

export const dynamic = 'force-dynamic';

const noStore = { 'cache-control': 'no-store' };

type Role = 'homeowner' | 'installer';

function text(value: unknown, max = 200): string {
  if (typeof value !== 'string') {
    return '';
  }
  return value.trim().slice(0, max);
}

function positiveInt(value: unknown): number | null {
  const parsed = typeof value === 'number' ? value : typeof value === 'string' && value.trim() ? Number(value) : NaN;
  if (!Number.isInteger(parsed) || parsed <= 0 || parsed > 100000) {
    return null;
  }
  return parsed;
}

async function userIdForEmail(admin: NonNullable<ReturnType<typeof getServiceClient>>, email: string): Promise<string | null> {
  for (let page = 1; page <= 5; page += 1) {
    const listed = await admin.auth.admin.listUsers({ page, perPage: 200 });
    if (listed.error) {
      return null;
    }
    const found = listed.data.users.find((user) => user.email?.toLowerCase() === email);
    if (found?.id) {
      return found.id;
    }
    if (listed.data.users.length < 200) {
      return null;
    }
  }
  return null;
}

/** Creates or updates a website account. The phone sends email and password here and does not call the database host itself. */
export async function POST(request: Request) {
  const body = (await request.json().catch(() => null)) as Record<string, unknown> | null;
  const email = text(body?.email, 320).toLowerCase();
  const password = typeof body?.password === 'string' ? body.password : '';
  const role: Role | null = body?.role === 'installer' || body?.role === 'homeowner' ? body.role : null;
  const fullName = text(body?.fullName);
  const companyName = text(body?.companyName);
  const addressLine = text(body?.addressLine);
  const houseNumber = text(body?.houseNumber, 40);
  const city = text(body?.city);
  const postalCode = text(body?.postalCode, 20);
  const countryCode = text(body?.countryCode, 2).toUpperCase();
  if (!email.includes('@') || email.length < 3 || password.length < 8 || password.length > 128 || !role) {
    return NextResponse.json({ error: 'email' }, { status: 400, headers: noStore });
  }
  if (countryCode !== 'US' && countryCode !== 'CA') {
    return NextResponse.json({ error: 'country' }, { status: 400, headers: noStore });
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() ?? '';
  const anon = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() ?? '';
  const admin = getServiceClient();
  if (!url || !anon || !admin) {
    return NextResponse.json({ error: 'unavailable' }, { status: 503, headers: noStore });
  }

  const created = await admin.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: { full_name: fullName, locale: 'en-US' }
  });

  let userId = created.data.user?.id ?? null;
  if (!userId) {
    const exists = created.error?.code === 'email_exists' || (created.error?.message ?? '').toLowerCase().includes('already');
    if (!exists) {
      return NextResponse.json({ error: 'email' }, { status: 400, headers: noStore });
    }
    const anonClient = createClient(url, anon, { auth: { persistSession: false, autoRefreshToken: false } });
    let signed = await anonClient.auth.signInWithPassword({ email, password });
    const signedCode = `${signed.error?.code ?? ''} ${signed.error?.message ?? ''}`.toLowerCase();
    if (signed.error && signedCode.includes('confirm')) {
      const existingId = await userIdForEmail(admin, email);
      if (!existingId) {
        return NextResponse.json({ error: 'password' }, { status: 401, headers: noStore });
      }
      const confirmed = await admin.auth.admin.updateUserById(existingId, { email_confirm: true });
      if (confirmed.error) {
        return NextResponse.json({ error: 'unavailable' }, { status: 502, headers: noStore });
      }
      signed = await anonClient.auth.signInWithPassword({ email, password });
    }
    if (signed.error || !signed.data.user) {
      return NextResponse.json({ error: 'password' }, { status: 401, headers: noStore });
    }
    userId = signed.data.user.id;
  }

  const existing = await admin.from('profiles').select('role').eq('id', userId).maybeSingle();
  if (existing.data?.role === 'admin') {
    return NextResponse.json({ error: 'admin' }, { status: 403, headers: noStore });
  }

  const profile: Record<string, string | number | null> = {
    role,
    full_name: fullName || null,
    locale: 'en-US',
    country_code: countryCode,
    postal_code: postalCode || null,
    city: city || null,
    house_number: houseNumber || null,
    address_line: addressLine || null,
    area_sqm: positiveInt(body?.area),
    floors: positiveInt(body?.floors),
    room_count: positiveInt(body?.rooms)
  };
  const savedProfile = await admin.from('profiles').upsert({ id: userId, ...profile }, { onConflict: 'id' });
  if (savedProfile.error) {
    return NextResponse.json({ error: 'profile' }, { status: 500, headers: noStore });
  }

  if (role === 'homeowner' && city && postalCode) {
    const point = await geocodeAddress({
      street: addressLine,
      city,
      postalCode,
      countryCode
    }).catch(() => null);
    if (point) {
      await admin.from('profiles').update({ latitude: point.latitude, longitude: point.longitude }).eq('id', userId);
    }
  }

  let installerSaved = false;
  if (role === 'installer' && companyName && city && postalCode) {
    const point = await geocodeAddress({
      street: addressLine,
      houseNumber,
      city,
      postalCode,
      countryCode
    }).catch(() => null);
    const location = {
      company_name: companyName,
      city,
      postal_code: postalCode,
      country_code: countryCode,
      street_address: addressLine || null,
      house_number: houseNumber || null,
      latitude: point?.latitude ?? null,
      longitude: point?.longitude ?? null
    };
    const listed = await admin.from('installers').select('id').eq('claimed_by_user_id', userId).limit(1);
    const existingId = listed.data?.[0]?.id as string | undefined;
    if (existingId) {
      const updated = await admin.from('installers').update(location).eq('id', existingId);
      installerSaved = !updated.error;
    } else {
      const inserted = await admin.from('installers').insert({
        claimed_by_user_id: userId,
        ...location,
        knx_official_rank: 'Silver',
        is_contact_public: false,
        subscription_tier: 'free'
      });
      installerSaved = !inserted.error;
    }
  }

  return NextResponse.json({ ok: true, installerSaved }, { headers: noStore });
}
