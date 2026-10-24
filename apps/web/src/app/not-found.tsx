import en from '../../messages/en.json';

export default function RootNotFound() {
  return (
    <html lang="en">
      <body
        style={{
          margin: 0,
          background: '#F6F3EE',
          color: '#1C1917',
          fontFamily: 'Georgia, serif',
          padding: '4rem 1.5rem'
        }}
      >
        <h1>{en.NotFound.title}</h1>
        <p>{en.NotFound.body}</p>
      </body>
    </html>
  );
}
