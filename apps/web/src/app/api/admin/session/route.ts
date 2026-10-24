import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';
import { staffAuthEmailForAccountName } from '@/lib/admin/staff-account';
import { getSupabasePublicEnv } from '@/lib/supabase/env';

export const dynamic = 'force-dynamic';

const noStore = { 'cache-control': 'no-store' };

export async function POST(request: Request) {
  const env = getSupabasePublicEnv();
  if (!env) {
    return NextResponse.json({ error: 'unavailable' }, { status: 503, headers: noStore });
  }

  const body = (await request.json().catch(() => null)) as { account?: unknown; password?: unknown } | null;
  const account = typeof body?.account === 'string' ? body.account : '';
  const password = typeof body?.password === 'string' ? body.password : '';
  const email = staffAuthEmailForAccountName(account);
  if (!email || password.length === 0 || password.length > 200) {
    return NextResponse.json({ error: 'invalid' }, { status: 401, headers: noStore });
  }

  const cookieStore = cookies();
  const supabase = createServerClient(env.url, env.anonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet: { name: string; value: string; options: CookieOptions }[]) {
        for (const { name, value, options } of cookiesToSet) {
          cookieStore.set({ name, value, ...options });
        }
      }
    }
  });

  const signedIn = await supabase.auth.signInWithPassword({ email, password });
  if (signedIn.error || !signedIn.data.user) {
    return NextResponse.json({ error: 'invalid' }, { status: 401, headers: noStore });
  }

  const profile = await supabase.from('profiles').select('role').eq('id', signedIn.data.user.id).maybeSingle();
  const role = profile.data && typeof profile.data === 'object' && 'role' in profile.data ? profile.data.role : null;
  if (profile.error || role !== 'admin') {
    await supabase.auth.signOut();
    return NextResponse.json({ error: 'invalid' }, { status: 403, headers: noStore });
  }

  return NextResponse.json({ ok: true }, { headers: noStore });
}
