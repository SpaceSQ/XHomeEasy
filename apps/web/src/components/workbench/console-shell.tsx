import type { ReactNode } from 'react';
import { LegalLines } from '@/components/compliance/legal-lines';
import { SiteFooter } from '@/components/layout/site-footer';
import { SiteHeader } from '@/components/layout/site-header';
import { getSupabaseServerClient } from '@/lib/supabase/server';

export async function ConsoleShell({ children }: { children: ReactNode }) {
  const supabase = await getSupabaseServerClient();

  return (
    <>
      <SiteHeader />
      <main id="content" className="mx-auto max-w-page px-6 py-16">
        {children}
        <LegalLines />
      </main>
      <SiteFooter databaseReady={supabase !== null} />
    </>
  );
}
