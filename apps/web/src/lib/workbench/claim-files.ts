import 'server-only';

export const CLAIM_EVIDENCE_BUCKET = 'claim-evidence';

type ClaimStorage = {
  storage: {
    from(bucket: string): {
      upload(
        path: string,
        body: Uint8Array,
        options: { contentType: string; upsert: boolean }
      ): PromiseLike<{ error: { message: string } | null }>;
      remove(paths: string[]): PromiseLike<unknown>;
    };
  };
};

const maxBytes = 5 * 1024 * 1024;

const photoTypes: Record<string, string> = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp'
};

const extraTypes: Record<string, string> = {
  ...photoTypes,
  'application/pdf': 'pdf'
};

const evidencePath =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}-(card|office|extra)\.(jpg|png|webp|pdf)$/i;

export function claimEvidencePathOk(path: string | null): path is string {
  return Boolean(path && evidencePath.test(path));
}

export async function storeClaimFile(
  supabase: ClaimStorage,
  userId: string,
  file: File,
  label: 'card' | 'office' | 'extra'
): Promise<{ path: string } | { error: 'invalid' | 'upload' }> {
  const types = label === 'extra' ? extraTypes : photoTypes;
  const extension = types[file.type];
  if (!extension || file.size <= 0 || file.size > maxBytes) {
    return { error: 'invalid' };
  }
  const path = `${userId}/${crypto.randomUUID()}-${label}.${extension}`;
  const bytes = new Uint8Array(await file.arrayBuffer());
  const uploaded = await supabase.storage.from(CLAIM_EVIDENCE_BUCKET).upload(path, bytes, {
    contentType: file.type,
    upsert: false
  });
  if (uploaded.error) {
    return { error: 'upload' };
  }
  return { path };
}

export async function removeClaimFiles(supabase: ClaimStorage, paths: string[]) {
  const safe = paths.filter((path) => claimEvidencePathOk(path));
  if (safe.length === 0) {
    return;
  }
  await supabase.storage.from(CLAIM_EVIDENCE_BUCKET).remove(safe);
}
