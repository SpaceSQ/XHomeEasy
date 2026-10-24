# X Home Easy · 遮阳 / 泳池水疗等辅机子系统方案库（Shades & Climate Aux）

覆盖 Somfy / Hunter Douglas / Mecho / Lutron 遮阳交叉 / Pentair / Jandy / Hayward / Spa 自动化等；与四老牌常见联动，正文未提四品牌亦可收录。

- **收集日期**：2026-10-21（Asia/Shanghai）
- **条目数**：74
- **证据分层**：E1 厂商 / E2 行业媒体 / E3 集成商·渠道 / E4 社区
- **免责声明**：公开二手资料整理，供方案建议与训练；非施工规范、非电气安全指南。

## 品牌计数

| brand | count |
|---|---|
| Somfy | 22 |
| Hunter Douglas | 11 |
| Pentair | 10 |
| Jandy | 10 |
| Lutron | 8 |
| Hayward | 6 |
| Mecho | 4 |
| SpaPilot | 1 |
| Balboa | 1 |
| Screen Innovations | 1 |

---

### SS561 | Somfy + Control4 官方集成页
- id: SS561
- category: shades-climate-aux
- brand: Somfy
- subsystem: motorized-shades
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/smart-home-controls/automation-systems/control4
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 遮阳厂商官方认可 Control4；别墅遮阳常用 SDN/UAI+ 进 C4。
- summary_zh: Somfy 北美站介绍与 Control4 的智能家居集成路径与产品入口。
- key_points:
  - "官方集成"
  - "Control4"
  - "遮阳"
- install_notes: 需配套 UAI+/相应驱动；以现行产品页为准。
- app_takeaway_zh: 遮阳子系统优先点名 Somfy SDN + Control4 认证驱动。
- training_snippet: Somfy’s Control4 page is E1 evidence for villa shade fusion.

### SS562 | Somfy + Crestron 官方集成页
- id: SS562
- category: shades-climate-aux
- brand: Somfy
- subsystem: motorized-shades
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/smart-home-controls/automation-systems/crestron
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 同样官方支持 Crestron；UAI+ 为常见 IP 网关。
- summary_zh: 介绍 Somfy 与 Crestron 智能家居集成能力。
- key_points:
  - "Crestron"
  - "UAI+"
  - "官方"
- install_notes: None
- app_takeaway_zh: Crestron 别墅遮阳默认查此页+应用市场模块。
- training_snippet: Somfy–Crestron official page anchors IP shade gateway designs.

### SS563 | Somfy + Savant 官方集成页
- id: SS563
- category: shades-climate-aux
- brand: Somfy
- subsystem: motorized-shades
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/smart-home-controls/automation-systems/savant
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Savant']
- control_layer_fit: Savant 路径含 TaHoma/myLink/UAI+ 等。
- summary_zh: 说明 Savant 驱动覆盖 TaHoma、myLink 与 Connect UAI Plus。
- key_points:
  - "Savant"
  - "TaHoma"
  - "myLink"
- install_notes: None
- app_takeaway_zh: Savant 项目按网关类型选驱动。
- training_snippet: Somfy–Savant page lists TaHoma/myLink/UAI+ driver options.

### SS564 | Somfy Connect UAI Plus 产品页
- id: SS564
- category: shades-climate-aux
- brand: Somfy
- subsystem: sdn
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/1870272/somfy-connect-universal-automation-interface-uai-plus
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron', 'Lutron']
- control_layer_fit: SDN 电机 IP 调试与第三方控制的关键网关。
- summary_zh: UAI Plus 用于 SDN 网络调试并对接自动化系统。
- key_points:
  - "UAI Plus"
  - "SDN"
  - "IP网关"
- install_notes: 寻址格式在不同控制品牌间可能不同（ZZ GG NN vs Z.G.N）。
- app_takeaway_zh: 网络说明书固定 UAI+ IP 与 SDN 拓扑。
- training_snippet: UAI Plus is the standard SDN IP gateway for Control4/Crestron/Lutron.

### SS565 | UAI+ 安装/集成说明 PDF（渠道）
- id: SS565
- category: shades-climate-aux
- brand: Somfy
- subsystem: sdn
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.automatedshadestore.com/shop/avactis-images/u/Integration/Connect-UAI/somfy_connect_uai_plus_instructions_jan_2018.pdf
- source_name: Automated Shade Store / Somfy
- published: 2018
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron', 'Lutron']
- control_layer_fit: 公开集成说明含寻址格式差异。
- summary_zh: 说明 UAI+ 与各系统对接时的节点寻址表示法差异。
- key_points:
  - "寻址格式"
  - "集成说明"
- install_notes: 文档年代较旧，参数以最新 Somfy 文档为准。
- app_takeaway_zh: 程序员备注 Lutron 与 C4 寻址差异。
- training_snippet: UAI+ instruction PDFs document addressing format differences by controller.

### SS566 | Somfy SDN Reference Book
- id: SS566
- category: shades-climate-aux
- brand: Somfy
- subsystem: sdn
- evidence_tier: E1
- region: Global
- source_url: https://service.somfy.com/downloads/bui_v4/sdn-reference-book.pdf
- source_name: Somfy Service
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: SDN RS-485 半双工遮阳网络权威参考。
- summary_zh: 参考书覆盖 SDN 网络架构、设备与第三方 BMS 集成概念。
- key_points:
  - "SDN"
  - "RS-485"
  - "BMS"
- install_notes: 施工须持证；本库只索引不复述带电步骤。
- app_takeaway_zh: 别墅多帘系统以 SDN 为骨干的设计依据。
- training_snippet: Somfy SDN reference books define RS-485 shade-network architecture.

### SS567 | Somfy SDN Reference Book 2
- id: SS567
- category: shades-climate-aux
- brand: Somfy
- subsystem: sdn
- evidence_tier: E1
- region: Global
- source_url: https://service.somfy.com/downloads/bui_v4/sdn-reference-book2.pdf
- source_name: Somfy Service
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 参考书续篇，补充部署细节。
- summary_zh: SDN 参考材料续册。
- key_points:
  - "SDN续册"
  - "部署"
- install_notes: None
- app_takeaway_zh: 与第一册一并归档。
- training_snippet: SDN reference book volume 2 extends deployment guidance.

### SS568 | animeo IB+ 楼宇/别墅遮阳控制器资料
- id: SS568
- category: shades-climate-aux
- brand: Somfy
- subsystem: animeo
- evidence_tier: E1
- region: Europe
- source_url: https://service.somfy.com/downloads/bui_v4/animeo-ib-4_8-zone-touch-buco_bacnet_5124490g.pdf
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 多立面分区遮阳与 BACnet，适合大宅/会所；可与四老牌/KNX 并存。
- summary_zh: animeo IB+ 4/8 区触摸楼宇控制器资料，含 BACnet 型号。
- key_points:
  - "animeo"
  - "立面分区"
  - "BACnet"
