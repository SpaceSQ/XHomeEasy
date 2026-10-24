import createMiddleware from 'next-intl/middleware';
import { createServerClient, type CookieOptions } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';
import { isStaffConsolePath, staffDeniedHtml } from './lib/admin/staff-gate';
import { routing } from './i18n/routing';

const handleI18n = createMiddleware(routing);

export default async function middleware(request: NextRequest) {
  const response = handleI18n(request);
  if (response.headers.has('location') || !isStaffConsolePath(request.nextUrl.pathname)) {
    return response;
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() ?? '';
  const anon = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() ?? '';
  if (!url || !anon) {
    return response;
  }

  const supabase = createServerClient(url, anon, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet: { name: string; value: string; options: CookieOptions }[]) {
        cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
        cookiesToSet.forEach(({ name, value, options }) => response.cookies.set(name, value, options));
      }
    }
  });

  try {
    const { data } = await supabase.auth.getUser();
    const user = data.user;
    if (!user) {
      return response;
    }
    const { data: profile } = await supabase.from('profiles').select('role').eq('id', user.id).maybeSingle();
    if (profile?.role !== 'admin') {
      return deny(request, response);
    }
  } catch {
    return deny(request, response);
  }

  return response;
}

function deny(request: NextRequest, response: NextResponse) {
  const locale = request.nextUrl.pathname.startsWith('/de') ? 'de' : 'en';
  const denied = new NextResponse(staffDeniedHtml(locale), {
    status: 403,
    headers: {
      'content-type': 'text/html; charset=utf-8',
      'cache-control': 'no-store',
      'x-robots-tag': 'noindex'
    }
  });
  for (const cookie of response.headers.getSetCookie()) {
    denied.headers.append('set-cookie', cookie);
  }
  return denied;
}

export const config = {
  matcher: ['/((?!api|_next|_vercel|.*\\..*).*)']
};
