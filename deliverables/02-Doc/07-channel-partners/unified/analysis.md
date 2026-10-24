# Channel / installer directory analysis (Phase C)

- date: 2026-10-21 Asia/Shanghai
- **Not a complete global or complete North American directory** — metro retrieval sample + public claim pages.

## Headline counts

| Dataset | Rows |
|---------|------|
| Unified master (deduped) | 1132 |
| Control4 file | 1108 ({'E1': 1103, 'E3': 5}) |
| Crestron file | 11 ({'E1': 1, 'E3': 10}) |
| Savant file | 10 ({'E1': 4, 'E3': 6}) |
| Lutron file | 13 ({'E1': 2, 'E3': 11}) |

### Unified by source_tier

| Tier | Meaning | Count |
|------|---------|-------|
| E1 | Official locator API / official case-study or channel PR credit | 1109 |
| E2 | CEDIA / association bulk export | 0 |
| E3 | Self-claimed authorized dealer / media portfolio | 23 |

Brand affiliation hits (multi-count): {'Control4': 1108, 'Crestron': 11, 'Lutron': 13, 'Savant': 10}

## Control4 — E1 strength

- API: `dealerlocator.azure-api.net/v1/DealerLocator/LocateDealers` (public; used by control4.com integrator-search).
- Metros (~100 mi): NY, LA, SF, Chicago, Dallas, Miami, Seattle, Boston, Denver, Atlanta, Toronto, Vancouver.
- Unique after merge: **1101**.
- **Hard cap UpperLimit=175**: NY / LA / Miami each returned 175 → incomplete there.
- Countries in sample: {'US': 900, 'VE': 1, 'USA': 2, 'IL': 1, 'CA': 197}.
- Top US states: [('CA', 213), ('FL', 168), ('TX', 87), ('NY', 86), ('NJ', 65), ('GA', 65), ('IL', 49), ('CO', 46), ('WA', 33), ('MA', 27), ('CT', 18), ('WI', 13), ('IN', 9), ('NH', 8), ('RI', 3)].

## Crestron — official export gap

- Find-a-Service-Provider / Elite Platinum pages are interactive (Maps + reCAPTCHA); no bulk JSON found without login.
- Rows are mostly E3 self-claims + limited E1 case-study credits (HENRI).
- Do not treat Crestron file size as market density.

## Savant — match-only official path

- Find-a-Dealer is lead/match, not a browsable list (confirmed by dealer sites such as ioty).
- E1 = official case-study dealer credits; E3 = Ambassador/Elite Ambassador claims.

## Lutron — WTB blocked / ZIP UI

- webtools Where-to-Buy returned HTTP 403 this round; residential installer tools need ZIP UI.
- E1 = official PDF case study; E3 = HomeWorks/RA3 dealer claim pages.
- Multi-brand co-occurrence with Control4/Crestron/Savant is common and expected.

## CEDIA E2

- Find-a-Pro city pages do not embed member lists in static HTML → **E2 bulk rows = 0**.
- See `unified/cedia-e2-gap.md`.

## Official vs E3 coverage gap (summary)

| Brand | Official sample | E3 role |
|-------|-----------------|---------|
| Control4 | Strong metro API sample | Enrichment |
| Crestron | Weak | Interim signal (low confidence) |
| Savant | Weak (match-only) | Interim + case credits |
| Lutron | Weak (403/ZIP) | Interim + PDF credits |

## APP data rules implied

1. Label every partner with `source_tier` + `fetched_on`.
2. Never present this file as complete.
3. Allow dealer claim/correction workflow for E3.
4. Prefer Control4 E1 for density maps; for other brands show “sample / claim-based”.

## Paths

- `/workspace/x-home-easy/Doc/07-channel-partners/{control4,crestron,savant,lutron}/directory.jsonl`
- `/workspace/x-home-easy/Doc/07-channel-partners/unified/channel-partners-master.csv`
- this file: `analysis.md`
