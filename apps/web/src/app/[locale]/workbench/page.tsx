import type { Metadata } from 'next';
import { getTranslations, setRequestLocale } from 'next-intl/server';
import { SignOutButton } from '@/components/account/sign-out-button';
import { ConsoleShell } from '@/components/workbench/console-shell';
import { getAccountContext } from '@/lib/account/context';
import { formatStamp, safeHttpUrl } from '@/lib/format-stamp';
import { asRows } from '@/lib/rows';
import { isAppLocale } from '@/i18n/locale';
import { Link } from '@/i18n/navigation';

export const dynamic = 'force-dynamic';

export async function generateMetadata({ params }: { params: { locale: string } }): Promise<Metadata> {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  const t = await getTranslations({ locale, namespace: 'Workbench' });
  return {
    title: t('metaTitle'),
    description: t('metaDescription'),
    robots: { index: false, follow: false }
  };
}

export default async function WorkbenchPage({
  params,
  searchParams
}: {
  params: { locale: string };
  searchParams: { submitted?: string };
}) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const t = await getTranslations('Workbench');
  const account = await getAccountContext();

  if (!account.supabase) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('unavailable')}</p>
      </ConsoleShell>
    );
  }

  if (!account.userId) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
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
        <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{account.profileError ? t('profileError') : t('notInstaller')}</p>
        <div className="mt-6 flex flex-wrap gap-4">
          <Link href="/manage" className="inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
            {t('backToManage')}
          </Link>
          {account.role === 'admin' ? (
            <Link href="/admin" className="inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
              {t('openStaff')}
            </Link>
          ) : null}
        </div>
      </ConsoleShell>
    );
  }

  const [listings, applications, leads] = await Promise.all([
    account.supabase
      .from('installers')
      .select('id, company_name, city, postal_code, country_code, street_address, knx_official_rank, subscription_tier, is_contact_public, public_email, public_website')
      .eq('claimed_by_user_id', account.userId),
    account.supabase
      .from('integrator_applications')
      .select('id, applicant_user_id, kind, company_name, city, state, postal_code, country_code, street_address, public_website, status, staff_note, created_at')
      .order('created_at', { ascending: false }),
    account.supabase
      .from('integrator_leads')
      .select('id, title, city, state, postal_code, country_code, status, summary, created_at')
      .order('created_at', { ascending: false })
  ]);

  const listingRows = asRows<ListingRow>(listings.data);
  const applicationRows = asRows<ApplicationRow>(applications.data);
  const leadRows = asRows<LeadRow>(leads.data);
  const ownApplications = applicationRows.filter((row) => row.applicant_user_id === account.userId);
  const incoming = applicationRows.filter(
    (row) => row.applicant_user_id !== account.userId && (row.kind === 'claim' || row.kind === 'dispute')
  );
  const pending = ownApplications.filter((row) => row.status === 'pending');

  return (
    <ConsoleShell>
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
          <p className="mt-4 max-w-3xl leading-7">{t('lede')}</p>
          {account.email ? <p className="mt-2 text-sm font-semibold">{t('signedIn', { email: account.email })}</p> : null}
        </div>
        <SignOutButton />
      </div>
      {searchParams.submitted === '1' ? <p className="mt-6 font-semibold">{t('submitted')}</p> : null}
      <div className="mt-8 flex flex-wrap gap-2">
        <a href="#listing" className="inline-flex min-h-11 items-center rounded-full border border-ink px-4 text-sm font-semibold">
          {t('sectionListing')}
        </a>
        <a href="#claims" className="inline-flex min-h-11 items-center rounded-full border border-ink px-4 text-sm font-semibold">
          {t('sectionClaims')}
        </a>
        <a href="#requests" className="inline-flex min-h-11 items-center rounded-full border border-ink px-4 text-sm font-semibold">
          {t('sectionOrders')}
        </a>
        <Link href="/workbench/apply" className="inline-flex min-h-11 items-center rounded-full bg-ink px-4 text-sm font-semibold text-paper">
          {t('apply')}
        </Link>
      </div>

      <section id="listing" className="mt-12 scroll-mt-8">
        <h2 className="font-serif text-3xl font-semibold">{t('sectionListing')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('listingHelp')}</p>
        <p className="mt-3 max-w-3xl leading-7">{t('planLock')}</p>
        {listings.error ? <p className="mt-4 font-semibold">{t('listingFailed')}</p> : null}
        {!listings.error && listingRows.length === 0 ? <p className="mt-4">{t('listingEmpty')}</p> : null}
        <div className="mt-4 flex flex-col gap-3">
          {listingRows.map((listing) => {
            const website = safeHttpUrl(listing.public_website);
            return (
              <article key={listing.id} className="rounded-lg border border-line bg-white p-4">
                <h3 className="font-semibold">{listing.company_name}</h3>
                <p className="mt-2 text-sm leading-6">
                  {[listing.city, listing.postal_code, listing.country_code].filter(Boolean).join(', ')}
                </p>
                <p className="mt-2 text-sm leading-6">
                  {t('street')}: {listing.street_address?.trim() ? listing.street_address : t('noStreet')}
                </p>
                <p className="mt-2 text-sm leading-6">
                  {t('rank')}: {listing.knx_official_rank}
                </p>
                <p className="mt-2 text-sm leading-6">
                  {t('plan')}: {listing.subscription_tier === 'pro' ? t('planPro') : t('planFree')}
                </p>
                <p className="mt-2 text-sm leading-6">{listing.is_contact_public ? t('contactPublic') : t('contactPrivate')}</p>
                <p className="mt-2 text-sm leading-6">
                  {t('listingEmail')}: {listing.public_email?.trim() ? listing.public_email : t('noEmail')}
                </p>
                {website ? (
                  <a href={website} className="mt-2 inline-flex min-h-11 items-center text-sm font-semibold underline" rel="noreferrer" target="_blank">
                    {t('website')}
                  </a>
                ) : null}
              </article>
            );
          })}
        </div>
        {pending.length > 0 ? (
          <div className="mt-6 flex flex-col gap-3">
            <h3 className="font-semibold">{t('pendingTitle')}</h3>
            {pending.map((row) => (
              <article key={row.id} className="rounded-lg border border-line bg-white p-4">
                <p className="font-semibold">{row.company_name}</p>
                <p className="mt-2 text-sm leading-6">
                  {kindText(t, row.kind)} · {t('statusPending')}
                </p>
                <p className="mt-2 text-sm leading-6">{[row.city, row.state, row.postal_code, row.country_code].filter(Boolean).join(', ')}</p>
                <p className="mt-2 text-sm text-muted">{formatStamp(row.created_at, locale)}</p>
              </article>
            ))}
          </div>
        ) : null}
      </section>

      <section id="claims" className="mt-14 scroll-mt-8">
        <h2 className="font-serif text-3xl font-semibold">{t('sectionClaims')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('claimsHelp')}</p>
        {applications.error ? <p className="mt-4 font-semibold">{t('claimsFailed')}</p> : null}
        {!applications.error && ownApplications.length === 0 ? <p className="mt-4">{t('noApplications')}</p> : null}
        <div className="mt-4 flex flex-col gap-3">
          {ownApplications.map((row) => (
            <article key={row.id} className="rounded-lg border border-line bg-white p-4">
              <p className="font-semibold">{row.company_name}</p>
              <p className="mt-2 text-sm leading-6">
                {kindText(t, row.kind)} · {statusText(t, row.status)}
              </p>
              <p className="mt-2 text-sm leading-6">{[row.city, row.state, row.postal_code, row.country_code].filter(Boolean).join(', ')}</p>
              <p className="mt-2 text-sm leading-6">
                {t('street')}: {row.street_address?.trim() ? row.street_address : t('noStreet')}
              </p>
              <p className="mt-2 text-sm leading-6">
                {t('staffNote')}: {row.staff_note?.trim() ? row.staff_note : t('noStaffNote')}
              </p>
              <p className="mt-2 text-sm text-muted">{formatStamp(row.created_at, locale)}</p>
            </article>
          ))}
        </div>
        <h3 className="mt-8 font-semibold">{t('incomingTitle')}</h3>
        <p className="mt-2 max-w-3xl leading-7">{t('incomingHelp')}</p>
        {!applications.error && incoming.length === 0 ? <p className="mt-4">{t('noIncoming')}</p> : null}
        <div className="mt-4 flex flex-col gap-3">
          {incoming.map((row) => (
            <article key={row.id} className="rounded-lg border border-line bg-white p-4">
              <p className="font-semibold">{row.company_name}</p>
              <p className="mt-2 text-sm leading-6">
                {kindText(t, row.kind)} · {statusText(t, row.status)}
              </p>
              <p className="mt-2 text-sm text-muted">{formatStamp(row.created_at, locale)}</p>
            </article>
          ))}
        </div>
      </section>

      <section id="requests" className="mt-14 scroll-mt-8">
        <h2 className="font-serif text-3xl font-semibold">{t('sectionOrders')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('ordersHelp')}</p>
        <p className="mt-3 max-w-3xl leading-7">{t('replyCap')}</p>
        {leads.error ? <p className="mt-4 font-semibold">{t('ordersFailed')}</p> : null}
        {!leads.error && leadRows.length === 0 ? <p className="mt-4">{t('ordersEmpty')}</p> : null}
        <div className="mt-4 flex flex-col gap-3">
          {leadRows.map((lead) => (
            <article key={lead.id} className="rounded-lg border border-line bg-white p-4">
              <p className="font-semibold">{lead.title}</p>
              <p className="mt-2 text-sm leading-6">{[lead.city, lead.state, lead.postal_code, lead.country_code].filter(Boolean).join(', ')}</p>
              <p className="mt-2 text-sm leading-6">{lead.status}</p>
              {lead.summary ? <p className="mt-2 text-sm leading-6">{lead.summary}</p> : null}
              <p className="mt-2 text-sm text-muted">{formatStamp(lead.created_at, locale)}</p>
            </article>
          ))}
        </div>
      </section>
    </ConsoleShell>
  );
}

