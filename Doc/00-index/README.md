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