- install_notes: 需合格电工与指定嵌装盒等安装条件（见原文）。
- app_takeaway_zh: 超大立面遮阳超出普通 RTS 时升 animeo/SDN。
- training_snippet: animeo IB+ docs cover multi-façade shade control with BACnet.

### SS569 | Manual animeo IP SDN v1.2
- id: SS569
- category: shades-climate-aux
- brand: Somfy
- subsystem: animeo
- evidence_tier: E1
- region: Europe
- source_url: https://service.somfy.com/downloads/bui_v4/manual-animeo-ip-sdn-v1.2.pdf
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: animeo IP 与 SDN 结合的手册。
- summary_zh: 说明 animeo IP SDN 配置与管理。
- key_points:
  - "animeo IP"
  - "SDN手册"
- install_notes: None
- app_takeaway_zh: 欧式大宅立面自动化文献。
- training_snippet: animeo IP SDN manuals support European villa façade automation.

### SS570 | Somfy Controls Product Guide 2021
- id: SS570
- category: shades-climate-aux
- brand: Somfy
- subsystem: product-guide
- evidence_tier: E1
- region: Global
- source_url: https://service.somfy.com/downloads/bui_v4/product-guide-2021.pdf
- source_name: Somfy
- published: 2021
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 控制产品线总览，选型目录。
- summary_zh: 2021 控制产品指南覆盖电机控制与楼宇遮阳控制产品。
- key_points:
  - "产品指南"
  - "选型"
- install_notes: None
- app_takeaway_zh: 对内培训教材。
- training_snippet: Somfy controls product guide surveys motors and building controllers.

### SS571 | TaHoma switch 产品页
- id: SS571
- category: shades-climate-aux
- brand: Somfy
- subsystem: tahoma
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/controls/tahoma
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 消费/轻商网关，对接 Savant/Alarm.com 等云与本地生态。
- summary_zh: 介绍 TaHoma 作为电机遮阳与智能家居中枢。
- key_points:
  - "TaHoma"
  - "网关"
  - "生态"
- install_notes: None
- app_takeaway_zh: 精装改造可用 TaHoma；大型 SDN 工程仍用 UAI+。
- training_snippet: TaHoma switch suits lighter shade gateways versus full SDN.

### SS572 | TaHoma Integrations 列表
- id: SS572
- category: shades-climate-aux
- brand: Somfy
- subsystem: tahoma
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/controls/tahoma/integrations
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Savant', 'Crestron']
- control_layer_fit: 官方集成列表，含四老牌相关项。
- summary_zh: 列出 TaHoma 支持的智能家居与语音等集成。
- key_points:
  - "集成列表"
  - "多平台"
- install_notes: None
- app_takeaway_zh: 选型先看是否在列表内。
- training_snippet: TaHoma integrations list shows which legacy platforms are supported.

### SS573 | TaHoma switch（以太网适配）产品
- id: SS573
- category: shades-climate-aux
- brand: Somfy
- subsystem: tahoma
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.somfysystems.com/en-us/products/1871038/tahoma-switch-with-ethernet-adaptor
- source_name: Somfy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Savant']
- control_layer_fit: 强调有线以太网适配，利于稳定对接 Savant/Alarm.com。
- summary_zh: 产品页列出以太网适配型号及伙伴（含 Savant、Alarm.com）。
- key_points:
  - "以太网"
  - "伙伴列表"
- install_notes: None
- app_takeaway_zh: 别墅弱电间建议有线 TaHoma。
- training_snippet: Ethernet-adapted TaHoma improves reliability for Savant/Alarm.com.

### SS574 | DriverCentral：Somfy Generic RTS/DCT
- id: SS574
- category: shades-climate-aux
- brand: Somfy
- subsystem: control4-driver
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/blinds-shades/somfy-generic-rts-and-dct-driver/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: RTS/DCT 类驱动市场条目。
- summary_zh: Control4 驱动页介绍通用 RTS/DCT Somfy 驱动。
- key_points:
  - "RTS"
  - "DCT"
  - "驱动"
- install_notes: RTS 位置反馈有限。
- app_takeaway_zh: 要反馈选 SDN+UAI+ 而非纯 RTS。
- training_snippet: Generic RTS/DCT drivers are limited versus SDN position feedback.

### SS575 | Control4 Driver Search：Somfy 认证驱动
- id: SS575
- category: shades-climate-aux
- brand: Somfy
- subsystem: control4-driver
- evidence_tier: E1
- region: Global
- source_url: https://drivers.control4.com/solr/drivers/browse?fq=&fq=certified%3A%22true%22&fq=manufacturer%3A%22Somfy%22&q=
- source_name: Control4 Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方认证驱动检索。
- summary_zh: Control4 驱动库按制造商 Somfy 与 certified 过滤结果。
- key_points:
  - "认证驱动"
  - "官方库"
- install_notes: None
- app_takeaway_zh: 验收记录驱动版本。
- training_snippet: Certified Somfy drivers in Control4’s official store are preferred.

### SS576 | HopSoft：Control4 作品集（含遮阳）
- id: SS576
- category: shades-climate-aux
- brand: Somfy
- subsystem: hopsoft
- evidence_tier: E3
- region: Oceania
- source_url: https://hopsoft.com.au/portfolio/control4
- source_name: HopSoft
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 第三方开发商 TaHoma/Connexoon C4 驱动来源之一。
- summary_zh: HopSoft 展示 Control4 相关驱动与作品。
- key_points:
  - "第三方驱动"
  - "Connexoon"
- install_notes: None
- app_takeaway_zh: 澳新项目可询 HopSoft TaHoma 驱动。
- training_snippet: HopSoft portfolios document third-party TaHoma/Connexoon Control4 drivers.

### SS577 | HopSoft：遮阳驱动作品集
- id: SS577
- category: shades-climate-aux
- brand: Somfy
- subsystem: hopsoft
- evidence_tier: E3
- region: Oceania
- source_url: https://www.hopsoft.com.au/portfolio/all/shades
- source_name: HopSoft
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 遮阳类驱动列表。
- summary_zh: 作品集过滤遮阳相关 Control4 驱动。
- key_points:
  - "遮阳驱动"
  - "作品集"
- install_notes: None
- app_takeaway_zh: 与官方 UAI+ 驱动对比选型。
- training_snippet: HopSoft shade portfolio lists alternative Control4 shade drivers.

