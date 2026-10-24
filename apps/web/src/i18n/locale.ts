import type { AppLocale } from './routing';

export function toBcp47(locale: string): 'en-US' | 'de-DE' {
  return locale === 'de' ? 'de-DE' : 'en-US';
}

export function isAppLocale(value: string): value is AppLocale {
  return value === 'de' || value === 'en';
}
