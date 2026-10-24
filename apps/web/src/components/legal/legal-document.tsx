import { SiteFooter } from '@/components/layout/site-footer';
import { SiteHeader } from '@/components/layout/site-header';
import { legalDocument, type LegalLang } from '@/content/app-store-pages';
import { Link } from '@/i18n/navigation';
import type { AppLocale } from '@/i18n/routing';

export function LegalDocumentPage({
  page,
  lang,
  databaseReady
}: {
  page: 'support' | 'privacy';
  lang: LegalLang;
  databaseReady: boolean;
}) {
  const document = legalDocument(page, lang);
  const other = page === 'support' ? 'privacy' : 'support';
  const otherLabel = lang === 'zh' ? (other === 'privacy' ? '隐私' : '支持') : other === 'privacy' ? 'Privacy' : 'Support';
  const languageLabel = lang === 'zh' ? '语言' : 'Language';

  return (
    <>
      <SiteHeader />
      <main id="content" lang={lang === 'zh' ? 'zh-Hans' : 'en'} className="mx-auto max-w-page px-6 py-16">
        <div className="flex flex-wrap items-center justify-between gap-4">
          <p className="text-sm font-semibold uppercase tracking-[0.14em] text-brass">{document.kicker}</p>
          <nav aria-label={languageLabel} className="flex items-center gap-3 text-sm font-semibold">
            <Link
              href={`/${page}`}
              locale="en"
              hrefLang="en-US"
              aria-current={lang === 'en' ? 'page' : undefined}
              className={lang === 'en' ? 'underline decoration-2 underline-offset-4' : 'text-muted underline decoration-ink/30 underline-offset-4'}
            >
              English
            </Link>
            <Link
              href={`/${page}`}
              locale="zh"
              hrefLang="zh-CN"
              aria-current={lang === 'zh' ? 'page' : undefined}
              className={lang === 'zh' ? 'underline decoration-2 underline-offset-4' : 'text-muted underline decoration-ink/30 underline-offset-4'}
            >
              中文
            </Link>
          </nav>
        </div>
        <h1 className="mt-3 max-w-3xl font-serif text-4xl font-semibold tracking-tight">{document.title}</h1>
        <p className="mt-4 text-sm text-muted">{document.updated}</p>
        <div className="mt-10 flex max-w-3xl flex-col gap-8">
          {document.sections.map((section) => (
            <section key={section.heading} className="flex flex-col gap-3">
              <h2 className="font-serif text-2xl font-semibold">{section.heading}</h2>
              {section.paragraphs.map((paragraph) => (
                <p key={paragraph} className="leading-8 text-ink">
                  {paragraph}
                </p>
              ))}
            </section>
          ))}
        </div>
        <p className="mt-10">
          <Link href={`/${other}`} locale={lang satisfies AppLocale} className="inline-flex min-h-11 items-center font-semibold underline decoration-ink/30 underline-offset-4">
            {otherLabel}
          </Link>
        </p>
      </main>
      <SiteFooter databaseReady={databaseReady} />
    </>
  );
}

