-- Website display locales are English and Chinese. German is no longer offered.

update public.profiles
set locale = 'en-US'
where locale = 'de-DE';

alter table public.profiles drop constraint if exists profiles_locale_check;

alter table public.profiles
  add constraint profiles_locale_check check (locale in ('en-US', 'zh-CN'));
