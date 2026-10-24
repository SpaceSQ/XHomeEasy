import type { ReactNode } from 'react';
import { Source_Sans_3, Source_Serif_4 } from 'next/font/google';
import { notFound } from 'next/navigation';
import { NextIntlClientProvider } from 'next-intl';
import { getMessages, getTranslations, setRequestLocale } from 'next-intl/server';
import { EntranceSplash } from '@/components/splash/entrance-splash';
import { isAppLocale, toBcp47 } from '@/i18n/locale';
import { routing } from '@/i18n/routing';
import '../globals.css';

const sans = Source_Sans_3({
  subsets: ['latin'],
  variable: '--font-sans',
  display: 'swap'
});

const serif = Source_Serif_4({
  subsets: ['latin'],
  variable: '--font-serif',
  display: 'swap'
});

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

export default async function LocaleLayout({
  children,
  params
}: {
  children: ReactNode;
  params: { locale: string };
}) {
  if (!isAppLocale(params.locale)) {
    notFound();
  }

  setRequestLocale(params.locale);
  const messages = await getMessages();
  const splash = await getTranslations('Splash');

  return (
    <html lang={toBcp47(params.locale)} className={`${sans.variable} ${serif.variable}`}>
      <body>
        <NextIntlClientProvider messages={messages}>
          <EntranceSplash skipLabel={splash('skip')} />
          {children}
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
