import { getLocale, getTranslations } from 'next-intl/server';

export async function LegalLines() {
  const safety = await getTranslations('Safety');
  const locale = await getLocale();

  return (
    <div className="mt-12 space-y-2 text-sm leading-6 text-muted">
      <p>{locale === 'zh' ? safety('disclaimerZh') : safety('disclaimerEn')}</p>
    </div>
  );
}
