import { getTranslations } from 'next-intl/server';

export async function LegalLines() {
  const safety = await getTranslations('Safety');

  return (
    <div className="mt-12 space-y-2 text-sm leading-6 text-muted">
      <p>{safety('disclaimerDe')}</p>
      <p lang="en">{safety('disclaimerEn')}</p>
    </div>
  );
}
