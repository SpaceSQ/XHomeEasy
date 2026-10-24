const uuidPattern = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export type ApplicationKind = 'claim' | 'new_company' | 'dispute';
export type CountryCode = 'US' | 'CA';

export type ApplicationInput = {
  kind: ApplicationKind;
  companyName: string;
  city: string;
  state: string;
  postalCode: string;
  countryCode: CountryCode;
  streetAddress: string | null;
  website: string | null;
  targetInstallerId: string | null;
  companyEmail: string | null;
};

export type ReviewInput = {
  id: string;
  decision: 'approved' | 'rejected';
  note: string | null;
};

function requiredText(value: unknown, max: number): string | null {
  if (typeof value !== 'string') {
    return null;
  }
  const trimmed = value.trim();
  if (!trimmed || trimmed.length > max) {
    return null;
  }
  return trimmed;
}

function requiredEmail(value: unknown): string | null {
  if (typeof value !== 'string') {
    return null;
  }
  const trimmed = value.trim();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(trimmed) || trimmed.length > 200) {
    return null;
  }
  return trimmed;
}

function optionalText(value: unknown, max: number, allowSpaces: boolean): string | null | undefined {
  if (value == null || value === '') {
    return null;
  }
  if (typeof value !== 'string') {
    return undefined;
  }
  const trimmed = value.trim();
  if (!trimmed) {
    return null;
  }
  if (trimmed.length > max || (!allowSpaces && /\s/.test(trimmed))) {
    return undefined;
  }
  return trimmed;
}

export function parseApplicationBody(body: unknown): ApplicationInput | null {
  if (!body || typeof body !== 'object') {
    return null;
  }
  const record = body as Record<string, unknown>;
  if (record.kind !== 'claim' && record.kind !== 'new_company' && record.kind !== 'dispute') {
    return null;
  }
  const state = requiredText(record.state, 80);
  const streetAddress = optionalText(record.streetAddress, 200, true);
  const website = optionalText(record.website, 300, false);
  const countryRaw = typeof record.countryCode === 'string' ? record.countryCode.trim().toUpperCase() : '';
  if (!state || streetAddress === undefined || website === undefined || (countryRaw !== 'US' && countryRaw !== 'CA')) {
    return null;
  }

  if (record.kind === 'claim' || record.kind === 'dispute') {
    const companyEmail = requiredEmail(record.companyEmail);
    if (!companyEmail || typeof record.targetInstallerId !== 'string' || !uuidPattern.test(record.targetInstallerId)) {
      return null;
    }
    return {
      kind: record.kind,
      companyName: '',
      city: '',
      state,
      postalCode: '',
      countryCode: countryRaw,
      streetAddress,
      website,
      targetInstallerId: record.targetInstallerId,
      companyEmail
    };
  }

  const companyName = requiredText(record.companyName, 160);
  const city = requiredText(record.city, 120);
  const postalCode = requiredText(record.postalCode, 20);
  if (!companyName || !city || !postalCode) {
    return null;
  }
  return {
    kind: 'new_company',
    companyName,
    city,
    state,
    postalCode,
    countryCode: countryRaw,
    streetAddress,
    website,
    targetInstallerId: null,
    companyEmail: null
  };
}

export function parseReviewBody(body: unknown): ReviewInput | null {
  if (!body || typeof body !== 'object') {
    return null;
  }
  const record = body as Record<string, unknown>;
  if (typeof record.id !== 'string' || !uuidPattern.test(record.id)) {
    return null;
  }
  if (record.decision !== 'approved' && record.decision !== 'rejected') {
    return null;
  }
  if (record.note == null || record.note === '') {
    return { id: record.id, decision: record.decision, note: null };
  }
  if (typeof record.note !== 'string') {
    return null;
  }
  const note = record.note.trim();
  if (note.length > 2000) {
    return null;
  }
  return { id: record.id, decision: record.decision, note: note || null };
}
