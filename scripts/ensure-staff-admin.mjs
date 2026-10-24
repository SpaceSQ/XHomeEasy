import { createClient } from '../apps/web/node_modules/@supabase/supabase-js/dist/index.mjs';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';

const STAFF_AUTH_EMAIL = 'admin@staff.xhomeeasy.example';
const EXPECTED_REF = 'ixhryheqitsdflzxsifo';
const FORBIDDEN_REF = 'dvnnppisrgiyyvcvfoom';

function loadEnv(file) {
  const out = {};
  for (const line of readFileSync(file, 'utf8').split('\n')) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#') || !trimmed.includes('=')) {
      continue;
    }
    const index = trimmed.indexOf('=');
    const key = trimmed.slice(0, index);
    let value = trimmed.slice(index + 1).trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    out[key] = value;
  }
  return out;
}

function redact(text, secrets) {
  let output = String(text);
  for (const secret of secrets) {
    if (secret) {
      output = output.split(secret).join('[redacted]');
    }
  }
  return output;
}

const env = loadEnv(resolve('apps/web/.env.local'));
const url = env.NEXT_PUBLIC_SUPABASE_URL || '';
const key = env.SUPABASE_SERVICE_ROLE_KEY || '';
const password = process.env.STAFF_INITIAL_PASSWORD || '';
const secrets = [key, password, env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''];

if (!url.includes(EXPECTED_REF) || url.includes(FORBIDDEN_REF)) {
  console.error('refused: wrong project');
  process.exit(1);
}
if (!key || !password) {
  console.error('missing server configuration');
  process.exit(1);
}

const admin = createClient(url, key, {
  auth: { persistSession: false, autoRefreshToken: false }
});

async function findUser() {
  for (let page = 1; page <= 20; page += 1) {
    const { data, error } = await admin.auth.admin.listUsers({ page, perPage: 200 });
    if (error) {
      throw new Error(redact(error.message, secrets));
    }
    const found = data.users.find((user) => user.email?.toLowerCase() === STAFF_AUTH_EMAIL);
    if (found) {
      return found;
    }
    if (data.users.length < 200) {
      return null;
    }
  }
  return null;
}

const existing = await findUser();
let userId;
if (!existing) {
  const created = await admin.auth.admin.createUser({
    email: STAFF_AUTH_EMAIL,
    password,
    email_confirm: true,
    app_metadata: { role: 'admin' }
  });
  if (created.error || !created.data.user) {
    console.error('create failed', redact(created.error?.message || 'unknown', secrets));
    process.exit(1);
  }
  userId = created.data.user.id;
  console.log('staff auth user created');
} else {
  const updated = await admin.auth.admin.updateUserById(existing.id, {
    password,
    email_confirm: true,
    app_metadata: { role: 'admin' }
  });
  if (updated.error) {
    console.error('password update failed', redact(updated.error.message, secrets));
    process.exit(1);
  }
  userId = existing.id;
  console.log('staff auth user already existed; initial password set once');
}

let profile = await admin.from('profiles').update({ role: 'admin' }).eq('id', userId).select('role').maybeSingle();
if (profile.error || profile.data?.role !== 'admin') {
  profile = await admin.from('profiles').upsert({ id: userId, role: 'admin' }).select('role').maybeSingle();
}
let roleReady = false;
if (profile.error || profile.data?.role !== 'admin') {
  const message = profile.error?.message || 'role was not admin';
  if (/schema cache|does not exist|relation/i.test(message)) {
    console.log('staff auth user is ready; profile role waits for the account migration');
  } else {
    console.error('profile failed', redact(message, secrets));
    process.exit(1);
  }
} else {
  roleReady = true;
  console.log('profiles.role is admin');
}

const bucket = await admin.storage.createBucket('claim-evidence', {
  public: false,
  fileSizeLimit: 5242880,
  allowedMimeTypes: ['image/jpeg', 'image/png', 'image/webp', 'application/pdf']
});
if (bucket.error && !/already exists/i.test(bucket.error.message)) {
  const updatedBucket = await admin.storage.updateBucket('claim-evidence', {
    public: false,
    fileSizeLimit: 5242880,
    allowedMimeTypes: ['image/jpeg', 'image/png', 'image/webp', 'application/pdf']
  });
  if (updatedBucket.error) {
    console.error('bucket failed', redact(updatedBucket.error.message, secrets));
    process.exit(1);
  }
}

if (roleReady) {
  console.log('private claim-evidence bucket ensured');
} else {
  console.log('private claim-evidence bucket ensured; profiles.role waits for the account migration');
}
