'use client';

import { useEffect, useState } from 'react';

const seats = [
  // Square canvas; the wordmark sits in a short center band. Cover crops the empty space.
  { id: 'Control4', src: '/brands/control4.png', x: '18%', y: '50%', fit: 'object-cover' },
  { id: 'Crestron', src: '/brands/crestron.png', x: '82%', y: '50%', fit: 'object-contain' },
  { id: 'Savant', src: '/brands/savant.png', x: '50%', y: '16%', fit: 'object-contain' },
  { id: 'Lutron', src: '/brands/lutron.png', x: '50%', y: '82%', fit: 'object-contain' }
] as const;

export function EntranceSplash({ skipLabel }: { skipLabel: string }) {
  const [progress, setProgress] = useState(0);
  const [gone, setGone] = useState(false);

  useEffect(() => {
    if (window.sessionStorage.getItem('xhomeeasy.splash') === '1') {
      setGone(true);
      return;
    }
    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    setGone(false);
    if (reduce) {
      setProgress(1);
      const timer = window.setTimeout(finish, 1200);
      return () => window.clearTimeout(timer);
    }
    const started = performance.now();
    let frame = 0;
    const tick = (now: number) => {
      const next = Math.min(1, (now - started) / 3200);
      setProgress(next);
      if (next < 1) {
        frame = window.requestAnimationFrame(tick);
      } else {
        window.setTimeout(finish, 700);
      }
    };
    frame = window.requestAnimationFrame(tick);
    return () => {
      window.cancelAnimationFrame(frame);
    };
  }, []);

  function finish() {
    window.sessionStorage.setItem('xhomeeasy.splash', '1');
    setGone(true);
  }

  if (gone) {
    return null;
  }

  return (
    <div className="fixed inset-0 z-50 bg-black text-white" role="dialog" aria-label="X Home Easy">
      <svg className="absolute inset-0 h-full w-full" aria-hidden="true">
        {seats.map((seat) => {
          const x2 = 50 + (Number(seat.x.replace('%', '')) - 50) * progress;
          const y2 = 46 + (Number(seat.y.replace('%', '')) - 46) * progress;
          return (
            <line
              key={seat.id}
              x1="50%"
              y1="46%"
              x2={`${x2}%`}
              y2={`${y2}%`}
              stroke="url(#join)"
              strokeWidth="2.5"
              strokeLinecap="round"
            />
          );
        })}
        <defs>
          <linearGradient id="join" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0" stopColor="#db3828" />
            <stop offset="1" stopColor="#ffffff" />
          </linearGradient>
        </defs>
      </svg>
      {seats.map((seat) => (
        <div
          key={seat.id}
          className="brand-shimmer absolute h-[16vmin] w-[34vmin] -translate-x-1/2 -translate-y-1/2 overflow-hidden rounded-lg bg-white p-2"
          style={{ left: seat.x, top: seat.y }}
        >
          <img src={seat.src} alt={seat.id} className={`block h-full w-full ${seat.fit}`} />
        </div>
      ))}
      <img
        src="/logo.png"
        alt="X Home Easy"
        className="absolute left-1/2 top-[46%] -translate-x-1/2 -translate-y-1/2 object-contain"
        style={{ width: '20vmin', height: '20vmin', transform: `translate(-50%, -50%) scale(${1 + progress})` }}
      />
      <button type="button" onClick={finish} className="absolute right-4 top-4 min-h-11 px-4 text-sm font-semibold">
        {skipLabel}
      </button>
    </div>
  );
}
