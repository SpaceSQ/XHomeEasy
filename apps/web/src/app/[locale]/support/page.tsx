import type { Metadata } from 'next';
import { setRequestLocale } from 'next-intl/server';
import { LegalDocumentPage } from '@/components/legal/legal-document';
import { legalLang } from '@/content/app-store-pages';
import { isAppLocale } from '@/i18n/locale';
import { getSupabaseServerClient } from '@/lib/supabase/server';

export function generateMetadata({ params }: { params: { locale: string } }): Metadata {
  return params.locale === 'zh'
    ? { title: '支持 — X Home Easy', description: 'X Home Easy 的支持与联系方式。' }
    : { title: 'Support — X Home Easy', description: 'Support and contact for X Home Easy.' };
}

export default async function SupportPage({ params }: { params: { locale: string } }) {
  const locale = isAppLocale(params.locale) ? params.locale : 'en';
  setRequestLocale(locale);
  const supabase = await getSupabaseServerClient();
  return <LegalDocumentPage page="support" lang={legalLang(locale)} databaseReady={supabase !== null} />;
}
