import type { Metadata } from 'next';
import { setRequestLocale } from 'next-intl/server';
import { LegalDocumentPage } from '@/components/legal/legal-document';
import { legalLang } from '@/content/app-store-pages';
import { isAppLocale } from '@/i18n/locale';
import { getSupabaseServerClient } from '@/lib/supabase/server';

export function generateMetadata({ params }: { params: { locale: string } }): Metadata {
  return params.locale === 'zh'
    ? { title: '隐私 — X Home Easy', description: 'X Home Easy 如何处理个人信息。' }
    : { title: 'Privacy — X Home Easy', description: 'How X Home Easy handles personal information.' };
}

export default async function PrivacyPage({ params }: { params: { locale: string } }) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const supabase = await getSupabaseServerClient();
  return <LegalDocumentPage page="privacy" lang={legalLang(locale)} databaseReady={supabase !== null} />;
}
