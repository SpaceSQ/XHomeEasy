import type { Metadata } from 'next';
import { getTranslations, setRequestLocale } from 'next-intl/server';
import { ConsoleShell } from '@/components/workbench/console-shell';
import { ApplyForm, type DirectoryCompany } from '@/components/workbench/apply-form';

type DirectorySource = {
  id: string | null;
  company_name: string | null;
  city: string | null;
  postal_code: string | null;
  country_code: string | null;
  knx_official_rank: string | null;
  contact_withheld: boolean | null;
};
import { getAccountContext } from '@/lib/account/context';
import { asRows } from '@/lib/rows';
import { isAppLocale } from '@/i18n/locale';
import { Link } from '@/i18n/navigation';

export const dynamic = 'force-dynamic';

export async function generateMetadata({ params }: { params: { locale: string } }): Promise<Metadata> {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  const t = await getTranslations({ locale, namespace: 'Workbench' });
  return {
    title: t('applyTitle'),
    description: t('applyLede'),
    robots: { index: false, follow: false }
  };
}

export default async function ApplyPage({ params }: { params: { locale: string } }) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const t = await getTranslations('Workbench');
  const account = await getAccountContext();

  if (!account.supabase) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('applyTitle')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('unavailable')}</p>
      </ConsoleShell>
    );
  }

  if (!account.userId) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('applyTitle')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('needSession')}</p>
        <Link href="/login" className="mt-6 inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
          {t('signIn')}
        </Link>
      </ConsoleShell>
    );
  }

  if (account.profileError || account.role !== 'installer') {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('applyTitle')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{account.profileError ? t('profileError') : t('notInstaller')}</p>
        <Link href="/manage" className="mt-6 inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
          {t('backToManage')}
        </Link>
      </ConsoleShell>
    );
  }

  const [directory, owned] = await Promise.all([
    account.supabase
      .from('installer_directory')
      .select('id, company_name, city, postal_code, country_code, knx_official_rank, contact_withheld')
      .order('company_name', { ascending: true }),
    account.supabase.from('installers').select('id').eq('claimed_by_user_id', account.userId)
  ]);

  const companies: DirectoryCompany[] = asRows<DirectorySource>(directory.data).flatMap((row) => {
    if (!row.id || !row.company_name || (row.country_code !== 'US' && row.country_code !== 'CA')) {
      return [];
    }
    return [
      {
        id: row.id,
        companyName: row.company_name,
        city: row.city ?? '',
        postalCode: row.postal_code ?? '',
        countryCode: row.country_code === 'CA' ? 'CA' : 'US',
        rank: row.knx_official_rank ?? '',
        contactWithheld: row.contact_withheld === true
      }
    ];
  });

  return (
    <ConsoleShell>
      <h1 className="font-serif text-4xl font-semibold">{t('applyTitle')}</h1>
      <p className="mt-4 max-w-3xl leading-7">{t('applyLede')}</p>
      <p className="mt-3 max-w-3xl leading-7">{t('lede')}</p>
      <Link href="/workbench" className="mt-6 inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
        {t('back')}
      </Link>
      <div className="mt-8">
        {directory.error ? <p className="mb-4 font-semibold">{t('directoryFailed')}</p> : null}
        <ApplyForm companies={directory.error ? [] : companies} hasListing={owned.error ? null : asRows<{ id: string }>(owned.data).length > 0} />
      </div>
    </ConsoleShell>
  );
}
