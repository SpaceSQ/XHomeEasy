# Phase C 工作日志

- date: 2026-10-21 Asia/Shanghai
- updated_at: 2026-10-21T20:29:38+08:00
- scope: 四品牌渠道/安装商**公开名录样本**（非完整全球名录）
- hard rules: 不登录、不绕墙；私人/登录后联系方式不收；每条 source_url + source_tier

## 来源分层

| Tier | 定义 | 本轮结果 |
|------|------|----------|
| E1 | 官方 Find a Dealer/API 或官方案例署名 | Control4 API 强；其余弱（案例署名若干） |
| E2 | CEDIA 等协会公开批量结果 | **0 行**（城市页静态 HTML 无成员列表） |
| E3 | 互联网主动声称授权经销商 | Crestron/Savant/Lutron 主要来源 |

## 条数（品牌文件；多品牌会重复计入不同文件）

| 品牌文件 | 行数 | E1 | E3 |
|----------|------|----|----|
| control4 | 1108 | 1103 | 5 |
| crestron | 11 | 1 | 10 |
| savant | 10 | 4 | 6 |
| lutron | 13 | 2 | 11 |
| **unified 去重** | **1132** | **1109** | **23** |

Control4 E1 来自公开 LocateDealers API，采样 12 都会区（约 100 英里）：NY/LA/SF/Chicago/Dallas/Miami/Seattle/Boston/Denver/Atlanta + Toronto/Vancouver。NY/LA/Miami 触及 UpperLimit=175 → **非完整**。

## 主要 gaps

1. Crestron / Savant / Lutron 官方定位器无法批量导出（交互地图、lead form、或 403）。
2. CEDIA Find a Pro 无静态批量列表 → E2=0。
3. E3 为自我声称，证据等级低于 E1；APP 须标注并可纠错。
4. 未覆盖全部北美邮编；加拿大仅两城 Control4 样本。
5. 未同步 Mac（按任务由父代理处理）。

## 产出路径

- `07-channel-partners/{control4,crestron,savant,lutron}/directory.jsonl` + `directory.md`
- `07-channel-partners/unified/channel-partners-master.csv`
- `07-channel-partners/unified/analysis.md`
- 本日志：`phase-C-log.md`