### SS578 | CE Pro：Somfy 进入 Alarm.com
- id: SS578
- category: shades-climate-aux
- brand: Somfy
- subsystem: alarmcom
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/briefs/somfy-components-now-integrate-into-alarm-com/95197/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安防云×遮阳交叉证据（与安防库互见）。
- summary_zh: 报道 Somfy 组件经网关进入 Alarm.com 生态。
- key_points:
  - "交叉证据"
  - "云遮阳"
- install_notes: None
- app_takeaway_zh: 双系统时定义主控。
- training_snippet: CE Pro Somfy–Alarm.com brief is cross-category evidence for shade+security clouds.

### SS579 | PowerView Gen 3 连接智能家居设备（官方帮助）
- id: SS579
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.hunterdouglas.com/hc/en-us/articles/39343059678868-Connect-PowerView-Gen-3-to-Smart-Home-Devices
- source_name: Hunter Douglas Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron', 'Savant']
- control_layer_fit: 官方列出 C4/Crestron/Savant 等对接，需 Gen3 网关。
- summary_zh: 帮助文说明 PowerView Gen3 经网关与主要智能家居平台集成。
- key_points:
  - "Gen3"
  - "网关"
  - "多平台"
- install_notes: None
- app_takeaway_zh: 自定义集成商项目确认 Gateway Pro/标准网关容量。
- training_snippet: Hunter Douglas Gen3 help lists Control4/Crestron/Savant integrations.

### SS580 | Set Up PowerView Gen 3
- id: SS580
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.hunterdouglas.com/hc/en-us/articles/39420339826964-Set-Up-PowerView-Gen-3
- source_name: Hunter Douglas Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 官方设置流程：房间/帘位后再加网关。
- summary_zh: 分步说明 Gen3 系统设置与 App 流程。
- key_points:
  - "设置流程"
  - "App"
  - "网关"
- install_notes: 网关居中放置，覆盖不足加网关。
- app_takeaway_zh: 弱电间 PoE 网关更稳。
- training_snippet: Gen3 setup articles cover room/shade then gateway commissioning order.

### SS581 | PowerView Gen 3 Automation Gateway Guide PDF
- id: SS581
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E3
- region: Global
- source_url: https://hunterdouglasvn.com/wp-content/uploads/2025/02/PV-Gen-3-Automation-Gateway-Guide.pdf
- source_name: Hunter Douglas (hosted)
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 网关指南公开副本。
- summary_zh: 介绍 Automation Gateway 部署与注意事项。
- key_points:
  - "网关指南"
  - "部署"
- install_notes: None
- app_takeaway_zh: 归档 PDF 防链失效。
- training_snippet: Gateway guides detail PowerView Gen3 hub placement and capacity.

### SS582 | Market Launch FAQs for PowerView Gen 3
- id: SS582
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.hunterdouglas.com/hc/en-us/articles/46358576160660-Market-Launch-FAQs-for-PowerView-Gen-3-Automation
- source_name: Hunter Douglas Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Gateway Pro（以太网/PoE，约 30 帘）vs 标准 Wi-Fi（约 15 帘）等关键规格。
- summary_zh: 发布 FAQ 澄清网关型号容量与功能差异。
- key_points:
  - "Gateway Pro"
  - "容量"
  - "PoE"
- install_notes: None
- app_takeaway_zh: 大宅按帘数选 Gateway Pro。
- training_snippet: Gen3 launch FAQs quantify Gateway Pro vs Wi-Fi gateway shade counts.

### SS583 | Custom Integrator Program
- id: SS583
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: integrator
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.hunterdouglas.com/custom-integrator-program
- source_name: Hunter Douglas
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron']
- control_layer_fit: 面向 C4/Crestron/Elan/RTI/URC 等授权经销商的集成商计划。
- summary_zh: 介绍自定义集成商计划申请与合作方式。
- key_points:
  - "CIP"
  - "渠道计划"
- install_notes: None
- app_takeaway_zh: 申请 CIP 以获取工程支持。
- training_snippet: Hunter Douglas CIP targets Control4/Crestron dealers for villa projects.

### SS584 | Crestron Application Market：PowerView Gen3 v1.1
- id: SS584
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: Global
- source_url: https://applicationmarket.crestron.com/hunter-douglas-powerview-gen3-v1-1/
- source_name: Crestron App Market
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方应用市场模块。
- summary_zh: 提供 PowerView Gen3 Crestron 模块版本信息。
- key_points:
  - "SIMPL模块"
  - "Gen3"
- install_notes: None
- app_takeaway_zh: Crestron 程序员从此下载。
- training_snippet: Crestron Application Market hosts PowerView Gen3 modules.

### SS585 | Crestron：PowerView Gen3 Command Processor Help PDF
- id: SS585
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: Global
- source_url: https://applicationmarket.crestron.com/content/Help/Hunter_Douglas/Hunter%20Douglas%20PowerView%20Gen3%20Command%20Processor%20v1.0%20Help.pdf
- source_name: Crestron
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 命令处理器帮助：场景/帘/灯控制。
- summary_zh: Help PDF 说明 Gen3 命令处理器与相关控制对象。
- key_points:
  - "命令处理器"
  - "场景"
  - "帮助"
- install_notes: None
- app_takeaway_zh: 编程包附此 Help。
- training_snippet: Gen3 command-processor help defines Crestron shade/scene objects.

### SS586 | Control4 Driver Search：Hunter Douglas
- id: SS586
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E1
- region: Global
- source_url: https://drivers.control4.com/solr/drivers/browse?fq=&fq=manufacturer%3A%22Hunter+Douglas%22&q=
- source_name: Control4 Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方驱动库制造商过滤结果。
- summary_zh: 列出 Hunter Douglas 网关/帘/场景等驱动。
- key_points:
  - "官方驱动"
  - "网关/帘"
- install_notes: 常要求 OS 2.6+。
- app_takeaway_zh: 验收核对 certified 标志。
- training_snippet: Control4 driver search lists Hunter Douglas PowerView drivers.

### SS587 | CE Pro：PowerView Gen 3 全面改版报道
- id: SS587
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/news/hunter-douglas-powerview-gen-3-series/100123/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 行业媒体对 Gen3 架构改版的报道。
- summary_zh: 报道 PowerView Gen3 系列相对前代的全面更新。
- key_points:
  - "媒体"
  - "Gen3改版"
- install_notes: None
- app_takeaway_zh: 向业主解释为何不沿用 Gen2 网关。
- training_snippet: CE Pro Gen3 coverage explains architecture changes to clients.

### SS588 | CE Pro：PowerView 电动窗帘五金扩展
- id: SS588
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: powerview
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/news/hunter-douglas-expands-powerview-automation-with-new-motorized-drapery-hardware/142953/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 窗帘轨道类扩展，别墅落地帘常用。
- summary_zh: 报道 PowerView 自动化扩展到新的电动窗帘五金。
- key_points:
  - "窗帘五金"
  - "自动化扩展"
