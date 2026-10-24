# Phase A 工作日志

- date: 2026-10-21 Asia/Shanghai
- updated_at: 2026-10-21T20:23:31+08:00
- scope: 官方/协议方公开资料库、技术支持与下载中心（无需登录）
- excluded_this_round: 阶段 B（互联网方案/案例）；阶段 C（渠道名录）仅记待办

## 入库条数（manifest items）

| 品牌/层 | 条数 |
|---------|------|
| Control4 | 17 |
| Crestron | 20 |
| Savant | 17 |
| Lutron | 19 |
| Cross-brand | 7 |
| **合计** | **80** |

产品规格/产品页公开条目：Control4 ≥8（CORE1/3/5、EA-5、T4、Catalog、Install Guide 等）；Crestron ≥8（CP4-R、MC4-R+SS、HR-310、TSR-310、TSW-1070、Works-With×2、End User Guide）；Savant ≥8（Home、Host 分层、Resources×2、Power 列表、Help Center）；Lutron ≥10 公开 PDF（RA3×4、HomeWorks×4、Caséta×2）。

## 主要 gaps（需登录 / 拦截）

1. **Control4**：customer.control4.com 软件下载、Integrator Login、Education Portal/Snap University 课程本体、Composer 发行包。
2. **Crestron**：Home Pro Portal、myCrestron 操作门户、Resource Library 深度固件包、SIMPL/CH5 工具链。
3. **Savant**：SIGN IN / Dealer Community / Product Catalog、多数 support.savant.com 深层安装文、RacePoint 工具。
4. **Lutron**：support.lutron.com 被 Incapsula 拦截（改走 assets.lutron.com 直链成功）；myLutron / Designer 软件登录。
5. **价格**：四品牌官方均无面向消费者的完整北美 MSRP 总表。
6. **移交**：仅 Control4 有较完整公开 OvrC「换 Smart Home Pro」专文；其余三品牌公开层弱，需合同/经销商政策（阶段 B/C 再补）。

## 方法与边界

- 只用 WebSearch + curl/WebFetch；不登录、不绕过付费墙/验证码/Dealer-only。
- 原始缓存：`99-raw/`；结构化摘要：各品牌 `01–09` + `10-manifest.json`。
- 安装类：只保留索引与安全边界，不把 DIY 市电接线当可执行指南。

## 产出路径

- 进度：`/workspace/x-home-easy/Doc/00-index/progress.json`
- 本日志：`/workspace/x-home-easy/Doc/00-index/phase-A-log.md`
- 覆盖快照：`/workspace/x-home-easy/Doc/05-cross-brand/matrix/official-docs-coverage.md`
- 找商对比：`/workspace/x-home-easy/Doc/05-cross-brand/matrix/find-integrator-comparison.md`

## 阶段 C 待办（A/B 完成后做；本轮不扩做）

目录已预留：`/workspace/x-home-easy/Doc/07-channel-partners/`

任务：四品牌渠道/安装商服务商公开名录。

- 来源标注：**E1** 官方 Find a Dealer；**E2** CEDIA 等协会；**E3** 互联网「主动声称」代理。
- 字段：名称、地址、区域、公开联系方式、业务/服务范围、声称的典型案例；全部带 `source_url` 与 `fetched_on`。
- 合并去重：`07-channel-partners/unified/channel-partners-master.csv` + `analysis.md`。
- 执行时机：阶段 A、B 完成之后；阶段 A 本轮仅记待办，不采集名录行。

## 阶段 B 待办（后续）

关键词搜索互联网设计方案、项目案例、实施经验 → `06-internet-cases/`，与官方层交叉引用。
