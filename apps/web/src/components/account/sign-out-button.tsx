'use client';

import { useTranslations } from 'next-intl';
import { useRouter } from '@/i18n/navigation';
import { getSupabaseBrowserClient } from '@/lib/supabase/client';

export function SignOutButton() {
  const t = useTranslations('Login');
  const router = useRouter();

  return (
    <button
      type="button"
      className="min-h-11 rounded-full border border-ink px-4 text-sm font-semibold"
      onClick={() => {
        const supabase = getSupabaseBrowserClient();
        const done = supabase ? supabase.auth.signOut() : Promise.resolve();
        done
          .then(() => {
            router.push('/login');
            router.refresh();
          })
          .catch(() => undefined);
      }}
    >
      {t('signOut')}
    </button>
  );
}
