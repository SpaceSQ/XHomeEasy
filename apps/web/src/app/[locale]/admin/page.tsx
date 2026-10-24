import type { Metadata } from 'next';
import { getTranslations, setRequestLocale } from 'next-intl/server';
import { ReviewForm } from '@/components/admin/review-form';
import { StaffSignIn } from '@/components/admin/staff-sign-in';
import { SignOutButton } from '@/components/account/sign-out-button';
import { ConsoleShell } from '@/components/workbench/console-shell';
import { getAccountContext } from '@/lib/account/context';
import { getServiceClient } from '@/lib/supabase/admin';
import { formatStamp } from '@/lib/format-stamp';
import { asRows } from '@/lib/rows';
import { CLAIM_EVIDENCE_BUCKET, claimEvidencePathOk } from '@/lib/workbench/claim-files';
import { isAppLocale } from '@/i18n/locale';
import { Link } from '@/i18n/navigation';

export const dynamic = 'force-dynamic';

export async function generateMetadata({ params }: { params: { locale: string } }): Promise<Metadata> {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  const t = await getTranslations({ locale, namespace: 'Admin' });
  return {
    title: t('metaTitle'),
    description: t('metaDescription'),
    robots: { index: false, follow: false }
  };
}

export default async function AdminPage({ params }: { params: { locale: string } }) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const t = await getTranslations('Admin');
  const account = await getAccountContext();

  if (!account.supabase) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('unconfigured')}</p>
        <p className="mt-3 max-w-3xl leading-7">{t('assignment')}</p>
      </ConsoleShell>
    );
  }

  if (!account.userId) {
    return (
      <ConsoleShell>
        <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('accountLede')}</p>
        <StaffSignIn />
      </ConsoleShell>
    );
  }

  if (account.profileError || account.role !== 'admin') {
    return (
      <ConsoleShell>
        <p className="text-sm font-semibold uppercase tracking-[0.14em]">403</p>
        <h1 className="mt-3 font-serif text-4xl font-semibold">{t('deniedTitle')}</h1>
        <p className="mt-4 max-w-3xl leading-7">{t('deniedBody')}</p>
        <p className="mt-3 max-w-3xl leading-7">{t('assignment')}</p>
        <Link href="/login" className="mt-6 inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
          {t('signIn')}
        </Link>
      </ConsoleShell>
    );
  }

  const service = getServiceClient();
  const [profiles, applications, installers, unlockedProjects, awardedRfqs, communications] = await Promise.all([
    account.supabase.from('profiles').select('id, role, country_code, created_at').order('created_at', { ascending: false }),
    account.supabase
      .from('integrator_applications')
      .select(
        'id, applicant_user_id, kind, company_name, city, state, postal_code, country_code, street_address, company_email, card_photo_path, office_photo_path, extra_evidence_path, status, staff_note, created_at'
      )
      .order('created_at', { ascending: false }),
    account.supabase.from('installers').select('id, claimed_by_user_id, company_name, country_code, created_at'),
    account.supabase.from('projects').select('id, title, stage, created_at').eq('is_pro_unlocked', true).order('created_at', { ascending: false }),
    account.supabase.from('projects_rfq').select('id, project_title, city, state, status, created_at').eq('status', 'awarded').order('created_at', { ascending: false }),
    account.supabase
      .from('integrator_communications')
      .select('id, homeowner_user_id, installer_user_id, installer_id, summary, created_at')
      .order('created_at', { ascending: false })
  ]);

  const deliveryOpen = !unlockedProjects.error && asRows<ProjectRow>(unlockedProjects.data).length > 0;
  const leads = deliveryOpen
    ? await account.supabase
        .from('integrator_leads')
        .select('id, installer_id, project_id, title, city, state, country_code, status, summary, created_at')
        .order('created_at', { ascending: false })
    : { data: [], error: null };

  const awardedIds = asRows<AwardRow>(awardedRfqs.data).map((row) => row.id);
  const quotes =
    !awardedRfqs.error && awardedIds.length > 0
      ? await account.supabase.from('dealer_quotes').select('id, rfq_id, proposed_control_brand, created_at').in('rfq_id', awardedIds)
      : { data: [], error: awardedRfqs.error ? awardedRfqs.error : null };

  const emails = new Map<string, string | null>();
  let emailError = false;
  let emailTruncated = false;
  if (service) {
    const loaded = await loadEmails(service);
    loaded.emails.forEach((email, id) => emails.set(id, email));
    emailError = loaded.error;
    emailTruncated = loaded.truncated;
  }

  const profileRows = asRows<ProfileRow>(profiles.data);
  const applicationRows = asRows<ApplicationRow>(applications.data);
  const installerRows = asRows<InstallerRow>(installers.data);
  const projectRows = asRows<ProjectRow>(unlockedProjects.data);
  const leadRows = asRows<LeadRow>(leads.data);
  const awardRows = asRows<AwardRow>(awardedRfqs.data);
  const quoteRows = asRows<QuoteRow>(quotes.data);
  const communicationRows = asRows<CommunicationRow>(communications.data);
  const companyNames = new Map(installerRows.map((row) => [row.id, row.company_name]));
  const evidenceUrls = service ? await signEvidence(service, applicationRows) : new Map<string, string>();

  const pendingClaims = applicationRows.filter((row) => row.status === 'pending' && row.kind === 'claim').length;
  const pendingDisputes = applicationRows.filter((row) => row.status === 'pending' && row.kind === 'dispute').length;
  const pendingNew = applicationRows.filter((row) => row.status === 'pending' && row.kind === 'new_company').length;
  const integratorProfiles = profileRows.filter((row) => row.role === 'installer');

  return (
    <ConsoleShell>
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="font-serif text-4xl font-semibold">{t('title')}</h1>
          <p className="mt-4 max-w-3xl leading-7">{t('lede')}</p>
          <p className="mt-3 max-w-3xl leading-7">{t('assignment')}</p>
          {account.email ? <p className="mt-2 text-sm font-semibold">{t('signedIn', { email: account.email })}</p> : null}
        </div>
        <SignOutButton />
      </div>
      {!service ? <p className="mt-6 max-w-3xl font-semibold leading-7">{t('configBody')}</p> : null}
      <p className="mt-6 text-sm font-semibold leading-6">
        {t('pendingClaims', { count: pendingClaims })} · {t('pendingDisputes', { count: pendingDisputes })} · {t('pendingNew', { count: pendingNew })} ·{' '}
        {t('pendingTotal', { count: pendingClaims + pendingDisputes + pendingNew })}
      </p>

      <section className="mt-12">
        <h2 className="font-serif text-3xl font-semibold">{t('users')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('usersHelp')}</p>
        {!service ? <p className="mt-3 max-w-3xl leading-7">{t('usersConfig')}</p> : null}
        {emailError ? <p className="mt-3 font-semibold">{t('usersError')}</p> : null}
        {emailTruncated ? <p className="mt-3">{t('truncated', { count: String(emails.size) })}</p> : null}
        {profiles.error ? <p className="mt-4 font-semibold">{t('usersError')}</p> : null}
        {!profiles.error && profileRows.length === 0 ? <p className="mt-4">{t('noUsers')}</p> : null}
        {!profiles.error && profileRows.length > 0 ? (
          <DataTable
            headers={[t('email'), t('role'), t('country'), t('created')]}
            rows={profileRows.map((profile) => [
              emails.get(profile.id) || t('noEmail'),
              roleLabel(t, profile.role),
              profile.country_code ?? t('noCountry'),
              profile.created_at ? formatStamp(profile.created_at, locale) : t('noCreated')
            ])}
          />
        ) : null}
      </section>

      <section className="mt-14">
        <h2 className="font-serif text-3xl font-semibold">{t('integrators')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('integratorsHelp')}</p>
        {profiles.error || installers.error ? <p className="mt-4 font-semibold">{t('usersError')}</p> : null}
        {!profiles.error && !installers.error && integratorProfiles.length === 0 ? <p className="mt-4">{t('noIntegrators')}</p> : null}
        {!profiles.error && !installers.error && integratorProfiles.length > 0 ? (
          <DataTable
            headers={[t('email'), t('company'), t('country'), t('created')]}
            rows={integratorProfiles.map((profile) => {
              const owned = installerRows.filter((row) => row.claimed_by_user_id === profile.id).map((row) => row.company_name);
              const applied = applicationRows.find((row) => row.applicant_user_id === profile.id)?.company_name;
              return [
                emails.get(profile.id) || t('noEmail'),
                owned.length > 0 ? owned.join(', ') : applied || t('noCompany'),
                profile.country_code ?? t('noCountry'),
                profile.created_at ? formatStamp(profile.created_at, locale) : t('noCreated')
              ];
            })}
          />
        ) : null}
      </section>

      <section className="mt-14">
        <h2 className="font-serif text-3xl font-semibold">{t('applications')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('pendingPublic')}</p>
        {applications.error ? <p className="mt-4 font-semibold">{t('reviewFailed')}</p> : null}
        {!applications.error && applicationRows.length === 0 ? <p className="mt-4">{t('noApplications')}</p> : null}
        <div className="mt-4 flex flex-col gap-4">
          {applicationRows.map((row) => (
            <article key={row.id} className="rounded-lg border border-line bg-white p-4">
              <p className="font-semibold">{row.company_name}</p>
              <p className="mt-2 text-sm leading-6">
                {kindLabel(t, row.kind)} · {applicationStatus(t, row.status)}
              </p>
              <p className="mt-2 text-sm leading-6">
                {t('applicant')}: {emails.get(row.applicant_user_id) || t('noEmail')}
              </p>
              {row.kind !== 'new_company' ? (
                <p className="mt-2 text-sm leading-6">
                  {t('companyEmail')}: {row.company_email?.trim() ? row.company_email : t('noEmail')}
                </p>
              ) : null}
              <p className="mt-2 text-sm leading-6">{[row.city, row.state, row.postal_code, row.country_code].filter(Boolean).join(', ')}</p>
              <p className="mt-2 text-sm leading-6">
                {t('street')}: {row.street_address?.trim() ? row.street_address : '—'}
              </p>
              <p className="mt-1 text-sm text-muted">{t('streetHelp')}</p>
              {row.kind !== 'new_company' ? <EvidenceLinks t={t} row={row} urls={evidenceUrls} /> : null}
              {row.staff_note ? (
                <p className="mt-2 text-sm leading-6">
                  {t('note')}: {row.staff_note}
                </p>
              ) : null}
              <p className="mt-2 text-sm text-muted">{formatStamp(row.created_at, locale)}</p>
              {row.status === 'pending' ? <ReviewForm id={row.id} dispute={row.kind === 'dispute'} /> : null}
            </article>
          ))}
        </div>
      </section>

      <section className="mt-14">
        <h2 className="font-serif text-3xl font-semibold">{t('progress')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('progressHelp')}</p>
        {unlockedProjects.error || (deliveryOpen && leads.error) ? <p className="mt-4 font-semibold">{t('progressError')}</p> : null}
        {!unlockedProjects.error && !deliveryOpen ? <p className="mt-4 max-w-3xl leading-7">{t('progressLocked')}</p> : null}
        {deliveryOpen && !leads.error && projectRows.length === 0 && leadRows.length === 0 ? <p className="mt-4">{t('progressEmpty')}</p> : null}
        {deliveryOpen ? (
          <div className="mt-4 flex flex-col gap-3">
            {projectRows.map((project) => (
              <article key={project.id} className="rounded-lg border border-line bg-white p-4">
                <p className="font-semibold">{project.title}</p>
                <p className="mt-2 text-sm leading-6">{project.stage}</p>
                <p className="mt-2 text-sm text-muted">{formatStamp(project.created_at, locale)}</p>
              </article>
            ))}
            {leadRows.map((lead) => (
              <article key={lead.id} className="rounded-lg border border-line bg-white p-4">
                <p className="font-semibold">{lead.title}</p>
                <p className="mt-2 text-sm leading-6">{companyNames.get(lead.installer_id) ?? '—'}</p>
                <p className="mt-2 text-sm leading-6">{[lead.city, lead.state, lead.country_code].filter(Boolean).join(', ')}</p>
                <p className="mt-2 text-sm leading-6">{lead.status}</p>
                {lead.summary ? <p className="mt-2 text-sm leading-6">{lead.summary}</p> : null}
                <p className="mt-2 text-sm text-muted">{formatStamp(lead.created_at, locale)}</p>
              </article>
            ))}
          </div>
        ) : null}
      </section>

      <section className="mt-14">
        <h2 className="font-serif text-3xl font-semibold">{t('awards')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('awardsHelp')}</p>
        {awardedRfqs.error || quotes.error ? <p className="mt-4 font-semibold">{t('awardsError')}</p> : null}
        {!awardedRfqs.error && !quotes.error && awardRows.length === 0 ? <p className="mt-4 max-w-3xl leading-7">{t('awardsEmpty')}</p> : null}
        {!awardedRfqs.error && awardRows.length > 0 ? (
          <div className="mt-4 flex flex-col gap-3">
            {awardRows.map((award) => (
              <article key={award.id} className="rounded-lg border border-line bg-white p-4">
                <p className="font-semibold">{award.project_title}</p>
                <p className="mt-2 text-sm leading-6">{[award.city, award.state].filter(Boolean).join(', ')}</p>
                <p className="mt-2 text-sm leading-6">{award.status}</p>
                {quoteRows
                  .filter((quote) => quote.rfq_id === award.id)
                  .map((quote) => (
                    <p key={quote.id} className="mt-2 text-sm leading-6">
                      {quote.proposed_control_brand}
                      {quote.created_at ? ` · ${formatStamp(quote.created_at, locale)}` : ''}
                    </p>
                  ))}
                <p className="mt-2 text-sm text-muted">{formatStamp(award.created_at, locale)}</p>
              </article>
            ))}
          </div>
        ) : null}
      </section>

      <section className="mt-14">
        <h2 className="font-serif text-3xl font-semibold">{t('communications')}</h2>
        <p className="mt-3 max-w-3xl leading-7">{t('communicationsHelp')}</p>
        {communications.error ? <p className="mt-4 font-semibold">{t('communicationsError')}</p> : null}
        {!communications.error && communicationRows.length === 0 ? <p className="mt-4 max-w-3xl leading-7">{t('communicationsEmpty')}</p> : null}
        {!communications.error && communicationRows.length > 0 ? (
          <DataTable
            headers={[t('email'), t('company'), t('note'), t('created')]}
            rows={communicationRows.map((row) => [
              [emails.get(row.homeowner_user_id ?? ''), emails.get(row.installer_user_id ?? '')].filter(Boolean).join(' · ') || t('noEmail'),
              row.installer_id ? companyNames.get(row.installer_id) ?? '—' : '—',
              row.summary,
              formatStamp(row.created_at, locale)
            ])}
          />
        ) : null}
      </section>
    </ConsoleShell>
  );
}