- install_notes: None
- app_takeaway_zh: 客厅落地帘可纳入同一 PowerView 工程。
- training_snippet: CE Pro drapery-hardware news expands PowerView beyond cellular shades.

### SS589 | Lutron vs Hunter Douglas PowerView 对比文
- id: SS589
- category: shades-climate-aux
- brand: Hunter Douglas
- subsystem: compare
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.exoticshades.com/lutron-vs-hunter-douglas-powerview
- source_name: Exotic Shades
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 集成商视角对比两套遮阳体系；Lutron 遮阳多走自家照明系统。
- summary_zh: 对比文讨论 PowerView 与 Lutron 遮阳在生态、安装与控制上的差异。
- key_points:
  - "品牌对比"
  - "生态差异"
- install_notes: None
- app_takeaway_zh: 已有 HomeWorks/RA3 的别墅优先 Lutron 遮阳；多品牌窗帘审美可选 PowerView+四老牌。
- training_snippet: Integrator comparisons help choose Lutron-native vs PowerView+controller.

### SS590 | Mecho 第三方集成页
- id: SS590
- category: shades-climate-aux
- brand: Mecho
- subsystem: motorized-shades
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://mechoshade.com/products/networking-and-controls/third-party-integration/
- source_name: Mecho
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron', 'Lutron', 'Control4']
- control_layer_fit: 官方声明支持 Crestron/Lutron/Control4 等，经 MechoNet。
- summary_zh: 介绍经 RS-232/RS-485、干接点、BACnet 等与第三方控制集成。
- key_points:
  - "MechoNet"
  - "多协议"
  - "官方"
- install_notes: None
- app_takeaway_zh: 公建/大宅卷帘常用 Mecho + 四老牌。
- training_snippet: Mecho third-party page documents Crestron/Lutron/Control4 integration paths.

### SS591 | MechoNet Network Interface 产品页
- id: SS591
- category: shades-climate-aux
- brand: Mecho
- subsystem: mechonet
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.mechoshade.com/products/networking-and-controls/mechonet-network-interface/
- source_name: Mecho
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: MNI 网络接口产品说明。
- summary_zh: 介绍 MechoNet Network Interface 功能与定位。
- key_points:
  - "MNI"
  - "网络接口"
- install_notes: None
- app_takeaway_zh: BOM 写明 MNI 数量与总线分段。
- training_snippet: MechoNet Network Interface is the bridge to legacy controllers.

### SS592 | DriverCentral：MechoShade MNI 驱动
- id: SS592
- category: shades-climate-aux
- brand: Mecho
- subsystem: control4
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/blinds-shades/mechoshade-mni-driver/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: C4 驱动：单帘反馈、离散位置、预设、校准、Zone-Group-Node。
- summary_zh: 驱动页列出反馈、位置、预设与寻址能力。
- key_points:
  - "位置反馈"
  - "ZGN寻址"
- install_notes: None
- app_takeaway_zh: 要反馈的 C4 遮阳优先 Mecho MNI 路径。
- training_snippet: MechoShade MNI Control4 driver advertises position feedback and presets.

### SS593 | Mecho–Lutron 集成说明 PDF
- id: SS593
- category: shades-climate-aux
- brand: Mecho
- subsystem: lutron
- evidence_tier: E3
- region: Europe
- source_url: https://prbl.ie/wp-content/uploads/2019/08/Mecho-Lutron-Integration.pdf
- source_name: Mecho (hosted)
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 经 RS-232/485 或干接点对接 Lutron 的公开说明。
- summary_zh: 说明 MechoNet 与 Lutron 第三方集成方式与限制。
- key_points:
  - "Lutron"
  - "串口/干接点"
  - "限制"
- install_notes: 状态反馈与自定义命令可能有限。
- app_takeaway_zh: 精细反馈需求评估是否改用 Lutron 原生遮阳。
- training_snippet: Mecho–Lutron PDFs document serial/dry-contact limits on feedback.

### SS594 | Lutron：Shades Third-Party Integration Service SPEC
- id: SS594
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades-cross
- evidence_tier: E1
- region: Global
- source_url: https://assets.lutron.com/a/documents/3691232.pdf
- source_name: Lutron
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: Lutron 第三方遮阳集成服务规格，归 aux 交叉参考。
- summary_zh: 规格说明串口/I/O 第三方遮阳集成服务能力与边界。
- key_points:
  - "第三方遮阳服务"
  - "规格"
- install_notes: None
- app_takeaway_zh: 用 Mecho/Somfy 进 Lutron 系统时读此 SPEC。
- training_snippet: Lutron’s third-party shade integration SPEC bounds Mecho/Somfy attachments.

### SS595 | Control4 Driver Search：Lutron blind 驱动
- id: SS595
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades
- evidence_tier: E1
- region: Global
- source_url: https://drivers.control4.com/solr/drivers/browse?fq=manufacturer%3A%22Lutron%22&fq=primaryProxy%3A%22blind%22&q=
- source_name: Control4 Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Lutron']
- control_layer_fit: C4 侧 Lutron 遮阳驱动检索。
- summary_zh: 过滤制造商 Lutron 且 primaryProxy=blind 的驱动列表。
- key_points:
  - "Sivoia"
  - "blind驱动"
- install_notes: None
- app_takeaway_zh: 已有 RadioRA/HomeWorks 时 C4 可驱动 Lutron 帘。
- training_snippet: Control4 Lutron blind drivers cover Sivoia/related shade proxies.

### SS596 | DriverCentral：Lutron Shade Integration（Cindev 等）
- id: SS596
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/blinds-shades/lutron/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Lutron']
- control_layer_fit: 增强型 Lutron 遮阳集成驱动介绍。
- summary_zh: 介绍经 LEAP/HomeWorksQS 等获得状态、滑条、组与齐位等能力。
- key_points:
  - "LEAP"
  - "状态反馈"
  - "组齐位"
- install_notes: None
- app_takeaway_zh: 高端窗帘齐位需求可评估 Cindev 类驱动。
- training_snippet: Enhanced Lutron shade drivers add status sliders and hembar alignment.

### SS597 | Crestron Home：与 Lutron 系统配对配置
- id: SS597
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Lutron-Integration.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron', 'Lutron']
- control_layer_fit: 官方说明负载在 Lutron Designer 配置，遮阳组须在 Lutron 侧定义。
- summary_zh: 文档描述 Crestron Home 与 Lutron 配对后个体/组负载的创建规则。
- key_points:
  - "Designer"
  - "遮阳组"
  - "配对"
