# X Home Easy 知识图库 · 目录体系

目标路径（Mac）：`/Users/David1/XHomeEasy/Doc`  
工作副本（千里眼）：`/workspace/x-home-easy/Doc`  
收集窗口：约 24 小时初步收集（2026-10-21 起）  
范围：Control4 / Crestron / Savant / Lutron（北美有线别墅大宅）

## 原则
1. **先官方后社区**：优先四品牌官方/协议方资料库、技术支持与下载中心；再互联网方案/案例/经验。
2. **只存公开可引用来源**：每条记录 `source_url`、`fetched_on`、`title`；需登录的门户只记入口与缺口，不绕登录、不抓受保护下载。
3. **分层叠加**：产品规格 → 体系架构 → 安装与布线标准 → 编程/移交 → 运维 → 案例与经验。
4. **中英混存**：原文保留；索引与摘要用中文。

## 顶层目录

```
Doc/
├── 00-index/                 # 本说明、思维导图、总清单、进度
├── 01-Control4/
├── 02-Crestron/
├── 03-Savant/
├── 04-Lutron/
├── 05-cross-brand/           # CEDIA、ANSI、对比矩阵、分销（Snap One/ADI）
├── 06-internet-cases/        # 第二阶段：方案/案例/经验（按关键词）
│   └── fusion-hybrid/        # 融合趋势素材：KNX↔四老牌、Matter/Zigbee↔老牌/KNX（≥100 条公开 URL）
├── 07-channel-partners/      # 阶段 C：渠道/服务商公开名录
├── 08-subsystems/            # 别墅子系统（HVAC/新风/影音/安防等）与四老牌联动素材
└── 99-raw/                   # 原始 HTML/PDF 抓取缓存
```

## 每品牌统一子目录

```
0N-<Brand>/
├── 01-overview/              # 公司、产品线地图、官方门户入口
├── 02-products/              # 控制器/面板/照明/影音/安防/HVAC 等规格
├── 03-architecture/          # 系统拓扑、协议、与第三方互操作
├── 04-install-wiring/        # 安装指南、布线、机柜（停在安全边界）
├── 05-programming-handover/  # 编程工具、项目文件、经销商移交政策
├── 06-ops-remote/            # 远程管理、运维订阅、Dealer 工具
├── 07-partner-network/       # 找经销商/认证体系、分销渠道
├── 08-pricing-public/        # 公开可见的价目/套餐（无则记「未公开」）
├── 09-training-cert/         # 培训与认证路径
└── 10-manifest.json          # 该品牌已入库文件清单
```

## 两阶段工作流
- **阶段 A（当前）**：遍历四家官方/协议方资料库与技术支持/下载中心，建立清单与可下载公开文档。
- **阶段 B**：关键词搜索互联网（设计方案、项目案例、实施经验），写入 `06-internet-cases/`，与官方层交叉引用。

## 阶段 C（渠道 / 服务商体系）
在阶段 A（官方资料）与阶段 B（互联网方案案例）之后执行。
目标：四品牌渠道与安装商/服务商**公开名录**汇总表。

来源分层并标注：
- E1 品牌/协议组织官方 Find a Dealer / Partner 目录
- E2 CEDIA / 行业协会公开名录
- E3 互联网检索到的「主动声称」代理商/集成商（官网、LinkedIn、目录站等公开页）
- 不登录、不绕墙；私人或需登录联系方式不收录

每条字段（缺则写 null）：name, brand_affiliations[], address, region/city/state/country, contacts_public, service_scope, claimed_case_studies[], source_url, source_tier (E1/E2/E3), fetched_on, notes

产出：
- `07-channel-partners/<brand>/directory.jsonl` + `directory.md`
- `07-channel-partners/unified/channel-partners-master.csv`（四家合并去重）
- `07-channel-partners/unified/analysis.md`（分布、密度、认证层级、与官方目录覆盖差）


## 融合趋势素材（fusion-hybrid）
路径：`06-internet-cases/fusion-hybrid/`  
用途：KNX 与四老牌竞争/合作、Matter/Zigbee 改造与新建融合、KNX 多协议网关、公开安装经验 —— 供融合方案建议与本地大模型训练。  
主文件：`corpus.md`（可读）、`corpus.jsonl`（一行一条）、`manifest.json`（计数与分层）。
