import 'server-only';

import { asOne } from '@/lib/rows';
import { getSupabaseServerClient } from '@/lib/supabase/server';

export async function getAccountContext() {
  const supabase = await getSupabaseServerClient();
  if (!supabase) {
    return { supabase: null, userId: null as string | null, email: null as string | null, role: null as string | null, profileError: false };
  }

  const { data, error } = await supabase.auth.getUser();
  if (error || !data.user) {
    return { supabase, userId: null, email: null, role: null, profileError: false };
  }

  const profile = await supabase.from('profiles').select('role').eq('id', data.user.id).maybeSingle();
  return {
    supabase,
    userId: data.user.id,
    email: data.user.email ?? null,
    role: asOne<{ role: string }>(profile.data)?.role ?? null,
    profileError: Boolean(profile.error)
  };
}