- install_notes: None
- app_takeaway_zh: 遮阳分组在 Lutron 完成再同步。
- training_snippet: Crestron–Lutron docs require shade groups to be defined in Lutron Designer.

### SS598 | Lutron Support：Sivoia QS / Palladiom 编程到遥控器
- id: SS598
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://support.lutron.com/us/en/product/shades/article/programming/Programming-a-Lutron-Sivoia-QS-or-Palladiom-Wireless-Shade-to-a-Remote
- source_name: Lutron Support
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 原生 Lutron 遮阳编程文献，别墅交付培训用。
- summary_zh: 说明将 Sivoia QS 或 Palladiom 无线帘编程到遥控器的步骤概要。
- key_points:
  - "Sivoia QS"
  - "Palladiom"
  - "遥控"
- install_notes: 具体按最新 App/处理器指南；本库不替代原厂步骤。
- app_takeaway_zh: 用户培训：帘控优先 Lutron 体系内完成。
- training_snippet: Lutron support articles cover Sivoia/Palladiom remote programming basics.

### SS599 | C4 Forums：Lutron 遮阳推荐讨论
- id: SS599
- category: shades-climate-aux
- brand: Lutron
- subsystem: shades
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.c4forums.com/forums/topic/38870-lutron-shade-recommendations/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Lutron']
- control_layer_fit: 社区对 Serena/Caséta vs Sivoia/RA3/HomeWorks 路径的经验。
- summary_zh: 论坛讨论不同 Lutron 遮阳产品线与 C4 结合的推荐。
- key_points:
  - "社区推荐"
  - "产品线选择"
- install_notes: E4 仅作家经验。
- app_takeaway_zh: 预算级 Serena vs 工程级 Sivoia 的话术素材。
- training_snippet: Forum threads contrast Serena/Caséta vs Sivoia/HomeWorks shade paths.

### SS600 | DriverCentral：Pentair ScreenLogic Control4 驱动
- id: SS600
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/climate-fan-fireplace/pentair-screenlogic/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: ScreenLogic 接口对接 IntelliTouch/EasyTouch：水温、加热、泵、辅助回路、彩灯。
- summary_zh: 驱动页列出池/疗养控制点与接口要求。
- key_points:
  - "ScreenLogic"
  - "IntelliTouch"
  - "EasyTouch"
- install_notes: 确认具体主机型号与协议适配器。
- app_takeaway_zh: C4 泳池项目常用此驱动+ScreenLogic Interface。
- training_snippet: Pentair ScreenLogic Control4 drivers cover temps, pumps, aux, and lights.

### SS601 | ControlWorks：Pentair IntelliCenter Crestron Home 驱动
- id: SS601
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://store.controlworks.com/products/Pentair-IntelliCenter-Crestron-Home
- source_name: ControlWorks
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 第三方授权驱动：双水体、回路、灯光、Quick Actions 等。
- summary_zh: 产品页介绍 IntelliCenter Crestron Home 驱动许可与能力。
- key_points:
  - "IntelliCenter"
  - "许可"
  - "Crestron Home"
- install_notes: 需实例许可；有试用时长。
- app_takeaway_zh: Crestron 别墅泳池首选评估此驱动。
- training_snippet: ControlWorks IntelliCenter driver is a common Crestron Home pool path.

### SS602 | IntelliCenter Crestron Home 驱动应用指南 PDF
- id: SS602
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://store.controlworks.com/product_resources/documentation/Pentair_IntelliCenter_Crestron-Home_V2.5.0_Help_(ControlWorks).abc3af19-ba7f-489c-b11c-468b03c7907f.pdf
- source_name: ControlWorks
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: v2.5.0 帮助文档。
- summary_zh: 详述驱动对象、回路数量与配置注意。
- key_points:
  - "Help PDF"
  - "v2.5.0"
- install_notes: None
- app_takeaway_zh: 编程包附 Help。
- training_snippet: IntelliCenter help PDFs define circuit/feature object maps.

### SS603 | ScreenLogic2 Interface 安装用户指南（Pentair）
- id: SS603
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/screenlogic2-interface-installation-users-guide-english.pdf
- source_name: Pentair
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 官方安装用户指南，协议适配器与 Load Center COM 口。
- summary_zh: 指导 ScreenLogic2 接口与 IntelliTouch/EasyTouch 系统连接概念。
- key_points:
  - "官方指南"
  - "COM口"
  - "适配器"
- install_notes: 仅持证泳池/电气人员施工；库中不复述接线颜色步骤。
- app_takeaway_zh: 网络与弱电说明书引用官方指南版本号。
- training_snippet: Pentair ScreenLogic2 guides are E1 install references for villa pools.

### SS604 | ScreenLogic Wireless Connection Kit 手册
- id: SS604
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/screenlogic2/manuals/ScreenLogic_Interface_Wireless_Connection_Kit_for_IntelliTouch_and_EasyTouch_Systems_English.pdf
- source_name: Pentair
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 无线套件手册，室内外收发配对。
- summary_zh: 说明 Wireless Connection Kit 用于 IntelliTouch/EasyTouch 的部署要点。
- key_points:
  - "无线套件"
  - "收发配对"
- install_notes: 优先有线协议适配器以提升可靠性。
- app_takeaway_zh: 大宅优先有线 ScreenLogic。
- training_snippet: Wireless ScreenLogic kits exist but wired adapters are preferred for estates.

### SS605 | EasyTouch & IntelliTouch Load Center 安装指南
- id: SS605
- category: shades-climate-aux
- brand: Pentair
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.pentair.com/content/dam/extranet/nam/pentair-pool/residential/automation/intellitouch/manual/easytouch-intellitouch-control-system-load-center-installation-guide.pdf
- source_name: Pentair
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 负载中心安装指南索引。
- summary_zh: 覆盖 EasyTouch/IntelliTouch 控制与负载中心安装要点。
- key_points:
  - "Load Center"
  - "官方安装"
- install_notes: 本库不提供电气施工步骤。
- app_takeaway_zh: 土建阶段预留负载中心位置与导管。
- training_snippet: Load-center guides inform rough-in planning for Pentair systems.

### SS606 | C4 Forums：Pentair Wireless/Protocol 与 Control4
- id: SS606
- category: shades-climate-aux
- brand: Pentair
- subsystem: community
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.c4forums.com/forums/topic/38409-pentair-wireless-to-protocol-converter-and-control4/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 社区讨论协议转换器与型号陷阱。
- summary_zh: 论坛线程讨论 Wireless to Protocol Converter 与 C4 实战问题。
- key_points:
  - "社区"
  - "协议转换器"
