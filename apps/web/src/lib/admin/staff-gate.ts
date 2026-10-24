const staffPath = /^\/(?:(?:en|zh)\/)?admin(?:\/|$)/;

export function isStaffConsolePath(pathname: string): boolean {
  return staffPath.test(pathname);
}

export function staffDeniedHtml(locale: 'en' | 'zh'): string {
  const chinese = locale === 'zh';
  const title = chinese ? '工作人员入口未开放' : 'Staff access is not open';
  const body = chinese
    ? '工作人员权限在数据库里指定。以业主或集成商登录不会打开此页。申请表不能把任何人改成管理员。'
    : 'Staff access is assigned in the database. Signing in as an owner or an integrator does not open this page. The application form cannot make you an admin.';
  const signIn = chinese ? '登录' : 'Sign in';
  const login = chinese ? '/zh/login' : '/login';
  const notice = chinese
    ? '仅供参考，不构成法律意见。'
    : 'For informational purposes only; does not constitute legal advice.';
  return `<!DOCTYPE html>
<html lang="${chinese ? 'zh-CN' : 'en'}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex">
  <title>${title}</title>
</head>
<body style="margin:0;background:#F6F3EE;color:#1C1917;font-family:Georgia,'Songti SC','Noto Serif SC',serif;">
  <main style="max-width:40rem;margin:4rem auto;padding:0 1.5rem;line-height:1.6;">
    <p style="letter-spacing:0.08em;text-transform:uppercase;font-size:0.8rem;">X Home Easy</p>
    <h1>${title}</h1>
    <p>${body}</p>
    <p><a href="${login}">${signIn}</a></p>
    <p>${notice}</p>
  </main>
</body>
</html>`;
}
