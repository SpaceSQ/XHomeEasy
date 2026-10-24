import 'server-only';

export const STAFF_ACCOUNT_NAME = 'admin';

/** Mailbox for the staff account name. The password is not stored here. */
export const STAFF_AUTH_EMAIL = 'admin@staff.xhomeeasy.example';

export function staffAuthEmailForAccountName(accountName: string): string | null {
  if (accountName.trim() !== STAFF_ACCOUNT_NAME) {
    return null;
  }
  return STAFF_AUTH_EMAIL;
}
