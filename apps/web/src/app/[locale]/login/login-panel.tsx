'use client';

import { useEffect, useState } from 'react';
import QRCode from 'qrcode';
import { useTranslations } from 'next-intl';
import { Link, useRouter } from '@/i18n/navigation';
import { pathAfterSignIn } from '@/lib/account/after-sign-in';
import { pairPayload, type AccountRole } from '@/lib/login-pair';
import { getSupabaseBrowserClient } from '@/lib/supabase/client';

export function LoginPanel() {
  const t = useTranslations('Login');
  const router = useRouter();
  const [image, setImage] = useState<string | null>(null);
  const [status, setStatus] = useState<'loading' | 'pending' | 'ready' | 'expired' | 'error'>('loading');
  const [email, setEmail] = useState<string | null>(null);
  const [desk, setDesk] = useState<'/manage' | '/workbench'>('/manage');

  useEffect(() => {
    let stopped = false;
    let timer: ReturnType<typeof setInterval> | undefined;

    async function start() {
      setStatus('loading');
      setImage(null);
      setEmail(null);
      const created = await fetch('/api/login-challenges', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ role: 'homeowner' satisfies AccountRole })
      });
      if (!created.ok) {
        if (!stopped) {
          setStatus('error');
        }
        return;
      }
      const payload = (await created.json()) as { id: string; secret: string; role: AccountRole };
      const dataUrl = await QRCode.toDataURL(pairPayload(payload.role, payload.id, payload.secret), {
        margin: 1,
        width: 280
      });
      if (stopped) {
        return;
      }
      setImage(dataUrl);
      setStatus('pending');
      timer = setInterval(async () => {
        const response = await fetch('/api/login-challenges/status', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ id: payload.id, secret: payload.secret })
        });
        const body = (await response.json().catch(() => null)) as { status?: string; tokenHash?: string } | null;
        if (!body || stopped) {
          return;
        }
        if (body.status === 'expired' || body.status === 'consumed') {
          setStatus('expired');
          if (timer) {
            clearInterval(timer);
          }
        }
        if (body.status === 'ready' && body.tokenHash) {
          if (timer) {
            clearInterval(timer);
          }
          const supabase = getSupabaseBrowserClient();
          if (!supabase) {
            setStatus('error');
            return;
          }
          const { data, error } = await supabase.auth.verifyOtp({
            token_hash: body.tokenHash,
            type: 'magiclink'
          });
          if (error) {
            setStatus('error');
            return;
          }
          setEmail(data.user?.email ?? null);
          const next = await pathAfterSignIn();
          setDesk(next);
          setStatus('ready');
          router.push(next);
          router.refresh();
        }
      }, 2000);
    }

    start().catch(() => {
      if (!stopped) {
        setStatus('error');
      }
    });

    return () => {
      stopped = true;
      if (timer) {
        clearInterval(timer);
      }
    };
  }, [router]);

  return (
    <div className="mx-auto flex max-w-xl flex-col gap-6">
      <h2 className="font-serif text-2xl font-semibold">{t('scanTitle')}</h2>
      <p className="leading-7 text-muted">{t('scanLede')}</p>
      {image ? (
        <img src={image} alt={t('qrAlt')} width={280} height={280} className="h-auto w-[280px] border border-line bg-white p-3" />
      ) : null}
      <p className="font-semibold" role="status">
        {t(status)}
      </p>
      {email ? (
        <p className="leading-7">
          {t('signedIn', { email })}{' '}
          <Link href={desk} className="font-semibold underline decoration-ink/30 underline-offset-4">
            {t('openDesk')}
          </Link>
        </p>
      ) : null}
    </div>
  );
}