- install_notes: E4 经验需与现行驱动文档核对。
- app_takeaway_zh: 勘察确认主机是 EasyTouch 还是 IntelliTouch。
- training_snippet: Forum threads warn about Pentair protocol-adapter model mismatches.

### SS607 | C4 Forums：Pentair Pool Integration 总讨论
- id: SS607
- category: shades-climate-aux
- brand: Pentair
- subsystem: community
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.c4forums.com/forums/topic/24270-pentair-pool-integration/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 长期集成讨论串。
- summary_zh: 综合讨论 Pentair 泳池与 Control4 的多种接法与限制。
- key_points:
  - "长期讨论"
  - "限制"
- install_notes: None
- app_takeaway_zh: 售前阅读以防过度承诺。
- training_snippet: Long-running C4 Forum threads catalog Pentair integration caveats.

### SS608 | Jandy 泳池自动化产品总览
- id: SS608
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.jandy.com/en/products/pool-automation
- source_name: Jandy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron']
- control_layer_fit: 厂商产品线入口，常列 C4/Crestron 伙伴能力。
- summary_zh: 介绍 AquaLink/iAquaLink 等泳池自动化产品。
- key_points:
  - "AquaLink"
  - "产品总览"
- install_notes: None
- app_takeaway_zh: Fluidra/Jandy 体系别墅泳池选型起点。
- training_snippet: Jandy pool-automation pages introduce AquaLink/iAquaLink lines.

### SS609 | iAquaLink Web Connect Device 安装手册
- id: SS609
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.iaqualink.com/-/media/zodiac/global/downloads/jandy/automation/h0364100.pdf?rev=9a4da41edaa547d9b28f5862ab0fc0de
- source_name: iAquaLink / Jandy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: IQ900 Web Connect 安装文献。
- summary_zh: 指导 Web Connect 设备连接到电源中心与路由器的概念要求。
- key_points:
  - "IQ900"
  - "Web Connect"
  - "安装"
- install_notes: 须合格泳池/电气专业人员；高低压导管分离等见原文。
- app_takeaway_zh: RS 固件版本门槛写入验收。
- training_snippet: iAquaLink Web Connect manuals cover IQ900 cloud/local connectivity.

### SS610 | iAquaLink IQ900 支持页
- id: SS610
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.iaqualink.com/en/support/iq900
- source_name: iAquaLink
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 支持入口与文档聚合。
- summary_zh: IQ900 产品支持与文档链接页。
- key_points:
  - "支持页"
  - "IQ900"
- install_notes: None
- app_takeaway_zh: 业主保修与固件入口。
- training_snippet: IQ900 support hub aggregates owner/installer resources.

### SS611 | Crestron App Market：Jandy iAquaLink v1.1 Help
- id: SS611
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://applicationmarket.crestron.com/content/Help/Jandy/Jandy_iAquaLink_v1_1_Help.pdf
- source_name: Crestron
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方模块帮助：泵、加热、灯、OneTouch、盐水等命令。
- summary_zh: Help 定义 iAquaLink 模块控制点与配置参数。
- key_points:
  - "模块帮助"
  - "OneTouch"
  - "命令集"
- install_notes: None
- app_takeaway_zh: Crestron 泳池编程以 Help 为对象字典。
- training_snippet: Crestron iAquaLink help PDFs define pumps/heaters/lights/OneTouch objects.

### SS612 | Crestron Home：Pool Controllers 兼容列表
- id: SS612
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Works-With-Crestron-Home/Pools.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方列出 Jandy iAquaLink IQ900、Hayward OmniLogic、Pentair IntelliTouch 等。
- summary_zh: Works-with 泳池章节给出支持控制器型号。
- key_points:
  - "官方兼容"
  - "多品牌"
- install_notes: None
- app_takeaway_zh: 售前以该列表承诺品牌。
- training_snippet: Crestron Home pools appendix is the authoritative supported-controller list.

### SS613 | Control4 Driver Search：pool 类驱动（含 iAquaLink）
- id: SS613
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://drivers.control4.com/solr/drivers/browse?fq=primaryProxy%3A%22pool%22&q=
- source_name: Control4 Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方驱动库泳池代理类型检索。
- summary_zh: 列出 primaryProxy=pool 的驱动（含 Jandy iAquaLink 等）。
- key_points:
  - "驱动检索"
  - "pool代理"
- install_notes: 注意 certified 标志与 OS 版本。
- app_takeaway_zh: C4 泳池驱动选型入口。
- training_snippet: Control4 pool-proxy driver search includes Jandy iAquaLink entries.

### SS614 | C4 Forums：iAqualink by Jandy 讨论
- id: SS614
- category: shades-climate-aux
- brand: Jandy
- subsystem: community
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.c4forums.com/forums/topic/37081-iaqualink-by-jandy-pool-control/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 社区称 C4 控制点少于 App，多为基础灯/喷/温度。
- summary_zh: 论坛用户分享 iAquaLink 与 Control4 实际可控范围。
- key_points:
  - "能力边界"
  - "社区"
- install_notes: 勿向业主承诺 App 全功能镜像。
- app_takeaway_zh: 提案写清「基础泳池控制」。
- training_snippet: Forum users report iAquaLink→Control4 covers basics not full app parity.

### SS615 | Fluidra Pro：iAquaLink Automation App
- id: SS615
- category: shades-climate-aux
- brand: Jandy
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://www.fluidrapro.com/en/tools/iaqualink
- source_name: Fluidra Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 集团专业工具页，强调专业渠道。
- summary_zh: 介绍 iAquaLink 自动化 App 与专业支持定位。
- key_points:
  - "Fluidra"
  - "专业渠道"
- install_notes: None
- app_takeaway_zh: 与四老牌集成商协同的厂商背景。
- training_snippet: Fluidra Pro pages position iAquaLink for professional channels.

### SS616 | AquaLink RS 相关安装 PDF（Jandy）
- id: SS616
- category: shades-climate-aux
- brand: Jandy
- subsystem: install
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.jandy.com/-/media/zodiac/global/downloads/jandy/automation/6594.pdf
- source_name: Jandy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: AquaLink RS 安装文献索引。
- summary_zh: 提供自动化系统安装相关 PDF。
- key_points:
  - "AquaLink RS"
  - "安装PDF"
- install_notes: 持证施工；库内不摘接线步骤。
- app_takeaway_zh: 土建预留依据。
- training_snippet: AquaLink RS install PDFs support rough-in documentation.

### SS617 | Crestron App Market：Hayward OmniLogic v1.1
- id: SS617
- category: shades-climate-aux
- brand: Hayward
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://applicationmarket.crestron.com/hayward-omnilogic-v1-1/
- source_name: Crestron App Market
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方市场模块，TCP/IP+账户/Site ID。
- summary_zh: 提供 OmniLogic Crestron 模块版本入口。
- key_points:
  - "OmniLogic"
  - "TCP/IP"
  - "模块"
