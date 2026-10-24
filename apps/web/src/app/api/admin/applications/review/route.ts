import { NextResponse } from 'next/server';
import { getAccountContext } from '@/lib/account/context';
import { reviewApplication } from '@/lib/admin/review-application';
import { parseReviewBody } from '@/lib/workbench/application-input';

export const dynamic = 'force-dynamic';

const noStore = { 'cache-control': 'no-store' };

export async function POST(request: Request) {
  const body = parseReviewBody(await request.json().catch(() => null));
  if (!body) {
    return NextResponse.json({ error: 'missing' }, { status: 400, headers: noStore });
  }

  const account = await getAccountContext();
  if (!account.userId || account.role !== 'admin') {
    return NextResponse.json(
      {
        error: 'forbidden',
        message: 'Staff access is assigned in the database. This form cannot grant it.'
      },
      { status: 403, headers: noStore }
    );
  }

  const result = await reviewApplication({
    reviewerId: account.userId,
    applicationId: body.id,
    decision: body.decision,
    note: body.note
  });

  if (!result.ok) {
    const message =
      result.error === 'configuration'
        ? 'SUPABASE_SERVICE_ROLE_KEY is not configured. Approval was not saved.'
        : undefined;
    return NextResponse.json({ error: result.error, message }, { status: result.status, headers: noStore });
  }

  return NextResponse.json({ ok: true }, { headers: noStore });
}
