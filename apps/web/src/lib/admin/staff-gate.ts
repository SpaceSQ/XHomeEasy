const staffPath = /^\/(?:(?:en|de)\/)?admin(?:\/|$)/;

export function isStaffConsolePath(pathname: string): boolean {
  return staffPath.test(pathname);
}

export function staffDeniedHtml(locale: 'en' | 'de'): string {
  const german = locale === 'de';
  const title = german ? 'Mitarbeiterzugang ist nicht offen' : 'Staff access is not open';
  const body = german
    ? 'Der Mitarbeiterzugang wird in der Datenbank vergeben. Eine Anmeldung als Eigentümer oder Integrator öffnet diese Seite nicht. Das Antragsformular kann niemanden zum Admin machen.'
    : 'Staff access is assigned in the database. Signing in as an owner or an integrator does not open this page. The application form cannot make you an admin.';
  const signIn = german ? 'Anmelden' : 'Sign in';
  const login = german ? '/de/login' : '/login';
  return `<!DOCTYPE html>
<html lang="${german ? 'de' : 'en'}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex">
  <title>${title}</title>
</head>
<body style="margin:0;background:#F6F3EE;color:#1C1917;font-family:Georgia,serif;">
  <main style="max-width:40rem;margin:4rem auto;padding:0 1.5rem;line-height:1.6;">
    <p style="letter-spacing:0.08em;text-transform:uppercase;font-size:0.8rem;">X Home Easy</p>
    <h1>${title}</h1>
    <p>${body}</p>
    <p><a href="${login}">${signIn}</a></p>
    <p>Nur zu Informationszwecken; dies ist keine Rechtsberatung.</p>
    <p lang="en">For informational purposes only; does not constitute legal advice.</p>
  </main>
</body>
</html>`;
}
