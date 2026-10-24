import { getSupabaseBrowserClient } from '@/lib/supabase/client';

/** Homeowners stay on the same studio as the app. Integrator salespeople go to the workbench. */
export async function pathAfterSignIn(): Promise<'/manage' | '/workbench'> {
  const supabase = getSupabaseBrowserClient();
  const user = await supabase?.auth.getUser();
  const userId = user?.data.user?.id;
  if (!supabase || !userId) {
    return '/manage';
  }
  const profile = await supabase.from('profiles').select('role').eq('id', userId).maybeSingle();
  const row = profile.data as { role?: string } | null;
  return row?.role === 'installer' ? '/workbench' : '/manage';
}
