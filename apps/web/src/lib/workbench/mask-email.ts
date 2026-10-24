export function maskEmail(email: string | null | undefined): string {
  if (!email) {
    return '**';
  }
  const trimmed = email.trim();
  const at = trimmed.lastIndexOf('@');
  if (at <= 0 || at === trimmed.length - 1) {
    return '**';
  }
  const local = trimmed.slice(0, at);
  const domain = trimmed.slice(at + 1);
  if (!domain || /\s/.test(local) || /\s/.test(domain)) {
    return '**';
  }
  if (local.length < 2) {
    return `**@${domain}`;
  }
  return `${local[0]}**${local[local.length - 1]}@${domain}`;
}
