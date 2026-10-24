'use client';

import { FormEvent, useMemo, useRef, useState, type RefObject } from 'react';
import { useTranslations } from 'next-intl';
import { useRouter } from '@/i18n/navigation';

export type DirectoryCompany = {
  id: string;
  companyName: string;
  city: string;
  postalCode: string;
  countryCode: 'US' | 'CA';
  rank: string;
  contactWithheld: boolean;
};

type Mode = 'claim' | 'new_company';

const inputClass = 'min-h-11 rounded-lg border border-ink bg-white px-3 text-base font-normal';

export function ApplyForm({ companies, hasListing }: { companies: DirectoryCompany[]; hasListing: boolean | null }) {
  const t = useTranslations('Workbench');
  const router = useRouter();
  const [mode, setMode] = useState<Mode>(companies.length > 0 ? 'claim' : 'new_company');
  const [query, setQuery] = useState('');
  const [selectedId, setSelectedId] = useState(companies[0]?.id ?? '');
  const [companyName, setCompanyName] = useState('');
  const [city, setCity] = useState('');
  const [state, setState] = useState('');
  const [postalCode, setPostalCode] = useState('');
  const [countryCode, setCountryCode] = useState<'US' | 'CA'>('US');
  const [streetAddress, setStreetAddress] = useState('');
  const [website, setWebsite] = useState('');
  const [companyEmail, setCompanyEmail] = useState('');
  const [message, setMessage] = useState<string | null>(null);
  const [maskedEmail, setMaskedEmail] = useState<string | null>(null);
  const [pending, setPending] = useState(false);
  const cardRef = useRef<HTMLInputElement>(null);
  const officeRef = useRef<HTMLInputElement>(null);
  const extraRef = useRef<HTMLInputElement>(null);

  const visible = useMemo(() => {
    const needle = query.trim().toLowerCase();
    if (!needle) {
      return companies;
    }
    return companies.filter((company) =>
      [company.companyName, company.city, company.postalCode, company.countryCode].join(' ').toLowerCase().includes(needle)
    );
  }, [companies, query]);

  const selected = companies.find((company) => company.id === selectedId) ?? null;

  async function submit(event: FormEvent | null, kind: Mode | 'dispute') {
    event?.preventDefault();
    setMessage(null);
    if (kind !== 'dispute') {
      setMaskedEmail(null);
    }
    if (!state.trim()) {
      setMessage(t('missing'));
      return;
    }
    if ((kind === 'claim' || kind === 'dispute') && !selected) {
      setMessage(t('pickMissing'));
      return;
    }
    if (kind === 'new_company' && (!companyName.trim() || !city.trim() || !postalCode.trim())) {
      setMessage(t('missing'));
      return;
    }
    if (kind === 'new_company' && hasListing !== false) {
      setMessage(hasListing ? t('alreadyListed') : t('listingUnknown'));
      return;
    }
    if (kind === 'claim' || kind === 'dispute') {
      if (!companyEmail.includes('@')) {
        setMessage(t('evidenceMissing'));
        return;
      }
      const card = cardRef.current?.files?.[0];
      const office = officeRef.current?.files?.[0];
      if (!card || !office) {
        setMessage(t('evidenceMissing'));
        return;
      }
    }
    setPending(true);
    const form = new FormData();
    form.set('kind', kind);
    form.set('state', state);
    form.set('streetAddress', streetAddress);
    form.set('website', website);
    if (kind === 'claim' || kind === 'dispute') {
      form.set('targetInstallerId', selected?.id ?? '');
      form.set('countryCode', selected?.countryCode ?? 'US');
      form.set('companyEmail', companyEmail);
      const card = cardRef.current?.files?.[0];
      const office = officeRef.current?.files?.[0];
      const extra = extraRef.current?.files?.[0];
      if (card) form.set('cardPhoto', card);
      if (office) form.set('officePhoto', office);
      if (extra && extra.size > 0) form.set('extraEvidence', extra);
    } else {
      form.set('companyName', companyName);
      form.set('city', city);
      form.set('postalCode', postalCode);
      form.set('countryCode', countryCode);
    }
    try {
      const response = await fetch('/api/workbench/applications', { method: 'POST', body: form });
      const body = (await response.json().catch(() => null)) as { error?: string; maskedEmail?: string } | null;
      if (!response.ok) {
        if (body?.error === 'already_claimed') {
          setMaskedEmail(body.maskedEmail?.trim() ? body.maskedEmail : '**');
          setPending(false);
          return;
        }
        setMessage(t(errorKey(body?.error)));
        setPending(false);
        return;
      }
      router.push('/workbench?submitted=1');
      router.refresh();
    } catch {
      setMessage(t('failed'));
      setPending(false);
    }
  }

  return (
    <form onSubmit={(event) => submit(event, mode).catch(() => setMessage(t('failed')))} className="flex max-w-3xl flex-col gap-6">
      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          aria-pressed={mode === 'claim'}
          className={mode === 'claim' ? 'min-h-11 rounded-full bg-ink px-4 text-sm font-semibold text-paper' : 'min-h-11 rounded-full border border-ink px-4 text-sm font-semibold'}
          onClick={() => {
            setMode('claim');
            setMaskedEmail(null);
          }}
        >
          {t('modeClaim')}
        </button>
        <button
          type="button"
          aria-pressed={mode === 'new_company'}
          className={mode === 'new_company' ? 'min-h-11 rounded-full bg-ink px-4 text-sm font-semibold text-paper' : 'min-h-11 rounded-full border border-ink px-4 text-sm font-semibold'}
          onClick={() => {
            setMode('new_company');
            setMaskedEmail(null);
          }}
        >
          {t('modeNew')}
        </button>
      </div>
      <p className="leading-7 text-muted">{t('notStaff')}</p>
      <p className="text-sm leading-6 text-muted">{t('streetHelp')}</p>
      {mode === 'claim' ? (
        <div className="flex flex-col gap-3">
          <p className="leading-7">{t('claimCaution')}</p>
          <p className="leading-7">{t('evidenceHelp')}</p>
          <p className="text-sm leading-6 text-muted">{t('evidencePrivate')}</p>
          <label className="flex flex-col gap-1 text-sm font-semibold">
            {t('search')}
            <input value={query} onChange={(event) => setQuery(event.target.value)} className={inputClass} />
          </label>
          {companies.length === 0 ? <p>{t('directoryEmpty')}</p> : null}
          <fieldset className="flex max-h-96 flex-col gap-2 overflow-y-auto">
            <legend className="mb-2 text-sm font-semibold">{t('pick')}</legend>
            {visible.map((company) => (
              <label key={company.id} className="flex gap-3 rounded-lg border border-line bg-white p-3">
                <input
                  type="radio"
                  name="listed-company"
                  value={company.id}
                  checked={selectedId === company.id}
                  onChange={() => {
                    setSelectedId(company.id);
                    setMaskedEmail(null);
                  }}
                />
                <span>
                  <span className="font-semibold">{company.companyName}</span>
                  <span className="mt-1 block text-sm text-muted">
                    {[company.city, company.postalCode, company.countryCode].filter(Boolean).join(', ')} · {company.rank}
                  </span>
                  {company.contactWithheld ? <span className="mt-1 block text-sm">{t('silverHidden')}</span> : null}
                </span>
              </label>
            ))}
          </fieldset>
          <Field label={t('companyEmail')} value={companyEmail} onChange={setCompanyEmail} type="email" />
          <FileField label={t('cardPhoto')} inputRef={cardRef} accept="image/jpeg,image/png,image/webp" />
          <FileField label={t('officePhoto')} inputRef={officeRef} accept="image/jpeg,image/png,image/webp" />
          <FileField label={t('extraEvidence')} inputRef={extraRef} accept="image/jpeg,image/png,image/webp,application/pdf" />
        </div>
      ) : (
        <div className="flex flex-col gap-4">
          {hasListing === true ? <p>{t('hasListing')}</p> : null}
          {hasListing === null ? <p>{t('listingUnknown')}</p> : null}
          <Field label={t('company')} value={companyName} onChange={setCompanyName} />
          <Field label={t('city')} value={city} onChange={setCity} />
          <Field label={t('postal')} value={postalCode} onChange={setPostalCode} />
          <label className="flex flex-col gap-1 text-sm font-semibold">
            {t('country')}
            <select value={countryCode} onChange={(event) => setCountryCode(event.target.value === 'CA' ? 'CA' : 'US')} className={inputClass}>
              <option value="US">{t('countryUS')}</option>
              <option value="CA">{t('countryCA')}</option>
            </select>
          </label>
        </div>
      )}
      <Field label={t('state')} value={state} onChange={setState} />
      <Field label={t('streetOptional')} value={streetAddress} onChange={setStreetAddress} />
      <Field label={t('websiteOptional')} value={website} onChange={setWebsite} />
      <button
        type="submit"
        disabled={pending || (mode === 'new_company' && hasListing !== false) || (mode === 'claim' && companies.length === 0)}
        className="inline-flex min-h-11 items-center self-start rounded-full bg-ink px-5 py-3 text-sm font-semibold text-paper disabled:opacity-40"
      >
        {mode === 'claim' ? t('submitClaim') : t('submitNew')}
      </button>
      {maskedEmail ? (
        <div className="flex flex-col gap-3">
          <p role="status" className="font-semibold leading-7">
            {t('alreadyClaimed', { email: maskedEmail })}
          </p>
          <button
            type="button"
            disabled={pending}
            onClick={() => submit(null, 'dispute').catch(() => setMessage(t('failed')))}
            className="inline-flex min-h-11 items-center self-start rounded-full border border-ink px-5 py-3 text-sm font-semibold disabled:opacity-40"
          >
            {t('submitDispute')}
          </button>
        </div>
      ) : null}
      {message ? (
        <p role="status" className="font-semibold">
          {message}
        </p>
      ) : null}
    </form>
  );
}

