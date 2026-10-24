import { NextResponse } from 'next/server';
import { getServiceClient } from '@/lib/supabase/admin';

export const dynamic = 'force-dynamic';

const noStore = { 'cache-control': 'no-store' };

/** Marks an existing sign-up as confirmed. This product does not check that the mailbox is real. */
export async function POST(request: Request) {
  const body: unknown = await request.json().catch(() => null);
  const email = body && typeof body === 'object' && 'email' in body && typeof body.email === 'string'
    ? body.email.trim().toLowerCase()
    : '';
  if (!email.includes('@') || email.length > 320) {
    return NextResponse.json({ error: 'email' }, { status: 400, headers: noStore });
  }

  const admin = getServiceClient();
  if (!admin) {
    return NextResponse.json({ error: 'unavailable' }, { status: 503, headers: noStore });
  }

  let page = 1;
  let userId: string | null = null;
  while (page <= 5 && !userId) {
    const listed = await admin.auth.admin.listUsers({ page, perPage: 200 });
    if (listed.error) {
      return NextResponse.json({ error: 'lookup' }, { status: 502, headers: noStore });
    }
    userId = listed.data.users.find((user) => user.email?.toLowerCase() === email)?.id ?? null;
    if (listed.data.users.length < 200) {
      break;
    }
    page += 1;
  }
  if (!userId) {
    return NextResponse.json({ error: 'missing' }, { status: 404, headers: noStore });
  }

  const updated = await admin.auth.admin.updateUserById(userId, { email_confirm: true });
  if (updated.error) {
    return NextResponse.json({ error: 'confirm' }, { status: 502, headers: noStore });
  }
  return NextResponse.json({ ok: true }, { headers: noStore });
}
