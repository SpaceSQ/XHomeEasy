import type { AppLocale } from './routing';

export function toBcp47(locale: string): 'en-US' | 'zh-CN' {
  return locale === 'zh' ? 'zh-CN' : 'en-US';
}

export function isAppLocale(value: string): value is AppLocale {
  return value === 'zh' || value === 'en';
}