function Field({
  label,
  value,
  onChange,
  type = 'text'
}: {
  label: string;
  value: string;
  onChange: (value: string) => void;
  type?: string;
}) {
  return (
    <label className="flex flex-col gap-1 text-sm font-semibold">
      {label}
      <input type={type} value={value} onChange={(event) => onChange(event.target.value)} className={inputClass} />
    </label>
  );
}

function FileField({ label, inputRef, accept }: { label: string; inputRef: RefObject<HTMLInputElement>; accept: string }) {
  return (
    <label className="flex flex-col gap-1 text-sm font-semibold">
      {label}
      <input ref={inputRef} type="file" accept={accept} className="text-sm font-normal" />
    </label>
  );
}

function errorKey(
  error: string | undefined
): 'missing' | 'session' | 'roleDenied' | 'unavailable' | 'duplicate' | 'target' | 'alreadyListed' | 'evidenceMissing' | 'notDisputable' | 'failed' {
  switch (error) {
    case 'missing':
      return 'missing';
    case 'session':
      return 'session';
    case 'role':
      return 'roleDenied';
    case 'unavailable':
      return 'unavailable';
    case 'duplicate':
      return 'duplicate';
    case 'target':
      return 'target';
    case 'already_listed':
      return 'alreadyListed';
    case 'evidence':
      return 'evidenceMissing';
    case 'not_disputable':
      return 'notDisputable';
    default:
      return 'failed';
  }
}
