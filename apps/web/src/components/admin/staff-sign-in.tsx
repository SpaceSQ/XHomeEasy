'use client';

import { FormEvent, useState } from 'react';
import { useTranslations } from 'next-intl';
import { useRouter } from '@/i18n/navigation';

export function StaffSignIn() {
  const t = useTranslations('Admin');
  const router = useRouter();
  const [account, setAccount] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState<string | null>(null);
  const [pending, setPending] = useState(false);

  async function submit(event: FormEvent) {
    event.preventDefault();
    setMessage(null);
    setPending(true);
    try {
      const response = await fetch('/api/admin/session', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ account, password })
      });
      if (!response.ok) {
        setMessage(t('staffFailed'));
        setPending(false);
        return;
      }
      setPassword('');
      router.refresh();
    } catch {
      setMessage(t('staffFailed'));
      setPending(false);
    }
  }

  return (
    <form onSubmit={(event) => submit(event).catch(() => setMessage(t('staffFailed')))} className="mt-8 flex max-w-xl flex-col gap-4">
      <p className="leading-7">{t('accountHelp')}</p>
      <label className="flex flex-col gap-1 text-sm font-semibold">
        {t('accountName')}
        <input
          autoComplete="username"
          value={account}
          onChange={(event) => setAccount(event.target.value)}
          className="min-h-11 rounded-lg border border-ink bg-white px-3 text-base font-normal"
        />
      </label>
      <label className="flex flex-col gap-1 text-sm font-semibold">
        {t('staffPassword')}
        <input
          type="password"
          autoComplete="current-password"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          className="min-h-11 rounded-lg border border-ink bg-white px-3 text-base font-normal"
        />
      </label>
      <button
        type="submit"
        disabled={pending}
        className="inline-flex min-h-11 items-center self-start rounded-full bg-ink px-5 py-3 text-sm font-semibold text-paper disabled:opacity-40"
      >
        {t('staffSubmit')}
      </button>
      {message ? (
        <p className="font-semibold" role="status">
          {message}
        </p>
      ) : null}
    </form>
  );
}