type ListingRow = {
  id: string;
  company_name: string;
  city: string;
  postal_code: string;
  country_code: string;
  street_address: string | null;
  knx_official_rank: string;
  subscription_tier: string | null;
  is_contact_public: boolean | null;
  public_email: string | null;
  public_website: string | null;
};

type ApplicationRow = {
  id: string;
  applicant_user_id: string;
  kind: string;
  company_name: string;
  city: string;
  state: string;
  postal_code: string;
  country_code: string;
  street_address: string | null;
  public_website: string | null;
  status: string;
  staff_note: string | null;
  created_at: string;
};

type LeadRow = {
  id: string;
  title: string;
  city: string | null;
  state: string | null;
  postal_code: string | null;
  country_code: string | null;
  status: string;
  summary: string | null;
  created_at: string;
};

function kindText(t: Awaited<ReturnType<typeof getTranslations>>, kind: string) {
  if (kind === 'claim') return t('kindClaim');
  if (kind === 'dispute') return t('kindDispute');
  return t('kindNew');
}

function statusText(t: Awaited<ReturnType<typeof getTranslations>>, status: string) {
  if (status === 'pending') {
    return t('statusPending');
  }
  if (status === 'approved') {
    return t('statusApproved');
  }
  if (status === 'rejected') {
    return t('statusRejected');
  }
  return status;
}