- install_notes: None
- app_takeaway_zh: 需 Hayward 账户与 Site ID。
- training_snippet: Crestron OmniLogic modules use account/Site ID over TCP/IP.

### SS618 | Hayward OmniHub 智能泳池控制产品页
- id: SS618
- category: shades-climate-aux
- brand: Hayward
- subsystem: pool-automation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.hayward.com/omnihub-smart-pool-and-spa-control-hlomnihub.html
- source_name: Hayward
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron']
- control_layer_fit: 入门级智能控制，渠道称可对接 C4/Crestron/Elan/RTI。
- summary_zh: 介绍 OmniHub 对泵、阀、继电器等的控制定位。
- key_points:
  - "OmniHub"
  - "入门智能"
  - "多平台"
- install_notes: 与 OmniLogic 全功能面板区分。
- app_takeaway_zh: 中小泳池/改造可选 OmniHub。
- training_snippet: OmniHub is Hayward’s lighter smart controller marketed with legacy AV brands.

### SS619 | Crestron Home Pools 列表中的 OmniLogic 4
- id: SS619
- category: shades-climate-aux
- brand: Hayward
- subsystem: pool-automation
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Works-With-Crestron-Home/Pools.htm?cshid=WWCH-Pools
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方兼容点名 HLBASE OmniLogic 4-Relay Base。
- summary_zh: Works-with 明确 Hayward OmniLogic 4 继电器基板等。
- key_points:
  - "HLBASE"
  - "官方兼容"
- install_notes: None
- app_takeaway_zh: 选型对齐列表型号。
- training_snippet: Crestron explicitly lists Hayward OmniLogic 4 base panels.

### SS620 | 渠道页：OmniHub 与 Control4/Crestron 宣传
- id: SS620
- category: shades-climate-aux
- brand: Hayward
- subsystem: pool-automation
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://peachfrog.com/products/hayward-omnihub-pool-and-spa-smart-control-white/
- source_name: Peach Frog / Hayward dealer
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron']
- control_layer_fit: 经销商产品页复述多平台集成卖点。
- summary_zh: 零售/渠道页声称支持 Control4、Crestron、Elan、RTI。
- key_points:
  - "渠道宣传"
  - "多平台"
- install_notes: 以厂商/Crestron 官方列表最终确认为准。
- app_takeaway_zh: 售前交叉验证官方 Works-with。
- training_snippet: Dealer pages advertise OmniHub↔legacy brand support; verify on Crestron/C4 lists.

### SS621 | SpaPilot 与 Balboa/Gecko 兼容说明
- id: SS621
- category: shades-climate-aux
- brand: SpaPilot
- subsystem: spa-automation
- evidence_tier: E3
- region: Global
- source_url: https://www.zavepower.com/compatibility
- source_name: SpaPilot / Zave
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 温泉包控制经 RS-485 等对接 Balboa/Gecko；可再被四老牌场景调用。
- summary_zh: 兼容页列出支持的 Balboa 与 Gecko 控制平台。
- key_points:
  - "Balboa"
  - "Gecko"
  - "RS-485"
- install_notes: 温泉包品牌件不可随意混用。
- app_takeaway_zh: 别墅室内温泉：Spa 包本地控 + 四老牌场景触发。
- training_snippet: SpaPilot compatibility lists enable Balboa/Gecko packs under higher-level scenes.

### SS622 | Balboa vs Gecko 温泉控制对比文
- id: SS622
- category: shades-climate-aux
- brand: Balboa
- subsystem: spa-controls
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.bathandspaparts.com/blogs/news/balboa-vs-gecko-spa-controls-what-hot-tub-owners-should-know
- source_name: Bath & Spa Parts
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 配件不可互换警示，改造勘察用。
- summary_zh: 对比 Balboa 与 Gecko 控制在接口、传感器与线束上的差异。
- key_points:
  - "不可混用"
  - "勘察"
- install_notes: None
- app_takeaway_zh: 更换温泉脑前核对平台。
- training_snippet: Balboa vs Gecko articles warn against mixing incompatible spa packs.

### SS623 | 加拿大渠道：OmniHub 产品介绍
- id: SS623
- category: shades-climate-aux
- brand: Hayward
- subsystem: pool-automation
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://poolproductscanada.ca/products/hayward-omnihub-smart-pool-and-spa-control
- source_name: Pool Products Canada
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美另一渠道产品描述，补充规格话术。
- summary_zh: 介绍 OmniHub 智能泳池/温泉控制卖点。
- key_points:
  - "渠道"
  - "OmniHub"
- install_notes: None
- app_takeaway_zh: 跨境项目核对认证与电压。
- training_snippet: Regional dealer pages supplement OmniHub positioning for North America.

### SS624 | Crestron drivers-api：Somfy UAI+ Gateway 驱动说明
- id: SS624
- category: shades-climate-aux
- brand: Somfy
- subsystem: crestron-driver
- evidence_tier: E1
- region: Global
- source_url: https://drivers-api.crestron.io/help/driver/3515
- source_name: Crestron Drivers API
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 驱动依赖与开/关/停/收藏/位置等能力说明。
- summary_zh: 系统要求与依赖页描述 Somfy UAI+ IP 驱动能力。
- key_points:
  - "UAI+驱动"
  - "位置"
  - "收藏"
- install_notes: None
- app_takeaway_zh: Crestron 程序员核对本页依赖版本。
- training_snippet: Crestron drivers-api documents Somfy UAI+ open/close/stop/favorites/position.

### SS625 | 渠道托管 ScreenLogic2 指南副本
- id: SS625
- category: shades-climate-aux
- brand: Pentair
- subsystem: screenlogic
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://swimhere.com/wp-content/uploads/2024/07/controllers-Pentair-ScreenLogic-2-Interface.pdf
- source_name: Dealer-hosted Pentair
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安装指南镜像，防官网链失效。
- summary_zh: 托管 ScreenLogic2 Interface 相关 PDF。
- key_points:
  - "镜像PDF"
  - "ScreenLogic2"
- install_notes: 以 Pentair 官网版为准。
- app_takeaway_zh: 文档冗余策略。
- training_snippet: Dealer-hosted ScreenLogic PDFs provide offline install references.

### SS626 | 另一渠道 ScreenLogic2 用户指南副本
- id: SS626
- category: shades-climate-aux
- brand: Pentair
- subsystem: screenlogic
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://xteriorcreations.com/wp-content/uploads/2025/03/screenlogic2-interface-installation-users-guide-english.pdf
- source_name: Xterior Creations / Pentair
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 2025 托管副本。
- summary_zh: ScreenLogic2 Interface Installation & User’s Guide 英文副本。
- key_points:
  - "2025副本"
  - "用户指南"
