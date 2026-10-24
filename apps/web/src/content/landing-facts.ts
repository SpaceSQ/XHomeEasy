import type { EvidenceLevel } from '@xhomeeasy/shared-types';

export type LandingFactId =
  | 'standard'
  | 'catalogue'
  | 'count'
  | 'budget'
  | 'ranking'
  | 'handover';

export type LandingFact = {
  id: LandingFactId;
  level: EvidenceLevel;
  sourceUrl: string;
  verifiedAt: string;
};

export const landingFacts: readonly LandingFact[] = [
  {
    id: 'standard',
    level: 'E1',
    sourceUrl: 'https://www.control4.com/company',
    verifiedAt: '2026-10-21'
  },
  {
    id: 'catalogue',
    level: 'E1',
    sourceUrl: 'https://www.lutron.com/us/en/controls/systems/homeworks',
    verifiedAt: '2026-10-21'
  },
  {
    id: 'count',
    level: 'E2',
    sourceUrl: 'https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/',
    verifiedAt: '2026-10-21'
  },
  {
    id: 'budget',
    level: 'E3',
    sourceUrl: 'https://homeautomation.us.com/planning/luxury-smart-home/',
    verifiedAt: '2026-10-21'
  },
  {
    id: 'ranking',
    level: 'E4',
    sourceUrl: '/help#partners',
    verifiedAt: '2026-10-24'
  },
  {
    id: 'handover',
    level: 'E1',
    sourceUrl: 'https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm',
    verifiedAt: '2026-10-21'
  }
];
