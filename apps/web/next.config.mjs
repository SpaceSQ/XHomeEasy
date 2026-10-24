import createNextIntlPlugin from 'next-intl/plugin';

const withNextIntl = createNextIntlPlugin('./src/i18n/request.ts');

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ['@xhomeeasy/shared-types', '@xhomeeasy/scoring-engine'],
  poweredByHeader: false
};

export default withNextIntl(nextConfig);
