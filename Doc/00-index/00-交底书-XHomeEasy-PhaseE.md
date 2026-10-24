# XHomeEasy 阶段 E 交底书（2026-10-24）

## 交付
- 包：`/workspace/x-home-easy/deliverables/XHomeEasy-PhaseE-NicheAndWireless-2026.tar.gz`（SHA256 `2dca101377961b43e6263381f637777d6c58e96c7c951d4cb2cc45800a58bdfa`，171KB）
- 同步目标（Mac）：`/Users/David1/XHomeEasy/` 对应 `Doc/10-niche-wired-systems/`、`Doc/11-wireless-interception-catalog/`

## 数量
| 子任务 | 路径 | 条数 | Corpus SHA256 |
|---|---|---|---|
| E1 小众/老牌有线 | `Doc/10-niche-wired-systems/` | **125**（NW001–NW125） | `78581485…b1f7` |
| E2 无线拦截导流 | `Doc/11-wireless-interception-catalog/` | **150**（WL001–WL150） | `fc4a9544…93e1` |

## E1 分区
- 01-legacy-plc-bus: 38
- 02-security-managed-platforms: 30
- 03-hems-smart-panels: 25
- 04-poe-ecommerce-hybrid: 32

## E2 分区
- 01-protocols-and-hubs: 25
- 02-wireless-lighting-switches: 35
- 03-wireless-security-locks: 35
- 04-wireless-climate-shades-yard: 30
- 05-smart-appliances-speakers: 25

## Schema
统一 10 字段；E2 含 `redirect_target_app` + `redirect_script_zh`（AHomeEasy / MHomeEasy）。只读公开源；无市电 DIY 接线步骤。

## 导入顺序
1. `niche-wired.corpus.jsonl`
2. `wireless-intercept.corpus.jsonl`
3. 对照各目录 `manifest.json` / handbook