function DataTable({ headers, rows }: { headers: string[]; rows: string[][] }) {
  return (
    <div className="mt-4 overflow-x-auto">
      <table className="w-full min-w-[36rem] border-collapse text-left text-sm">
        <thead>
          <tr className="border-b border-line">
            {headers.map((header) => (
              <th key={header} className="py-2 pr-4 font-semibold">
                {header}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((row, index) => (
            <tr key={`${row[0]}-${index}`} className="border-b border-line">
              {row.map((cell, cellIndex) => (
                <td key={`${headers[cellIndex]}-${cellIndex}`} className="py-3 pr-4 align-top">
                  {cell}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function EvidenceLinks({
  t,
  row,
  urls
}: {
  t: Awaited<ReturnType<typeof getTranslations>>;
  row: ApplicationRow;
  urls: Map<string, string>;
}) {
  const items = [
    [t('evidenceCard'), row.card_photo_path],
    [t('evidenceOffice'), row.office_photo_path],
    [t('evidenceExtra'), row.extra_evidence_path]
  ] as const;
  return (
    <div className="mt-3 flex flex-col gap-3">
      {items.map(([label, path]) => {
        if (!path) {
          return label === t('evidenceExtra') ? null : (
            <p key={label} className="text-sm leading-6">
              {label}: {t('evidenceMissing')}
            </p>
          );
        }
        const href = urls.get(path);
        return (
          <div key={label}>
            {href ? (
              <a href={href} className="text-sm font-semibold underline" rel="noreferrer" target="_blank">
                {label}
              </a>
            ) : (
              <p className="text-sm leading-6">
                {label}: {t('evidenceMissing')}
              </p>
            )}
            {href && /\.(jpg|png|webp)$/i.test(path) ? <img src={href} alt={label} className="mt-2 max-h-48 rounded border border-line" /> : null}
          </div>
        );
      })}
    </div>
  );
}

async function signEvidence(service: NonNullable<ReturnType<typeof getServiceClient>>, rows: ApplicationRow[]) {
  const urls = new Map<string, string>();
  const paths = rows.flatMap((row) => [row.card_photo_path, row.office_photo_path, row.extra_evidence_path].filter(claimEvidencePathOk));
  await Promise.all(
    [...new Set(paths)].map(async (path) => {
      const signed = await service.storage.from(CLAIM_EVIDENCE_BUCKET).createSignedUrl(path, 60 * 20);
      if (!signed.error && signed.data?.signedUrl) {
        urls.set(path, signed.data.signedUrl);
      }
    })
  );
  return urls;
}

async function loadEmails(service: NonNullable<ReturnType<typeof getServiceClient>>) {
  const emails = new Map<string, string | null>();
  for (let page = 1; page <= 20; page += 1) {
    const { data, error } = await service.auth.admin.listUsers({ page, perPage: 200 });
    if (error) {
      return { emails, error: true, truncated: false };
    }
    for (const user of data.users) {
      emails.set(user.id, user.email ?? null);
    }
    if (data.users.length < 200) {
      return { emails, error: false, truncated: false };
    }
  }
  return { emails, error: false, truncated: true };
}

type ProfileRow = {
  id: string;
  role: string;
  country_code: string | null;
  created_at: string | null;
};

type InstallerRow = {
  id: string;
  claimed_by_user_id: string | null;
  company_name: string;
  country_code: string;
  created_at: string | null;
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
  company_email: string | null;
  card_photo_path: string | null;
  office_photo_path: string | null;
  extra_evidence_path: string | null;
  status: string;
  staff_note: string | null;
  created_at: string;
};

type ProjectRow = {
  id: string;
  title: string;
  stage: string;
  created_at: string | null;
};

type LeadRow = {
  id: string;
  installer_id: string;
  title: string;
  city: string | null;
  state: string | null;
  country_code: string | null;
  status: string;
  summary: string | null;
  created_at: string;
};

type AwardRow = {
  id: string;
  project_title: string;
  city: string;
  state: string;
  status: string;
  created_at: string | null;
};

type QuoteRow = {
  id: string;
  rfq_id: string | null;
  proposed_control_brand: string;
  created_at: string | null;
};

type CommunicationRow = {
  id: string;
  homeowner_user_id: string | null;
  installer_user_id: string | null;
  installer_id: string | null;
  summary: string;
  created_at: string;
};

function roleLabel(t: Awaited<ReturnType<typeof getTranslations>>, role: string) {
  if (role === 'homeowner') return t('roleHomeowner');
  if (role === 'installer') return t('roleInstaller');
  if (role === 'architect') return t('roleArchitect');
  if (role === 'admin') return t('roleAdmin');
  return role;
}

function kindLabel(t: Awaited<ReturnType<typeof getTranslations>>, kind: string) {
  if (kind === 'claim') return t('kindClaim');
  if (kind === 'dispute') return t('kindDispute');
  return t('kindNew');
}

function applicationStatus(t: Awaited<ReturnType<typeof getTranslations>>, status: string) {
  if (status === 'pending') return t('statusPending');
  if (status === 'approved') return t('statusApproved');
  if (status === 'rejected') return t('statusRejected');
  return status;
}