- install_notes: None
- app_takeaway_zh: 与官网 PDF 校验哈希/版本。
- training_snippet: Additional hosted copies help archive ScreenLogic guidance.

### SS627 | Alarm.com：Somfy TaHoma 集成指南（遮阳辅机视角）
- id: SS627
- category: shades-climate-aux
- brand: Somfy
- subsystem: alarmcom-kb
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Lighting_and_Appliance_Control/Somfy/Somfy_TaHoma_Smart_Shade_Control/Somfy_TaHoma_Smart_Shade_Control_-_Integration_Guide
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 从遮阳辅机角度引用同一官方指南。
- summary_zh: 指导 TaHoma 通道与 Alarm.com 自动化结合。
- key_points:
  - "辅机视角"
  - "云遮阳"
- install_notes: RTS 精度限制同样适用。
- app_takeaway_zh: 安防云控帘作辅，不替代 SDN 工程。
- training_snippet: TaHoma–Alarm.com guide reused as shade-aux evidence of cloud control limits.

### SS628 | Caséta：与 Sonos 集成（遮阳/灯场景上下文）
- id: SS628
- category: shades-climate-aux
- brand: Lutron
- subsystem: caseta-sonos
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.casetawireless.com/us/en/sonos
- source_name: Lutron Caséta
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 灯/帘场景与音频联动的消费级范例；豪华项目可类比到四老牌场景。
- summary_zh: 介绍 Caséta 与 Sonos 的场景与 Pico 控制能力。
- key_points:
  - "场景联动"
  - "Sonos"
  - "Caséta"
- install_notes: None
- app_takeaway_zh: 话术：消费级已能灯帘声联动，别墅用四老牌可更强。
- training_snippet: Caséta–Sonos pages illustrate shade/light/audio scene patterns scalable to legacy brands.

### SS629 | Lutron Support：Caséta/RA2 Select 与 Sonos
- id: SS629
- category: shades-climate-aux
- brand: Lutron
- subsystem: caseta-sonos
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://support.lutron.com/us/en/product/casetawireless/article/connected-products/Integrating-Sonos-Speakers-with-Caseta-RA2-Select-Systems-using-the-Lutron-App
- source_name: Lutron Support
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 官方 App 集成步骤概要。
- summary_zh: 说明用 Lutron App 将 Sonos 纳入 Caséta/RA2 Select。
- key_points:
  - "官方步骤"
  - "App集成"
- install_notes: None
- app_takeaway_zh: 培训对照豪华项目的场景设计。
- training_snippet: Lutron support docs for Sonos pairing inform scene-design training.

### SS630 | 旧版 iAquaLink 自动化 PDF（厂商）
- id: SS630
- category: shades-climate-aux
- brand: Jandy
- subsystem: iaqualink
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.jandy.com/-/media/zodiac/global/downloads/iaqualink/automation/sa6456.pdf?rev=b1e2e1b88dea40e3b05ad4ff482633b4
- source_name: Jandy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 历史自动化文献，便于理解产品演进。
- summary_zh: 较早的 iAquaLink 自动化相关 PDF。
- key_points:
  - "历史文档"
  - "演进"
- install_notes: 以现行 IQ900 文档为准。
- app_takeaway_zh: 存量系统评估用。
- training_snippet: Legacy iAquaLink PDFs help assess older villa pool controllers.

### SS631 | OmniLogic Help 文档镜像讨论源
- id: SS631
- category: shades-climate-aux
- brand: Hayward
- subsystem: crestron
- evidence_tier: E4
- region: Global
- source_url: https://abcdocz.com/doc/897575/hayward-omnilogic-v1.0-help---crestron-application-market
- source_name: Doc mirror
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 第三方文档镜像（E4），正式以 Application Market 为准。
- summary_zh: 镜像站点收录 OmniLogic v1.0 Help 内容。
- key_points:
  - "镜像"
  - "E4"
- install_notes: 避免作唯一依据。
- app_takeaway_zh: 仅作检索线索。
- training_snippet: Third-party mirrors of OmniLogic help are E4; prefer Crestron Application Market.

### SS632 | Somfy Pro：myLink 第三方集成 FAQ
- id: SS632
- category: shades-climate-aux
- brand: Somfy
- subsystem: mylink
- evidence_tier: E1
- region: Global
- source_url: https://www.somfypro.com/support/faq?question=can-the-mylink-be-used-to-integrate-somfy-rts-motorized-products-into-third-party-control-systems
- source_name: Somfy Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: myLink Wi-Fi→RTS，通道数有限，适合轻量对接。
- summary_zh: FAQ 明确 myLink 作为第三方控制桥接 RTS 的能力与前提。
- key_points:
  - "myLink"
  - "16通道级"
  - "RTS"
- install_notes: 电机需已完成 RTS 发射器设置。
- app_takeaway_zh: 轻改造用 myLink；新建大宅用 SDN。
- training_snippet: myLink FAQs define lightweight RTS bridging versus SDN for new estates.

### SS633 | Somfy Connect BMS Interface V2（遮阳辅机）
- id: SS633
- category: shades-climate-aux
- brand: Somfy
- subsystem: bms
- evidence_tier: E3
- region: Global
- source_url: https://automated.wickedwebsites.us/wp-content/uploads/2024/03/Programming-Guide-%E2%80%93-Somfy-Connect-BMS-Interface-V2-V1.0.pdf
- source_name: Somfy (hosted)
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: BACnet 暴露位置/升降/传感器等。
- summary_zh: 指南描述对 SDN 与 animeo IP 的 BMS 对象。
- key_points:
  - "BACnet对象"
  - "animeo IP"
- install_notes: None
- app_takeaway_zh: 与 Crestron/KNX BACnet 客户端对接评估。
- training_snippet: BMS Interface V2 exposes shade objects to BACnet clients including Crestron.

### SS634 | SI Control4 Integration Tech Note
- id: SS634
- category: shades-climate-aux
- brand: Screen Innovations
- subsystem: shades
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.screeninnovations.com/docs/control4-integration-tech-note/
- source_name: Screen Innovations
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 影院幕布/遮阳 C4 技术说明。
- summary_zh: Tech Note 说明与 Control4 集成步骤与注意点。
- key_points:
  - "幕布"
  - "C4"
  - "影院"
- install_notes: None
- app_takeaway_zh: 私人影院遮阳归 aux 库。
- training_snippet: Screen Innovations tech notes cover Control4 theater shade/screen control.

