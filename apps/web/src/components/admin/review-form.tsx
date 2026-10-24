'use client';

import { useState } from 'react';
import { useTranslations } from 'next-intl';
import { useRouter } from '@/i18n/navigation';

export function ReviewForm({ id, dispute = false }: { id: string; dispute?: boolean }) {
  const t = useTranslations('Admin');
  const router = useRouter();
  const [note, setNote] = useState('');
  const [message, setMessage] = useState<string | null>(null);
  const [pending, setPending] = useState(false);

  async function send(decision: 'approved' | 'rejected') {
    setPending(true);
    setMessage(null);
    try {
      const response = await fetch('/api/admin/applications/review', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, decision, note })
      });
      const body = (await response.json().catch(() => null)) as { error?: string } | null;
      if (!response.ok) {
        setMessage(t(messageKey(body?.error)));
        setPending(false);
        return;
      }
      setMessage(t('reviewSaved'));
      router.refresh();
    } catch {
      setMessage(t('reviewFailed'));
      setPending(false);
    }
  }

  return (
    <div className="mt-3 flex flex-col gap-3">
      <label className="flex flex-col gap-1 text-sm font-semibold">
        {t('note')}
        <textarea
          value={note}
          onChange={(event) => setNote(event.target.value)}
          maxLength={2000}
          className="min-h-20 rounded-lg border border-ink bg-white px-3 py-2 text-base font-normal"
        />
      </label>
      {dispute ? <p className="text-sm leading-6">{t('disputeWarning')}</p> : null}
      <div className="flex flex-wrap gap-2">
        <button type="button" disabled={pending} onClick={() => send('approved').catch(() => setMessage(t('reviewFailed')))} className="min-h-11 rounded-full bg-ink px-4 text-sm font-semibold text-paper disabled:opacity-40">
          {t('approve')}
        </button>
        <button type="button" disabled={pending} onClick={() => send('rejected').catch(() => setMessage(t('reviewFailed')))} className="min-h-11 rounded-full border border-ink px-4 text-sm font-semibold disabled:opacity-40">
          {t('reject')}
        </button>
      </div>
      {message ? (
        <p role="status" className="font-semibold">
          {message}
        </p>
      ) : null}
    </div>
  );
}

function messageKey(
  error: string | undefined
): 'configBody' | 'forbidden' | 'claimed' | 'alreadyListed' | 'notPending' | 'notFound' | 'roleBlock' | 'missing' | 'reviewFailed' {
  switch (error) {
    case 'configuration':
      return 'configBody';
    case 'forbidden':
      return 'forbidden';
    case 'claimed':
      return 'claimed';
    case 'already_listed':
      return 'alreadyListed';
    case 'not_pending':
      return 'notPending';
    case 'not_found':
      return 'notFound';
    case 'role':
      return 'roleBlock';
    case 'missing':
      return 'missing';
    default:
      return 'reviewFailed';
  }
}
