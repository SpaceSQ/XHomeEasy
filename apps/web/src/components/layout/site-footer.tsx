import { Link } from '@/i18n/navigation';
import { getLocale, getTranslations } from 'next-intl/server';

export async function SiteFooter({ databaseReady }: { databaseReady: boolean }) {
  const t = await getTranslations('Home');
  const safety = await getTranslations('Safety');
  const locale = await getLocale();

  return (
    <footer className="border-t border-line">
      <div className="mx-auto flex max-w-page flex-col gap-3 px-6 py-8 text-sm leading-6 text-muted">
        <p className="flex items-center gap-2 font-serif text-base font-semibold text-ink">
          <img src="/logo.png" alt="" width={28} height={28} className="h-7 w-7 object-contain" />
          {t('eyebrow')}
        </p>
        <nav aria-label="App Store" className="flex flex-wrap gap-4 font-semibold text-ink">
          <Link href="/support" className="underline decoration-ink/30 underline-offset-4">
            {locale === 'zh' ? '支持' : 'Support'}
          </Link>
          <Link href="/privacy" className="underline decoration-ink/30 underline-offset-4">
            {locale === 'zh' ? '隐私' : 'Privacy'}
          </Link>
        </nav>
        <p lang="en">{safety('trademark')}</p>
        <p>{safety(locale === 'zh' ? 'disclaimerZh' : 'disclaimerEn')}</p>
        <p>{databaseReady ? t('dbReady') : t('dbAwaitingKey')}</p>
      </div>
    </footer>
  );
}
