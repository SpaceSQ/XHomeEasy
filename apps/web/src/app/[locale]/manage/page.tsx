import type { Metadata } from 'next';
import { getTranslations, setRequestLocale } from 'next-intl/server';
import { ManageWorkspace } from '@/components/account/manage-workspace';
import { SiteFooter } from '@/components/layout/site-footer';
import { SiteHeader } from '@/components/layout/site-header';
import { isAppLocale } from '@/i18n/locale';
import { redirect } from '@/i18n/navigation';
import { asOne } from '@/lib/rows';
import { getSupabaseServerClient } from '@/lib/supabase/server';

export async function generateMetadata({
  params
}: {
  params: { locale: string };
}): Promise<Metadata> {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  const t = await getTranslations({ locale, namespace: 'Login' });
  return { title: t('manageTitle'), description: t('manageLede') };
}

export default async function ManagePage({ params }: { params: { locale: string } }) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const supabase = await getSupabaseServerClient();
  if (supabase) {
    const { data } = await supabase.auth.getUser();
    if (data.user) {
      const profile = await supabase.from('profiles').select('role').eq('id', data.user.id).maybeSingle();
      if (asOne<{ role: string }>(profile.data)?.role === 'installer') {
        redirect({ href: '/workbench', locale });
      }
    }
  }

  return (
    <>
      <SiteHeader />
      <main id="content" className="mx-auto max-w-page px-6 py-16">
        <ManageWorkspace />
      </main>
      <SiteFooter databaseReady={supabase !== null} />
    </>
  );
}
