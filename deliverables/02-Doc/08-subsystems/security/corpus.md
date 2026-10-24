# X Home Easy · 别墅安防平台子系统方案库（Security）

覆盖 ADT / Alarm.com / DSC / Resideo·Honeywell Home / Qolsys / 2GIG / Axis / Bosch Security 等；即使未点名四老牌也可收录，并在 control_layer_fit 说明适合由 Control4/Crestron/Savant/Lutron 作控制中枢。

- **收集日期**：2026-10-21（Asia/Shanghai）
- **条目数**：103
- **证据分层**：E1 厂商 / E2 行业媒体 / E3 集成商·渠道 / E4 社区
- **免责声明**：公开二手资料整理，供方案建议与训练；非施工规范、非电气安全指南。

## 品牌计数

| brand | count |
|---|---|
| Alarm.com | 24 |
| Resideo | 15 |
| ADT | 12 |
| Qolsys | 12 |
| 2GIG | 10 |
| Axis | 9 |
| DSC | 8 |
| Bosch Security | 8 |
| Crestron | 2 |
| Somfy | 2 |
| Screen Innovations | 1 |

---

### SS451 | ADT Command 智能安防触控与移动端平台
- id: SS451
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.adt.com/command
- source_name: ADT
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 别墅中常作「专业值守安防层」：四老牌负责场景/影音/照明，ADT Command 负责报警值守、摄像头与门锁；联动多经场景触发或第三方兼容清单（如 Lutron Caséta），而非替代整宅总线。
- summary_zh: ADT Command 为安防优先的智能家居触控与 App 平台，支持高清视频、地理围栏自动化、远程控制灯/恒温器/锁，以及 Google 语音集成；强调双向加密与专业安装。
- key_points:
  - "安防优先触控"
  - "地理围栏"
  - "Google语音"
  - "专业安装"
- install_notes: 公开材料强调由 ADT 技师安装并接入移动 App；不涉及四老牌接线步骤。
- app_takeaway_zh: 别墅方案可把 ADT Command 定位为值守安防层，四老牌做体验层；需在合同中写清哪些场景由 ADT 规则触发、哪些由控制层编排。
- training_snippet: ADT Command is a professionally monitored security-first smart-home platform with touchpad, app, cameras, locks and geofencing. In villa designs it pairs with Control4/Crestron/Savant/Lutron as the lifestyle control layer rather than replacing it.

### SS452 | ADT Works With 第三方设备兼容清单
- id: SS452
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.adt.com/works-with
- source_name: ADT
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 公开兼容清单含 Lutron Caséta 等，说明 ADT 可作为「安防+轻自动化」入口，与四老牌中的 Lutron 照明/遮阳有直接产品级对接路径。
- summary_zh: ADT 官方 Works With 页列出可接入 Command/Control 生态的灯、锁、恒温器、灌溉与音频等第三方品牌，含 Lutron。
- key_points:
  - "官方兼容清单"
  - "Lutron Caséta"
  - "灌溉/音频"
- install_notes: None
- app_takeaway_zh: 选型时先查 ADT Works With；若别墅已定 Control4/Crestron，需确认设备是走 ADT 云还是走控制层驱动，避免双控冲突。
- training_snippet: ADT publishes a Works With list including Lutron Caséta; useful evidence that monitored security platforms can share shade/lighting endpoints with legacy control brands.

### SS453 | ADT Help：Lutron 与 Command 集成 FAQ
- id: SS453
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.adt.com/article/Lutron-FAQs
- source_name: ADT Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Lutron']
- control_layer_fit: 官方 FAQ 说明 Caséta/Smart Bridge Pro 与 ADT 规则/场景的配合方式，适合作为「安防平台侧」对接文档。
- summary_zh: ADT 支持文档回答 Lutron 灯光/遮阳如何加入 ADT 规则、日程与远程控制，并提示 Smart Bridge Pro 等前置条件。
- key_points:
  - "Caséta对接"
  - "规则与日程"
  - "Smart Bridge Pro"
- install_notes: 需按 ADT 文档启用桥接；遮阳百分比反馈能力可能受限，复杂遮阳编排仍宜交给 Lutron/四老牌控制层。
- app_takeaway_zh: 融合方案中：简单安防联动（离家关灯关帘）可用 ADT 规则；精细遮阳场景仍归 Lutron/控制层。
- training_snippet: ADT documents Lutron Caséta integration for rules and schedules; villa projects should keep fine shade choreography on Lutron/legacy controllers.

### SS454 | ADT Help：Sonos 与 Command 场景 FAQ
- id: SS454
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.adt.com/article/Sonos-FAQs
- source_name: ADT Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安防平台可把音频播放纳入「布防/撤防」场景；豪华影音仍多由 Crestron/Control4/Savant 主导，ADT 侧多为轻量场景触发。
- summary_zh: ADT 文档说明 Sonos 可加入 Command 场景（如播放收藏），完整音源/分组控制仍依赖 Sonos App。
- key_points:
  - "场景级音频"
  - "功能边界"
  - "安防场景触发"
- install_notes: None
- app_takeaway_zh: 提醒用户：ADT 场景级 Sonos ≠ 整宅影音分布式；别墅影音仍应用四老牌+专业 AV。
- training_snippet: ADT can trigger Sonos favorites in security scenes, but full multi-room AV remains a Control4/Crestron/Savant domain.

### SS455 | ADT Newsroom：年度产品与服务创新综述
- id: SS455
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://newsroom.adt.com/safe-stories/adts-year-of-innovation-includes-launch-of-major-new-products-and-services
- source_name: ADT Newsroom
- published: 2024
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 展示 ADT 从传统值守向 ADT+/Nest 生态演进；别墅项目评估时需区分 Command 遗留栈与 ADT+ 新栈。
- summary_zh: ADT 新闻稿梳理新产品与服务线，包括与 Google Nest 深化的智能安防方向。
- key_points:
  - "ADT+演进"
  - "Nest合作"
  - "产品线更新"
- install_notes: None
- app_takeaway_zh: 建议书中写明客户签约的是 Command 还是 ADT+，以免集成商驱动与传感器协议选错。
- training_snippet: ADT’s public innovation narrative highlights ADT+ and Nest collaboration; villa specs must name the exact ADT stack generation.

### SS456 | The Verge：ADT+ 与 Google Nest 智能安防评测
- id: SS456
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.theverge.com/tech/803867/adt-plus-home-security-google-nest-smart-home
- source_name: The Verge
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 独立媒体视角说明 ADT+ 更贴近 Nest 生态；与四老牌别墅方案并存时，需界定视频入口与报警值守边界。
- summary_zh: 评测介绍 ADT+ App、Nest 摄像头/恒温器联动与语音控制体验，并对比传统 Command。
- key_points:
  - "媒体评测"
  - "Nest视频"
  - "App体验"
- install_notes: None
- app_takeaway_zh: 豪华别墅若已有 Crestron/Control4 视频墙，Nest/ADT+ 摄像头宜作值守补充而非唯一 UI。
- training_snippet: Press coverage of ADT+ shows Nest-centric UX; legacy control brands still own whole-home UI in luxury villas.

### SS457 | Google 支持：设置 ADT 与 Google Nest/Home
- id: SS457
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://support.google.com/googlenest/answer/11512937
- source_name: Google Support
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 说明账号绑定与语音/自动化能力边界；控制层融合时避免双重地理围栏冲突。
- summary_zh: Google 官方步骤说明如何关联 ADT 账户以使用 Nest 设备与 Google Assistant 指令。
- key_points:
  - "账号绑定"
  - "Assistant"
  - "Nest设备"
- install_notes: None
- app_takeaway_zh: 地理围栏建议只保留一层（ADT 或四老牌），防止重复触发。
- training_snippet: Google documents ADT account linking for Nest/Assistant; villa designs should avoid dual geofence logic.

### SS458 | ADT Help：Command/Control 设备与面板说明
- id: SS458
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.adt.com/article/Devices
- source_name: ADT Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 设备目录页有助于识别 SiX 传感器等协议代际，评估与别墅有线控制系统并存时的传感器选型。
- summary_zh: 帮助中心列出 Command 体系下可用设备类型与相关支持文章入口。
- key_points:
  - "设备目录"
  - "传感器代际"
  - "支持入口"
- install_notes: None
- app_takeaway_zh: 改造项目先盘点现有 ADT 传感器协议，再决定是否保留值守合同。
- training_snippet: ADT device help pages are useful for inventorying sensor generations before hybrid villa upgrades.

### SS459 | ADT Help：ADT+ App 介绍与使用
- id: SS459
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.adt.com/article/adt-Smart-Home-Security-ADT-App-Introduction-and-Usage
- source_name: ADT Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 用户侧 App 能力说明，便于对比四老牌 App 的职责划分（安防 vs 全屋场景）。
- summary_zh: 介绍 ADT+ App 的布撤防、视频、自动化与通知等核心用法。
- key_points:
  - "App职责"
  - "布撤防"
  - "通知"
- install_notes: None
- app_takeaway_zh: 交付时给业主一张「哪个 App 管什么」对照表。
- training_snippet: ADT+ app docs clarify security-centric UX versus whole-home control apps from C4/Crestron/Savant/Lutron.

### SS460 | ADT 方案对比页：家用安防套餐比较
- id: SS460
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.adt.com/compare
- source_name: ADT
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 套餐对比有助于别墅项目估算值守费用与功能包；与集成商自建 Alarm.com 方案可对照。
- summary_zh: 官方对比不同 ADT 安防/智能家居套餐的功能差异。
- key_points:
  - "套餐对比"
  - "值守费用"
  - "功能包"
- install_notes: None
- app_takeaway_zh: 高端别墅常选「集成商 Alarm.com 经销」或「ADT 直签」二选一，需在提案中对比 SLA。
- training_snippet: ADT compare pages help contrast direct ADT monitoring packages versus integrator-led Alarm.com designs.

### SS461 | Alarm.com 官方主站：智能安防与监控平台
- id: SS461
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美别墅安防最常见「经销商平台」：面板多为 Qolsys/2GIG/DSC，上层自动化与视频由 Alarm.com 云提供；四老牌通过面板驱动或场景事件对接。
- summary_zh: Alarm.com 定位为通过授权服务商交付的整物业保护与自动化平台，强调 App、视频分析与场景。
- key_points:
  - "经销商模式"
  - "整物业保护"
  - "App+视频"
- install_notes: 终端用户通常不能直签平台，需经授权经销商；与四老牌集成商常为同一或合作团队。
- app_takeaway_zh: 提案写清：值守中心、蜂窝备份、视频套餐与控制层驱动是否同属一家集成商。
- training_snippet: Alarm.com is a dealer-delivered security/automation cloud widely used in villas; panels integrate with Control4 and other controllers via security drivers.

### SS462 | Alarm.com Ecosystem 硬件生态伙伴页
- id: SS462
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: Global
- source_url: https://international.alarm.com/ecosystem/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 列出面板（2GIG/DSC Neo/Qolsys 等）、摄像头、锁、气候与照明控制伙伴，是子系统选型目录。
- summary_zh: 国际站 Ecosystem 汇总经测试的面板、摄像机、Z-Wave 开关/调光、恒温器与门锁等。
- key_points:
  - "面板清单"
  - "摄像机"
  - "Z-Wave生态"
- install_notes: 未出现在 Device Directory 的设备不保证兼容。
- app_takeaway_zh: 别墅 BOM 应以 Alarm.com Device Directory 为准，再映射到 Control4/Crestron 驱动。
- training_snippet: Alarm.com ecosystem pages list Neo/Qolsys/2GIG panels and Z-Wave devices commonly paired with legacy home controllers.

### SS463 | Alarm.com：兼容设备目录说明（KB）
- id: SS463
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/General_Panel_Information/Where_can_a_list_of_Alarm.com-compatible_devices_be_found
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 明确 Device Directory 为权威兼容列表；训练与选型应引用官方目录而非二手清单。
- summary_zh: KB 指出完整测试设备以 Device Directory 为准，公开 Ecosystem 仅为非穷尽列表。
- key_points:
  - "权威目录"
  - "兼容性警告"
  - "经销商门户"
- install_notes: None
- app_takeaway_zh: 集成商交付前应截取当日 Device Directory 作为附件。
- training_snippet: Alarm.com states its Device Directory is authoritative; villa BOMs should cite it when claiming compatibility.

### SS464 | Alarm.com：不兼容第三方自动化/通信模块（KB）
- id: SS464
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/General_Panel_Information/Is_Alarm.com_compatible_with_third_party_modules%3F
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4', 'Crestron', 'Savant']
- control_layer_fit: 官方否定「第三方自动化模块挂 Alarm.com」；与四老牌融合应走面板原生集成或事件联动，而非私有通信模块。
- summary_zh: KB 明确不支持第三方家居自动化/通信模块与 Alarm.com 模块并用，推荐面板内置 Z-Wave 与 Dual-Path。
- key_points:
  - "禁止第三方模块"
  - "Dual-Path"
  - "内置Z-Wave"
- install_notes: 不要用灰产模块「桥」Alarm.com；Control4 对接用厂商认证面板驱动。
- app_takeaway_zh: 方案库必须标注：Alarm.com↔四老牌合法路径是面板级集成，不是第三方通信模块。
- training_snippet: Alarm.com forbids third-party automation/communication modules; legacy-brand fusion must use certified panel integrations.

### SS465 | Alarm.com 成为服务商/合作伙伴页
- id: SS465
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://alarm.com/new-partner/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 说明平台通过授权服务商交付，并强调不是中心站本身；别墅项目需同时有值守中心合同。
- summary_zh: 介绍 Partner Success、培训、硬件采购与「Alarm.com 非中心站」等 FAQ。
- key_points:
  - "授权服务商"
  - "非中心站"
  - "培训支持"
- install_notes: None
- app_takeaway_zh: 合同拆分：平台订阅 / 中心站值守 / 四老牌维保。
- training_snippet: Alarm.com partner docs clarify dealer + central-station split; villa contracts should mirror that structure.

### SS466 | Alarm.com 硬件伙伴目录
- id: SS466
- category: security
- brand: Alarm.com
- subsystem: security-platform
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://alarm.com/hardware/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美硬件伙伴入口，便于检索面板与摄像机型号用于别墅安防 BOM。
- summary_zh: 官方硬件页汇总兼容面板、视频与自动化硬件伙伴。
- key_points:
  - "硬件伙伴"
  - "面板/视频"
  - "选型入口"
- install_notes: None
- app_takeaway_zh: 与四老牌驱动库交叉核对型号。
- training_snippet: Alarm.com hardware partner pages are primary sources for villa security BOMs.

### SS467 | Alarm.com Video Analytics 产品页
- id: SS467
- category: security
- brand: Alarm.com
- subsystem: video-analytics
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/video-analytics/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频分析（人/车/动物/包裹）是别墅周界安防卖点；四老牌可订阅报警事件做灯光/门锁场景，但分析引擎在 Alarm.com。
- summary_zh: 介绍对象检测、规则区域、行程线与告警推送等视频分析能力。
- key_points:
  - "人车检测"
  - "规则区域"
  - "告警"
- install_notes: None
- app_takeaway_zh: 建议「分析在云、场景在控制层」：Alarm.com 出事件，Control4/Crestron 做灯光威慑。
- training_snippet: Alarm.com Video Analytics can feed events into Control4/Crestron lighting deterrence scenes.

### SS468 | Alarm.com KB：Video Analytics Overview
- id: SS468
- category: security
- brand: Alarm.com
- subsystem: video-analytics
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Video_Devices/General_Video_Information/Video_Analytics_Overview
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 经销商侧技术概述，适合作为训练语料中的能力边界说明。
- summary_zh: KB 概述视频分析功能、兼容摄像机与配置要点。
- key_points:
  - "经销商KB"
  - "兼容机型"
  - "配置要点"
- install_notes: 隐私区域与误报调参需现场标定。
- app_takeaway_zh: 交付清单应含分析区域图纸。
- training_snippet: Alarm.com KB overview is a solid training source on analytics capabilities and camera prerequisites.

### SS469 | Alarm.com Geo-Services 位置自动化
- id: SS469
- category: security
- brand: Alarm.com
- subsystem: geo-services
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/resources/geo-services-location-automation/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 地理围栏可驱动布撤防、灯光与恒温器；与四老牌地理围栏并存时需统一策略。
- summary_zh: 介绍基于手机位置的提醒与自动化（安防、照明、温控、摄像）。
- key_points:
  - "地理围栏"
  - "离家/回家"
  - "多设备触发"
- install_notes: None
- app_takeaway_zh: APP 提案写「单一地理围栏源」。
- training_snippet: Geo-Services are powerful but should not duplicate Control4/Savant geofence rules.

### SS470 | Alarm.com Smart Scenes 资源文
- id: SS470
- category: security
- brand: Alarm.com
- subsystem: scenes
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/resources/scenes-home-customize/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Scenes 把安防与 Z-Wave 设备一键编排；复杂别墅影音/遮阳场景仍宜在四老牌侧。
- summary_zh: 说明如何用 Scenes 组合安防、锁、车库、灯与恒温器。
- key_points:
  - "一键场景"
  - "安防+自动化"
  - "能力边界"
- install_notes: None
- app_takeaway_zh: 划分：Alarm.com 管安防相关场景；四老牌管影音/遮阳/泳池。
- training_snippet: Alarm.com Scenes cover security-centric automation; luxury AV/shades/pools stay on legacy controllers.

### SS471 | Alarm.com 24/7 Professional Monitoring
- id: SS471
- category: security
- brand: Alarm.com
- subsystem: monitoring
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/24-7-professional-monitoring/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 强调专业值守能力；别墅 SLA 谈判依据。
- summary_zh: 介绍全天候专业监控服务卖点与平台能力。
- key_points:
  - "24/7值守"
  - "服务卖点"
  - "平台能力"
- install_notes: None
- app_takeaway_zh: 与 ADT 直签值守对比响应流程。
- training_snippet: Alarm.com monitoring pages support villa SLA comparisons versus ADT direct monitoring.

### SS472 | CE Pro：Somfy 组件接入 Alarm.com 生态
- id: SS472
- category: security
- brand: Alarm.com
- subsystem: shades-cross
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/briefs/somfy-components-now-integrate-into-alarm-com/95197/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安防平台与遮阳品牌云对接案例，说明「安防云也可控帘」；精细遮阳仍可回落到 Somfy SDN + 四老牌。
- summary_zh: 报道 Somfy 经 TaHoma 等网关进入 Alarm.com，实现遮阳/遮篷远程与自动化。
- key_points:
  - "Somfy×Alarm.com"
  - "云对接"
  - "遮阳"
- install_notes: None
- app_takeaway_zh: 双云控帘时明确主控以免指令冲突。
- training_snippet: CE Pro coverage of Somfy→Alarm.com shows security clouds absorbing shade control; SDN+legacy remains for pro villas.

### SS473 | CE Pro：Alarm.com 从 ADT+Google 平台获特许权相关报道
- id: SS473
- category: security
- brand: Alarm.com
- subsystem: platform
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/news/alarm-com-to-earn-royalties-from-adt-google-platform/38905/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 行业媒体揭示 ADT 与 Alarm.com 技术渊源，评估别墅存量客户迁移时有用。
- summary_zh: 报道 Alarm.com 与 ADT/Google 平台之间的商业与技术关系。
- key_points:
  - "ADT渊源"
  - "行业媒体"
  - "迁移背景"
- install_notes: None
- app_takeaway_zh: 存量 ADT 客户改四老牌时，先确认底层是否仍为 Alarm.com 技术栈。
- training_snippet: Trade press on ADT–Alarm.com ties helps diagnose legacy villa security stacks.

### SS474 | Alarm.com vs ADT 经销视角对比文
- id: SS474
- category: security
- brand: Alarm.com
- subsystem: dealer-compare
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://alarmnewengland.com/blog/alarm-com-vs-adt/
- source_name: Alarm New England
- published: 2026
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 经销商视角对比定制化与直签服务差异，适合渠道话术素材。
- summary_zh: 从经销商角度比较 Alarm.com 定制灵活度与 ADT 一体化服务。
- key_points:
  - "经销商视角"
  - "定制vs直签"
  - "话术"
- install_notes: None
- app_takeaway_zh: 别墅客户「要定制集成」偏向 Alarm.com 经销商路线。
- training_snippet: Dealer blogs contrasting Alarm.com vs ADT inform channel recommendations for custom villas.

### SS475 | DSC 新闻：PowerSeries Neo 扩展 Control4 集成
- id: SS475
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://www.dsc.com/index.php?id=56&o=view_release
- source_name: DSC / Tyco
- published: 2016-05-06
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 厂商官方宣布 Neo↔Control4，是四老牌安防融合的里程碑材料。
- summary_zh: Tyco/DSC 宣布 PowerSeries Neo 入侵平台加入 Control4 家庭自动化合作组合，支持触屏/手机布撤防与场景联动。
- key_points:
  - "官方合作"
  - "Neo×Control4"
  - "场景联动"
- install_notes: 需匹配当时 OS 与通信模块版本；现场以现行驱动为准。
- app_takeaway_zh: 可作为「有线安防面板原生对接 Control4」的权威引用。
- training_snippet: DSC’s official Neo–Control4 announcement is primary evidence of legacy-brand security fusion.

### SS476 | DSC HS2016 Neo 面板产品页（Control4 相关）
- id: SS476
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://www.dsc.com/alarm-security-products/HS2016%20-%20PowerSeries%20Neo%20Control%20Panels%20-%20Control4/2601
- source_name: DSC
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 列出 Neo 分区/防区扩展与安装文档入口，别墅混合有线无线安防常用。
- summary_zh: HS2016 规格：板上防区、无线扩展、分区、事件缓冲与用户码等，并链到安装指南。
- key_points:
  - "HS2016规格"
  - "混合防区"
  - "安装文档"
- install_notes: 模板化编程与互联烟感需注意固件版本。
- app_takeaway_zh: 别墅安防 BOM 可从 HS2016/2032/2064/2128 家族选型。
- training_snippet: DSC HS2016 product pages provide Neo capacity figures for villa security BOMs.

### SS477 | Crestron Home：DSC 安防系统对接文档
- id: SS477
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Security-Systems/DSC-Security.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: Crestron Home OS 官方支持 Neo 与经典 PowerSeries，经 IT-100 串口；明确键盘仿真能力边界。
- summary_zh: 列出支持面板型号、IT-100 接线表（9600 8N1）、时间设置与 TLM 关闭、Stay 模式防区定义等。
- key_points:
  - "IT-100串口"
  - "支持型号清单"
  - "Stay防区"
- install_notes: 公开文档含默认安装码提示；实装须由持证人员更改默认码。不提供带电作业步骤。
- app_takeaway_zh: Crestron 别墅项目优先查此官方附录再选型 Neo。
- training_snippet: Crestron Home’s DSC appendix documents IT-100 serial integration and Stay-mode zone requirements.

### SS478 | Crestron groups.io：DSC Neo IP 驱动支持说明
- id: SS478
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E4
- region: Global
- source_url: https://groups.io/g/crestron/topic/dsc_neo_module/81240910
- source_name: Crestron Community
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方支持工程师确认 Neo IP 驱动版本与 CH/4-Series 固件门槛。
- summary_zh: 帖文指出 Neo FW v5.43 起经 2021-09 IP 驱动支持，并给出 drivers.crestron.io 链接与 OS 版本要求。
- key_points:
  - "IP驱动"
  - "固件门槛"
  - "社区E4"
- install_notes: 社区信息需与现行 drivers 站点交叉验证。
- app_takeaway_zh: 标注证据层级 E4，正式 BOM 仍以 Crestron 驱动库为准。
- training_snippet: Community confirmation of DSC Neo IP driver versions complements official Crestron docs.

### SS479 | PowerSeries Neo↔Control4 集成手册（经销商 PDF）
- id: SS479
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E3
- region: Europe
- source_url: https://www.dema.ch/media/catalog/product/pdf/1976004447/pdf_file_2/en_US/DSC%20PowerSeries%20Neo_Integration%20Manual_EN.pdf
- source_name: DEMA / DSC Integration Manual
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 详述 TL280 IP 通信模块与 C4 连接参数（DLS 端口、密码、分区选项），欧洲渠道可见副本。
- summary_zh: 手册说明 TL280/TL2803G 设置 IP/掩码/网关/DLS 端口、面板 [403]/[382] 等选项及 40-bit 凭证。
- key_points:
  - "TL280"
  - "DLS端口3062"
  - "凭证位长"
- install_notes: 仅作公开集成参数备忘；现场编程由持证人员执行。TL280 v4.1 与 Neo Go 并存限制见原文。
- app_takeaway_zh: Control4+Neo 项目把 TL280 版本与静态 IP 写入网络说明书。
- training_snippet: Neo–Control4 manuals document TL280 IP communicator settings used by villa integrators.

### SS480 | DriverCentral：DSC IT-100 Control4 驱动
- id: SS480
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/security-systems/dsc-it-100-control4-integration-driver/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 第三方/认证驱动市场条目，覆盖经典 PowerSeries 串口路径。
- summary_zh: DriverCentral 提供 DSC IT-100 与 Control4 集成驱动产品页。
- key_points:
  - "IT-100"
  - "驱动市场"
  - "串口路径"
- install_notes: None
- app_takeaway_zh: 新项目优先官方 IP Neo 驱动；存量 IT-100 可查此页。
- training_snippet: DriverCentral lists DSC IT-100 Control4 drivers for legacy PowerSeries serial integrations.

### SS481 | Resideo Pro：Control4 技术合作伙伴页
- id: SS481
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.resideo.com/us/en/pro/resources/security/technology-partnerships/control4/
- source_name: Resideo Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方定义 Control4 Certified Partner 与 4232CBM 单模块覆盖 VISTA/ProSeries 的价值。
- summary_zh: 说明认证驱动、实验室互操作测试，以及 4232CBM 可导入防区字母描述简化施工。
- key_points:
  - "认证伙伴"
  - "4232CBM"
  - "防区描述导入"
- install_notes: 注意部分路径与 Total Connect 互斥，见后续条目。
- app_takeaway_zh: 北美别墅安防+Control4 首选查阅此官方伙伴页。
- training_snippet: Resideo’s Control4 partnership page documents certified drivers and 4232CBM simplification.

### SS482 | Snap One 新闻：ProSeries 现已集成 Control4
- id: SS482
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://news.snapav.com/post/proseries-security-products-now-integrate-with-control4
- source_name: Snap One / ADI
- published: 2025-08
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 渠道官方宣布 First Alert/Honeywell Home/Resideo ProSeries 经新驱动接入 Control4，并提及 ClareOne 停产替代。
- summary_zh: 称美国/加拿大经销商可用 ProSeries 完整安全方案并获 Partner Rewards，覆盖至 250 防区等。
- key_points:
  - "渠道官宣"
  - "ClareOne替代"
  - "250防区"
- install_notes: None
- app_takeaway_zh: ClareOne 存量客户迁移话术可引用此文。
- training_snippet: Snap One’s ProSeries–Control4 launch is key channel evidence for villa security upgrades.

### SS483 | Alarm Grid：Resideo PRO Series↔Control4 集成指南（2025-07-25）
- id: SS483
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/documents/resideo-first-alert-pro-series-control4-integration-dated-07-25-25
- source_name: Alarm Grid
- published: 2025-07-25
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 转录官方集成指南：SDDP 发现、AN360 功能开关、配对流程与固件门槛。
- summary_zh: 要求 OS 4.1.0+、ProSeries 固件 03.2476.183+、PROWIFI、同路由器、DHCP 预留；Composer 发现后面板 Tools 配对。
- key_points:
  - "SDDP"
  - "AN360开关"
  - "固件门槛"
- install_notes: 公开流程摘要；现场须按最新厂商 PDF。改 IP 会断控，强调 DHCP 预留。
- app_takeaway_zh: 把「AN360 启用 Control4 功能包」写入经销商 checklist。
- training_snippet: Alarm Grid hosts the ProSeries–Control4 guide covering SDDP pairing and AN360 flags.

### SS484 | Alarm Grid 博客：PRO Series 与 VISTA 获 Control4 认证
- id: SS484
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/blog/resideo-pro-series-and-vista-now-certified-by-control4
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 步骤化复述发现/配对流程，便于培训。
- summary_zh: 博客列出 Composer 发现、开始配对、面板端 Pair 等基本步骤与默认安装码提示。
- key_points:
  - "步骤化"
  - "认证新闻"
  - "培训向"
- install_notes: 默认码仅文档示例，实装必须修改。
- app_takeaway_zh: 可用于内部培训幻灯，不作为对外施工单。
- training_snippet: Alarm Grid’s certification blog is a concise training source for ProSeries pairing steps.

### SS485 | Control4 Driver Search：Resideo/First Alert ProSeries 驱动
- id: SS485
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://drivers.control4.com/solr/drivers/browse?fq=manufacturer%3A%22Resideo%22&q=
- source_name: Control4 Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方驱动库条目证明 IP 安全面板驱动存在及 OS 要求。
- summary_zh: 列出 First Alert ProSeries Intrusion 等 Resideo 制造商驱动元数据。
- key_points:
  - "官方驱动库"
  - "IP面板"
  - "OS要求"
- install_notes: None
- app_takeaway_zh: 项目验收以驱动库版本号入库。
- training_snippet: Control4’s driver search listing for Resideo ProSeries is primary E1 evidence.

### SS486 | Resideo PROA7PLUS 全合一面板产品页
- id: SS486
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.resideo.com/us/en/products/security/security-systems/proa7plus-proseries-7-inch-all-in-one-panel-proa7plus
- source_name: Resideo
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 别墅常用触控面板形态；可走 Total Connect 或 Control4 集成路径。
- summary_zh: 介绍 ProSeries 7 吋一体面板能力与定位。
- key_points:
  - "一体面板"
  - "ProSeries"
  - "产品规格"
- install_notes: None
- app_takeaway_zh: 选型时同步确认通信模块（WIFI/蜂窝）与集成路径。
- training_snippet: PROA7PLUS product page anchors Resideo villa panel selection.

### SS487 | Alarm Grid：PROA7PLUS 与 Total Connect 2.0
- id: SS487
- category: security
- brand: Resideo
- subsystem: total-connect
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/can-i-use-the-honeywell-home-proa7plus-with-total-connect-2-0
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 说明面板可注册 AlarmNet360 并启用 TC2；与 Control4 路径需分别规划。
- summary_zh: FAQ 确认内置 PROWIFIZW 可走 TC2，需兼容值守套餐与 AN360 开户。
- key_points:
  - "Total Connect"
  - "AN360"
  - "WIFI通信"
- install_notes: None
- app_takeaway_zh: 若要同时 Control4+TC2，核查是否必须改用特定通信/模块组合。
- training_snippet: PROA7PLUS supports Total Connect 2.0; villa designs must choose TC2 vs Control4 path carefully.

### SS488 | Alarm Grid：4232CBM 接入 VISTA-20P
- id: SS488
- category: security
- brand: Resideo
- subsystem: vista-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/how-do-i-integrate-a-4232cbm-to-a-honeywell-vista-20p
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 经典 VISTA 经 4232CBM 进 Control4 的常见改造路径；文中提示与 TC2 互斥风险。
- summary_zh: FAQ 说明 4232CBM 接线/编程要点及与 Total Connect 不能同时使用的限制。
- key_points:
  - "4232CBM"
  - "VISTA-20P"
  - "TC2互斥"
- install_notes: 改造前确认业主是否依赖 TC2 App。
- app_takeaway_zh: 存量 VISTA 别墅升级 Control4 的关键决策点。
- training_snippet: 4232CBM enables VISTA→Control4 but can conflict with Total Connect 2.0.

### SS489 | ADI：4232CBM Honeywell Home/Resideo 手册摘录
- id: SS489
- category: security
- brand: Resideo
- subsystem: vista-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://cdn.adiglobaldistribution.us/pim/Original/10057/Upload_4232CBM_ManufacturerBrochure.pdf
- source_name: ADI / Resideo
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 厂商手册列支持 VISTA 型号与固件门槛。
- summary_zh: 介绍 4232CBM 覆盖住宅/SMB VISTA 与 ProSeries，统一安装流程。
- key_points:
  - "支持型号"
  - "固件门槛"
  - "统一流程"
- install_notes: None
- app_takeaway_zh: 把支持列印进改造勘察表。
- training_snippet: 4232CBM brochure lists supported VISTA/ProSeries panels for Control4.

### SS490 | Resideo Total Connect 兼容性图表（公开 PDF）
- id: SS490
- category: security
- brand: Resideo
- subsystem: total-connect
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://prdsecuritydocshare.blob.core.windows.net/fs1/7847I/Total-Connect-Compatibility-Chart.PDF
- source_name: Resideo
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: TC2 硬件兼容权威表，评估别墅远程 App 能力。
- summary_zh: 图表列出 Total Connect 2.0 支持的探测与通信硬件。
- key_points:
  - "兼容图表"
  - "TC2"
  - "通信硬件"
- install_notes: None
- app_takeaway_zh: 与 Control4 集成方案对照，避免互斥组合。
- training_snippet: Total Connect compatibility charts are authoritative for Resideo remote-app planning.

### SS491 | Qolsys：IQ 系统与 Control4 集成指南
- id: SS491
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://qolsys.reamaze.com/kb/connections-and-configurations/how-to-integrate-your-iq-system-with-control-4
- source_name: Qolsys KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 官方 KB：无额外硬件、SDDP、安全令牌、固件门槛；定位为安防向集成并可触发 C4 自动化。
- summary_zh: 要求 IQ2≥2.4.0 / IQ4≥4.1.0、同网、6 位用户码、启用 3rd Party、记录 secure token；已知分区/铃声限制。
- key_points:
  - "无额外硬件"
  - "secure token"
  - "能力边界"
- install_notes: 分区启用时驱动行为有已知问题；最佳实践常为关闭分区。
- app_takeaway_zh: 别墅交付 checklist：固件、6 位码、令牌备份、同网段。
- training_snippet: Qolsys official KB documents Control4 SDDP integration and security-only scope.

### SS492 | Qolsys：IQ Pro/NS 经 Installer App 对接 Control4
- id: SS492
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://qolsys.reamaze.com/kb/connections-and-configurations/how-to-integrate-your-iq-pro-with-control-4
- source_name: Qolsys KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 混合面板 IQ Pro/NS 路径，适合要 PowerG+有线的别墅。
- summary_zh: 要求最新固件、Dealer 码、6 位码显示 token、同网、SDDP 或静态 IP；驱动与 IQ 系列共用。
- key_points:
  - "IQ Pro"
  - "Installer App"
  - "静态IP"
- install_notes: None
- app_takeaway_zh: 大型别墅优先 IQ Pro 金属箱体+PowerG。
- training_snippet: IQ Pro/NS Control4 docs cover hybrid PowerG+wired villa panels.

### SS493 | Alarm Grid：IQ4 NS 与 Control4 集成步骤
- id: SS493
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/how-do-i-integrate-an-iq4-ns-panel-and-control-4
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 逐步图文：Installer App 启用 Control4、6 位码、令牌、Composer 驱动。
- summary_zh: 详述扫码连接、3RD Party>Control4 开关、令牌抄录与 Composer 搜索 Qolsys 驱动。
- key_points:
  - "步骤化"
  - "IQ4 NS"
  - "Composer"
- install_notes: 启用后用户码末尾追加 00，需提前告知业主。
- app_takeaway_zh: 把「码变 6 位」写入用户培训材料。
- training_snippet: Alarm Grid’s IQ4 NS FAQ is a practical Control4 pairing walkthrough.

### SS494 | Alarm Grid：IQ Panel 2 Plus 与 Control4
- id: SS494
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/how-do-i-integrate-a-qolsys-iq-panel-2-plus-with-control4
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 存量 IQ2+ 改造常用参考。
- summary_zh: 说明固件、OS、令牌与布撤防/自动化触发能力。
- key_points:
  - "IQ2+"
  - "存量改造"
  - "自动化钩子"
- install_notes: None
- app_takeaway_zh: 改造报价含固件升级工时。
- training_snippet: IQ Panel 2 Plus Control4 FAQs cover common retrofit stock.

### SS495 | Alarm Grid 博客：IQ2+ Control4 集成介绍
- id: SS495
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/blog/control4-integration-for-qolsys-iq-panel-2-plus
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 面向经销商的概述文，适合对内培训。
- summary_zh: 博客总结 IQ2+ 与 Control4 集成价值与基本条件。
- key_points:
  - "培训向"
  - "概述"
  - "经销商"
- install_notes: None
- app_takeaway_zh: 可作销售一页纸附件。
- training_snippet: Alarm Grid blog summarizes IQ2+–Control4 value for dealers.

### SS496 | Qolsys TSB：IQ Pro 4.2.1n 增加 Control4 支持
- id: SS496
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://dealers.qolsys.com/wp-content/uploads/2023/03/TSB-230227-421n-Update.pdf
- source_name: Qolsys TSB
- published: 2023-02
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 发布说明证明 IQ Pro 固件正式加入 Control4、Z-Wave、1000 用户等。
- summary_zh: TSB 列出 4.2.1n 新特性：Control4、Z-Wave、公共防区、全局键盘等，并强调 Wi-Fi/以太网保活升级。
- key_points:
  - "固件TSB"
  - "Control4支持"
  - "Z-Wave"
- install_notes: 面板须联网以接收后续固件。
- app_takeaway_zh: 验收记录固件版本≥4.2.1n。
- training_snippet: Qolsys TSB 230227 is E1 proof Control4 support landed in IQ Pro firmware.

### SS497 | Alarm.com KB：Qolsys 第三方集成一览
- id: SS497
- category: security
- brand: Qolsys
- subsystem: alarmcom
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/Qolsys/General_Qolsys_Information/Which_third_party_integrations_can_be_used_with_Qolsys_panels
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 平台侧列出车库门等第三方；可与 Control4 安防集成并列规划。
- summary_zh: 按 IQ5/IQ4/IQ2 列 LiftMaster 等集成及最低固件。
- key_points:
  - "第三方表"
  - "车库门"
  - "固件矩阵"
- install_notes: None
- app_takeaway_zh: 车库门若已进 Alarm.com，控制层可只做场景订阅。
- training_snippet: Alarm.com’s Qolsys third-party matrix complements Control4 security drivers.

### SS498 | CE Pro：IQ Panel 2 由 Alarm.com 驱动的智能家居服务
- id: SS498
- category: security
- brand: Qolsys
- subsystem: platform
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.cepro.com/news/qolsys_iq_panel_2_integrates_smart_home_services_is_powered_by_alarm-com/934/
- source_name: CE Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 行业媒体定位 IQ 面板为 Alarm.com 智能安防入口。
- summary_zh: 报道 IQ Panel 2 整合安防与智能家居服务并由 Alarm.com 赋能。
- key_points:
  - "媒体定位"
  - "Alarm.com赋能"
  - "IQ2"
- install_notes: None
- app_takeaway_zh: 对外话术：面板品牌 Qolsys，云平台 Alarm.com。
- training_snippet: CE Pro framed IQ Panel 2 as Alarm.com-powered smart security.

### SS499 | Alarm Grid：IQ Pro 产品页（PowerG/345MHz）
- id: SS499
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/products/qolsys-iqpr006m
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 产品级规格与兼容传感器说明，别墅混合传感器库存评估用。
- summary_zh: 介绍 IQ Pro 金属箱、PowerG 与 Honeywell/2GIG 345MHz 支持及 Control4/Alarm.com。
- key_points:
  - "混合射频"
  - "金属箱"
  - "产品规格"
- install_notes: None
- app_takeaway_zh: 多协议传感器别墅可减改线成本。
- training_snippet: IQ Pro product listings document dual-RF support useful for villa retrofits.

### SS500 | 2GIG GC2 安防控制面板产品页
- id: SS500
- category: security
- brand: 2GIG
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://2gig.com/gc2-security-control-panel/
- source_name: 2GIG
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 经典 Alarm.com 面板，别墅存量常见；与四老牌多为事件级或经 Alarm.com 生态间接配合。
- summary_zh: 介绍 GC2 安防与控制面板定位及产品要点。
- key_points:
  - "GC2"
  - "存量面板"
  - "Alarm.com"
- install_notes: None
- app_takeaway_zh: 改造评估是否升级 EDGE/IQ 以获得更好 C4 驱动。
- training_snippet: 2GIG GC2 pages document a common Alarm.com villa panel baseline.

### SS501 | 2GIG 与 Alarm.com 合作页
- id: SS501
- category: security
- brand: 2GIG
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: http://2gig.com/alarm-com/
- source_name: 2GIG
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 厂商确认平台绑定关系。
- summary_zh: 说明 2GIG 面板与 Alarm.com 服务协同。
- key_points:
  - "平台绑定"
  - "服务协同"
- install_notes: None
- app_takeaway_zh: 合同写明 Alarm.com 套餐等级。
- training_snippet: 2GIG’s Alarm.com page confirms platform pairing for monitoring/automation.

### SS502 | Alarm.com KB：2GIG 面板对比表
- id: SS502
- category: security
- brand: 2GIG
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/2GIG/2GIG_EDGE/2GIG_Panels_Comparison_chart
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: GC2/GC3/EDGE 能力矩阵，选型依据。
- summary_zh: 对比各代 2GIG 面板功能与兼容性。
- key_points:
  - "对比表"
  - "EDGE"
  - "代际"
- install_notes: None
- app_takeaway_zh: 新装优先 EDGE；存量对照此表。
- training_snippet: 2GIG panel comparison charts guide villa panel generation choices.

### SS503 | 2GIG EDGE Smart Home Manual（PDF）
- id: SS503
- category: security
- brand: 2GIG
- subsystem: smart-home
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://2gig.com/wp-content/uploads/2GIG-Edge-Smart-Home-Manual-1.pdf
- source_name: 2GIG
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 本地 Z-Wave 场景/规则能力说明；与四老牌分工：EDGE 管安防自动化，控制层管影音遮阳泳池。
- summary_zh: 手册覆盖 Z-Wave 设备本地控制、场景、日程与通知等。
- key_points:
  - "Z-Wave700"
  - "本地场景"
  - "手册"
- install_notes: Z-Wave 网络规划避免与其它控制器双控同一设备。
- app_takeaway_zh: 明确「一把锁只属于一个主控」。
- training_snippet: EDGE smart-home manual details local Z-Wave automation coexisting with legacy controllers.

### SS504 | Alarm.com KB：从 EDGE 操作 Z-Wave 设备
- id: SS504
- category: security
- brand: 2GIG
- subsystem: smart-home
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/2GIG/2GIG_EDGE/Interact_with_a_Z-Wave_device_from_a_2GIG_EDGE
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 操作路径 KB，培训用。
- summary_zh: 说明在 EDGE 上与已纳入的 Z-Wave 设备交互的方法。
- key_points:
  - "操作KB"
  - "Z-Wave"
  - "EDGE"
- install_notes: None
- app_takeaway_zh: 用户培训附录。
- training_snippet: Alarm.com KB on EDGE Z-Wave interaction supports end-user training.

### SS505 | Alarm.com KB：EDGE 上直播 Alarm.com 摄像头
- id: SS505
- category: security
- brand: 2GIG
- subsystem: video
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/2GIG/2GIG_EDGE/Stream_live_video_from_Alarm.com_cameras_on_a_2GIG_EDGE
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 面板本地看视频能力；别墅若有 Crestron 视频墙可并行。
- summary_zh: 说明 EDGE 上直播兼容摄像头/门铃及路数限制。
- key_points:
  - "面板直播"
  - "门铃"
  - "路数限制"
- install_notes: None
- app_takeaway_zh: 豪华项目视频主 UI 仍可在四老牌触屏。
- training_snippet: EDGE can stream Alarm.com cameras locally while Crestron/C4 own luxury video walls.

### SS506 | 2GIG 全产品目录 PDF
- id: SS506
- category: security
- brand: 2GIG
- subsystem: catalog
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://2gig.com/wp-content/uploads/2GIG-Full-Catalog-English.pdf
- source_name: 2GIG
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 传感器与面板全家福，勘察换件用。
- summary_zh: 英文全目录列出安防与自动化系统产品线。
- key_points:
  - "产品目录"
  - "传感器"
  - "选型"
- install_notes: None
- app_takeaway_zh: 勘察包一份目录 PDF。
- training_snippet: 2GIG full catalog supports villa sensor spare planning.

### SS507 | C4 Forums：Control4 / Alarm.com 集成讨论
- id: SS507
- category: security
- brand: 2GIG
- subsystem: community
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.c4forums.com/forums/topic/43734-control4-alarmcom-integration/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 社区经验：原生深度集成有限，常见继电器/事件变通；佐证应优先选有官方驱动的面板（Qolsys/DSC/Resideo）。
- summary_zh: 论坛讨论 C4 与 Alarm.com 集成现状与变通做法。
- key_points:
  - "社区经验"
  - "变通"
  - "驱动优先"
- install_notes: E4 仅作家经验，不作施工依据。
- app_takeaway_zh: 方案库标注：避免承诺「任意 Alarm.com 面板深度 C4」。
- training_snippet: C4 Forums threads caution that Alarm.com depth varies; prefer panels with certified drivers.

### SS508 | AXIS Camera Station Pro 产品页
- id: SS508
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://www.axis.com/en-us/products/axis-camera-station-pro
- source_name: Axis
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron', 'Control4']
- control_layer_fit: 别墅/庄园常用本地 VMS：录像与检索在 ACS Pro，直播/快照可进 Crestron Home 或 C4 摄像头代理。
- summary_zh: 介绍 ACS Pro 作为服务器型 VMS：直播、录像、检索、门禁与移动/Web 访问。
- key_points:
  - "本地VMS"
  - "门禁"
  - "移动访问"
- install_notes: 服务器位置、存储冗余与网络安全需单独设计。
- app_takeaway_zh: 大宅视频架构：ACS Pro 录像层 + 四老牌体验层。
- training_snippet: AXIS Camera Station Pro is a villa-grade VMS often paired with Crestron/Control4 viewing.

### SS509 | AXIS Camera Station Pro 技术文档入口
- id: SS509
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://help.axis.com/en-us/axis-camera-station-pro
- source_name: Axis Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 官方技术文档枢纽。
- summary_zh: 提供 ACS Pro 功能与部署文档入口。
- key_points:
  - "技术文档"
  - "部署"
  - "功能指南"
- install_notes: None
- app_takeaway_zh: 集成商书签此帮助域。
- training_snippet: Axis ACS Pro help hub is the E1 documentation root.

### SS510 | ACS Pro 第三方设备支持说明 PDF
- id: SS510
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://www.axis.com/dam/public/16/e5/71/axis-camera-station-pro-third-party-device-support-en-US-504413.pdf
- source_name: Axis
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ONVIF/RTSP 第三方摄像机支持边界，混品牌别墅摄像有用。
- summary_zh: 说明 Profile S 等第三方支持范围与功能限制。
- key_points:
  - "ONVIF"
  - "第三方机"
  - "功能限制"
- install_notes: 混品牌前做 ONVIF 实测。
- app_takeaway_zh: BOM 标注「Axis 原生优先，第三方需实测」。
- training_snippet: ACS Pro third-party PDF defines ONVIF limits for mixed camera villas.

### SS511 | Crestron Home：Cameras 兼容说明
- id: SS511
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/content/cp4r/Appendix/Works-With-Crestron-Home/Cameras.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方列出含 Axis 在内的支持摄像机模型。
- summary_zh: Crestron Home 摄像头附录含 Axis 等多品牌型号列表。
- key_points:
  - "兼容列表"
  - "Axis型号"
  - "触屏预览"
- install_notes: None
- app_takeaway_zh: 选 Cameras 列表内型号可减定制驱动。
- training_snippet: Crestron Home camera appendix lists supported Axis models for touchpanel viewing.

### SS512 | Crestron Home：摄像机兼容规格
- id: SS512
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Works-With-Crestron-Home/Cameras-Compatibility-Specs.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 编解码/分辨率等规格约束。
- summary_zh: 详述 Crestron Home 对摄像机流的兼容规格要求。
- key_points:
  - "H.264"
  - "规格约束"
  - "流参数"
- install_notes: 超出规格可能导致触屏卡顿。
- app_takeaway_zh: 调试清单含码流模板。
- training_snippet: Crestron camera compatibility specs constrain villa stream profiles.

### SS513 | DriverCentral：Camera Agent（Control4）
- id: SS513
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/security-systems/camera-agent/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: C4 侧通用摄像代理，可拉 Axis MJPEG/H.264/快照。
- summary_zh: 介绍 Camera Agent 驱动在 Control4 平台显示网络摄像的方式。
- key_points:
  - "Camera Agent"
  - "MJPEG/H.264"
  - "快照URL"
- install_notes: None
- app_takeaway_zh: 与 ACS Pro 并存时：录像仍归 Axis，C4 只做预览。
- training_snippet: Camera Agent drivers let Control4 preview Axis streams alongside ACS Pro recording.

### SS514 | ACS Pro Feature Guide
- id: SS514
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://help.axis.com/en-us/axis-camera-station-pro-feature-guide
- source_name: Axis Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 功能指南，训练「VMS 能做什么」语料。
- summary_zh: 功能级说明 ACS Pro 能力集。
- key_points:
  - "功能指南"
  - "能力集"
- install_notes: None
- app_takeaway_zh: 对业主演示前预读。
- training_snippet: ACS Pro feature guide supports sales demos and training snippets.

### SS515 | Bosch Solution 2000/3000↔Control4 安装使用指南 PDF
- id: SS515
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E3
- region: Oceania
- source_url: https://apol.com.au/mail/emarket/CONTROL4-Bosch-Solution-20241029.pdf
- source_name: APOL / VERSA
- published: 2024
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 澳洲渠道公开的 Solution 系列 C4 驱动指南：B426-M、静态 IP、固件门槛。
- summary_zh: 要求 B426-M 以太网模块、A-Link 配置、OS 3.3.0+、面板/模块最低固件，并说明输出绑定。
- key_points:
  - "B426-M"
  - "Solution 2000/3000"
  - "固件"
- install_notes: 公开指南摘要；实装遵循当地持证电工与 Bosch 最新文档。
- app_takeaway_zh: 澳新/部分亚太别墅 Bosch 面板+C4 可引此指南。
- training_snippet: Bosch Solution–Control4 guides document B426-M Ethernet prerequisites.

### SS516 | DriverCentral：Bosch Security Solution Series 驱动
- id: SS516
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/platforms/control4-drivers/security-systems/bosch-3000-control-4-driver/
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 驱动市场产品页，证明付费/认证驱动路径。
- summary_zh: 列出 Bosch Solution 系列 Control4 驱动功能与购买入口。
- key_points:
  - "驱动市场"
  - "Solution系列"
- install_notes: None
- app_takeaway_zh: 报价含驱动授权费。
- training_snippet: DriverCentral Bosch Solution drivers are the commercial integration path for Control4.

### SS517 | Bosch AU Freshdesk：Control4 for Sol 2000/3000
- id: SS517
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Oceania
- source_url: https://boschsecurityaustralia.freshdesk.com/support/solutions/articles/35000265706-control-4-with-solution-2000-and-3000-panels
- source_name: Bosch AU Support
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 厂商区域支持文确认集成存在与要点。
- summary_zh: 澳洲 Bosch 支持库文章说明 Solution 2000/3000 与 Control4。
- key_points:
  - "区域支持"
  - "官方确认"
- install_notes: None
- app_takeaway_zh: 区域项目优先引用本地支持文。
- training_snippet: Bosch Australia support confirms Control4 integration for Solution panels.

### SS518 | Bosch：经浏览器安装配置 Solution IP 模块
- id: SS518
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://media.boschsecurity.com/fs/media/pb/media/products_1/intrusion_alarm_systems/programming_reference_guides/install-configure-solution-2000-3000-ip-module.pdf
- source_name: Bosch
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: IP 模块官方配置参考，以太网对接前置。
- summary_zh: 指导 Solution 2000/3000 IP 模块的 Web 配置流程。
- key_points:
  - "IP模块"
  - "Web配置"
  - "官方PDF"
- install_notes: 仅持证人员操作；本库不复述带电步骤。
- app_takeaway_zh: 网络说明书附 IP 模块网段。
- training_snippet: Bosch IP-module guides are prerequisites for Ethernet Control4 links.

### SS519 | B Series 住宅/商用入侵面板手册
- id: SS519
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://resources.keenfinity.tech/public/documents/B_Series_Residential_Commercial_Brochure_enUS_10907851403.pdf
- source_name: Bosch / Keenfinity
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: B 系列多分区/多防区与 Z-Wave 自动化能力；与四老牌原生驱动文档较少，常作独立安防或经中间件。
- summary_zh: 手册介绍 B 系列住宅商用面板分区、防点与自动化特性。
- key_points:
  - "B Series"
  - "多分区"
  - "Z-Wave"
- install_notes: 选型前确认目标控制层是否有认证驱动。
- app_takeaway_zh: 缺口：北美 B Series↔C4/Crestron 公开驱动少，需定制评估。
- training_snippet: B Series brochures show residential capacity; native legacy-brand drivers are scarcer than Solution series.

### SS520 | C4 Forums：Chowmain Bosch Solution 驱动讨论
- id: SS520
- category: security
- brand: Bosch Security
- subsystem: community
- evidence_tier: E4
- region: Global
- source_url: https://www.c4forums.com/forums/topic/43086-chowmain-bosch-solution-2000-3000-driver/
- source_name: C4 Forums
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 集成商社区对第三方驱动体验的讨论。
- summary_zh: 论坛线程讨论 Chowmain/相关 Bosch Solution 驱动使用体验。
- key_points:
  - "社区体验"
  - "第三方驱动"
- install_notes: E4 意见需与现行 DriverCentral 文档核对。
- app_takeaway_zh: 采购前读最新评价与版本说明。
- training_snippet: Forum threads provide E4 experience notes on Bosch Solution Control4 drivers.

### SS521 | Alarm.com KB：Somfy TaHoma 智能遮阳集成指南
- id: SS521
- category: security
- brand: Alarm.com
- subsystem: ta-homa
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Lighting_and_Appliance_Control/Somfy/Somfy_TaHoma_Smart_Shade_Control/Somfy_TaHoma_Smart_Shade_Control_-_Integration_Guide
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安防云控帘官方指南；RTS 常仅 0/100%，精细遮阳仍建议 SDN+四老牌。
- summary_zh: 说明 TaHoma 与 Alarm.com 的通道/场景映射及 RTS 位置精度限制。
- key_points:
  - "TaHoma"
  - "RTS限位"
  - "场景映射"
- install_notes: 云对接依赖账号与网关在线。
- app_takeaway_zh: 别墅若同时有 Control4+Somfy SDN，Alarm.com 控帘宜降级为备用。
- training_snippet: Alarm.com’s TaHoma guide shows security-cloud shade control with RTS limits.

### SS522 | Alarm.com Compatible Hardware 营销站目录
- id: SS522
- category: security
- brand: Alarm.com
- subsystem: hardware
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://marketingsite-na04.alarm.com/hardware
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 含 Somfy TaHoma Hub 等条目的硬件目录镜像。
- summary_zh: 北美营销站硬件目录列出兼容硬件伙伴。
- key_points:
  - "硬件目录"
  - "TaHoma Hub"
- install_notes: None
- app_takeaway_zh: 与 international.alarm.com/ecosystem 交叉核对。
- training_snippet: Alarm.com hardware marketing pages list TaHoma among compatible hubs.

### SS523 | ADT Help：Command and Control 总览
- id: SS523
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://help.adt.com/article/ADT-Command-and-Control
- source_name: ADT Help
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Command 面板与 Control App FAQ/视频入口。
- summary_zh: 汇总 Command/Control 常见问题与教学视频链接。
- key_points:
  - "FAQ入口"
  - "教学视频"
- install_notes: None
- app_takeaway_zh: 业主培训收藏夹。
- training_snippet: ADT Command/Control help hub supports homeowner onboarding.

### SS524 | Crestron drivers.io：DSC 相关驱动检索入口（社区引用）
- id: SS524
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://drivers.crestron.io/rad/driver-search/3543
- source_name: Crestron Drivers
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 官方驱动站点条目（社区帖引用 ID），用于核验 Neo IP 驱动。
- summary_zh: Crestron 驱动门户上的 DSC 相关驱动检索/详情入口。
- key_points:
  - "驱动门户"
  - "Neo IP"
- install_notes: 以页面实时元数据为准。
- app_takeaway_zh: 程序员书签驱动 ID。
- training_snippet: Crestron driver portal entries validate DSC Neo IP driver availability.

### SS525 | Alarm Grid：Honeywell 4232CBM 设置文档（VISTA 家族）
- id: SS525
- category: security
- brand: Resideo
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/documents/honeywell-4232cbm-setup-for-vista-15p-vista-20p-vista-21ip-family-panels
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: VISTA-15P/20P/21iP 家族 4232CBM 设置文档托管。
- summary_zh: 提供面向 VISTA 家族的 4232CBM 设置说明文档。
- key_points:
  - "VISTA家族"
  - "设置文档"
- install_notes: 注意与 TC2 互斥说明。
- app_takeaway_zh: 改造包附此文档。
- training_snippet: 4232CBM setup docs cover common VISTA retrofit panels.

### SS526 | Qolsys KB：Alarm.com 服务 FAQ 入口
- id: SS526
- category: security
- brand: Qolsys
- subsystem: alarmcom
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://qolsys.reamaze.com/kb/alarm-dot-com-services
- source_name: Qolsys KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 面板厂侧对 Alarm.com 服务问题的入口。
- summary_zh: 汇总 IQ 面板与 Alarm.com 服务相关 FAQ。
- key_points:
  - "服务FAQ"
  - "IQ×ADC"
- install_notes: None
- app_takeaway_zh: 经销商二线支持入口。
- training_snippet: Qolsys Alarm.com FAQ hub bridges panel and cloud support.

### SS527 | Alarm.com KB：IQ 面板 PowerG PIR 摄像图片
- id: SS527
- category: security
- brand: Qolsys
- subsystem: video
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/Qolsys/General_Qolsys_Information/View_the_PowerG_PIR_camera_images_for_IQ_panels
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 报警抓拍/窥视图片能力，别墅室内防盗传感器选型。
- summary_zh: 说明如何查看 PowerG PIR 摄像在报警或 Peek-in 时上传的图像。
- key_points:
  - "PIR摄像"
  - "Peek-in"
  - "PowerG"
- install_notes: None
- app_takeaway_zh: 与 Axis 连续视频互补：传感器抓拍 + VMS 连续录像。
- training_snippet: PowerG PIR camera images complement Axis continuous recording.

### SS528 | Z-Wave Alliance：2GIG EDGE 产品目录
- id: SS528
- category: security
- brand: 2GIG
- subsystem: zwave
- evidence_tier: E1
- region: Global
- source_url: https://products.z-wavealliance.org/z-wave-product/2gig-edge/
- source_name: Z-Wave Alliance
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 认证产品页证明 Z-Wave Plus 能力。
- summary_zh: Z-Wave Alliance 列出 EDGE 为认证产品及协议信息。
- key_points:
  - "Z-Wave认证"
  - "EDGE"
- install_notes: None
- app_takeaway_zh: 强调其智能家居协议为 Z-Wave 而非 Matter（以公开资料为准）。
- training_snippet: Z-Wave Alliance listing certifies EDGE’s Z-Wave smart-home radio.

### SS529 | Crestron Home：添加 Other Devices/Cameras
- id: SS529
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Installer-Config/Step-2/Other-Devices.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: ONVIF 摄像机加入流程入口，Axis/第三方机常用。
- summary_zh: 安装配置步骤中说明通过 Other>Cameras 添加设备。
- key_points:
  - "ONVIF添加"
  - "配置步骤"
- install_notes: 建议静态 IP/预留。
- app_takeaway_zh: 与 ACS Pro 分工写进系统设计说明书。
- training_snippet: Crestron Home Other-Devices docs cover ONVIF camera onboarding.

### SS530 | Crestron Home：Camera Settings
- id: SS530
- category: security
- brand: Axis
- subsystem: vms-cameras
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Device-Settings/Cameras.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 摄像机设备设置附录。
- summary_zh: 说明凭据、流与显示相关设置项。
- key_points:
  - "凭据"
  - "流设置"
- install_notes: None
- app_takeaway_zh: 调试检查表。
- training_snippet: Crestron camera settings appendix supports commissioning checklists.

### SS531 | Anixter：B Series 分销单页
- id: SS531
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.anixter.com/content/dam/Suppliers/Bosch/Literature/BSeries%20distribution%20flyer.pdf
- source_name: Anixter / Bosch
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 分销渠道单页，快速规格。
- summary_zh: B Series 入侵控制面板分销宣传页。
- key_points:
  - "分销单页"
  - "快速规格"
- install_notes: None
- app_takeaway_zh: 渠道询价附件。
- training_snippet: Distributor flyers summarize B Series capacities for quoting.

### SS532 | Resideo EMEA：ProSeries Services
- id: SS532
- category: security
- brand: Resideo
- subsystem: emea
- evidence_tier: E1
- region: Europe
- source_url: https://www.resideo.com/emea/en/proseries-services/
- source_name: Resideo EMEA
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 欧洲区 ProSeries 服务说明，跨国别墅项目参考。
- summary_zh: 介绍 EMEA 区域 ProSeries 相关服务能力。
- key_points:
  - "EMEA"
  - "服务"
  - "ProSeries"
- install_notes: None
- app_takeaway_zh: 欧洲物业确认本地值守与频段。
- training_snippet: Resideo EMEA ProSeries pages matter for Europe villa security packages.

### SS533 | Alarm Grid：IQ Remote 与 Smart Scenes
- id: SS533
- category: security
- brand: Alarm.com
- subsystem: scenes
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/can-the-qolsys-iq-remote-perform-smart-scenes
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 远程键盘场景能力与固件门槛。
- summary_zh: FAQ 说明 IQ Remote 执行 Smart Scenes 的条件（如 IQ2 固件与 Scene Support）。
- key_points:
  - "IQ Remote"
  - "Scenes"
  - "固件"
- install_notes: None
- app_takeaway_zh: 副键盘场景与四老牌场景命名统一。
- training_snippet: IQ Remote scene FAQs help align keypad UX with Control4 scene names.

### SS534 | Crestron Home OS Manual：Security and Door Locks 总览
- id: SS534
- category: security
- brand: DSC
- subsystem: intrusion-panel
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/9599/Content/Topics/SystemDesign/Works-With-Crestron-Home/Security-and-Locks.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: Works-with 安防与门锁总览，含 DSC 等入口。
- summary_zh: 系统级列出 Crestron Home 支持的安防与门锁集成类别。
- key_points:
  - "Works-with"
  - "门锁"
  - "安防总览"
- install_notes: None
- app_takeaway_zh: 设计阶段先查 Works-with 再承诺品牌。
- training_snippet: Crestron Home security-and-locks overview frames supported villa panels.

### SS535 | ADT 主站：家用安防与专业值守
- id: SS535
- category: security
- brand: ADT
- subsystem: monitored-security
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.adt.com/
- source_name: ADT
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 品牌主站，套餐与值守入口。
- summary_zh: ADT 面向消费者的安防、DIY 与专业值守服务总览。
- key_points:
  - "品牌主站"
  - "值守"
  - "套餐入口"
- install_notes: None
- app_takeaway_zh: 与集成商方案对比时的官方入口。
- training_snippet: ADT homepage is the consumer-facing monitoring package entry point.

### SS536 | Alarm.com Geo-Services 介绍（国际）
- id: SS536
- category: security
- brand: Alarm.com
- subsystem: geo-services
- evidence_tier: E1
- region: Europe
- source_url: https://alarm.com/gb/resources/geo-services-introduction/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 国际站地理围栏介绍，欧陆项目可用。
- summary_zh: 介绍 Geo-Services 如何简化日常安防与自动化。
- key_points:
  - "Geo"
  - "国际站"
  - "自动化"
- install_notes: None
- app_takeaway_zh: 跨境物业注意手机漫游对围栏的影响。
- training_snippet: International Geo-Services pages support Europe villa automation narratives.

### SS537 | Alarm Grid：IQ4 NS 产品 FAQ 聚合
- id: SS537
- category: security
- brand: Qolsys
- subsystem: intrusion-panel
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/products/qolsys-iqpk084
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 特定 SKU 的 FAQ 聚合，含 Control4 相关问答入口。
- summary_zh: 产品 FAQ 索引页汇集 IQ4 NS 相关问题。
- key_points:
  - "SKU FAQ"
  - "索引"
- install_notes: None
- app_takeaway_zh: 销售工程快速检索。
- training_snippet: Product FAQ hubs aggregate IQ4 NS answers including Control4.

### SS538 | Honeywell Home PROA7PLUS 安装说明（经销商托管）
- id: SS538
- category: security
- brand: Resideo
- subsystem: install
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://advancedsecurityllc.com/wp-content/uploads/2023/05/Honeywell-Home-Proa7plus-Installation-Manual.pdf
- source_name: Dealer-hosted Resideo Manual
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安装手册公开副本，含通信注册概述。
- summary_zh: 安装说明覆盖面板安装、网络注册与编程下载等。
- key_points:
  - "安装手册"
  - "网络注册"
- install_notes: 本库不复述电气步骤；仅作文献索引。
- app_takeaway_zh: 持证安装商按最新原厂手册施工。
- training_snippet: PROA7PLUS install manuals (dealer-hosted) index commissioning topics.

### SS539 | Powered by Alarm.com 硬件目录 2024 PDF
- id: SS539
- category: security
- brand: Alarm.com
- subsystem: catalog
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://poweredbyalarm.com/eventresources/wp-content/uploads/sites/33/2024/04/Hardware-Catalog-2024.pdf
- source_name: Alarm.com Event Resources
- published: 2024
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 活动资源硬件目录，覆盖面板世代。
- summary_zh: 2024 硬件目录汇总平台兼容安防与自动化硬件。
- key_points:
  - "2024目录"
  - "面板世代"
- install_notes: None
- app_takeaway_zh: 年度目录可作培训教材。
- training_snippet: 2024 Alarm.com hardware catalog surveys panel generations for training.

### SS540 | Crestron Home Works-with 总索引
- id: SS540
- category: security
- brand: Crestron
- subsystem: security-locks
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/content/cp4r/Appendix/Works-With-Crestron-Home/Works-with-Crestron-Home.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: Works-with 总索引，安防/摄像/泳池等子系统入口集合。
- summary_zh: Crestron Home 兼容设备总览页，链到安防、摄像、泳池等章节。
- key_points:
  - "总索引"
  - "多子系统"
- install_notes: None
- app_takeaway_zh: 设计开题先打开此页。
- training_snippet: Crestron Home Works-with index is the gateway to security/camera/pool chapters.

### SS541 | Alarm.com KB：2GIG EDGE 知识库根
- id: SS541
- category: security
- brand: 2GIG
- subsystem: edge
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Panels/2GIG/2GIG_EDGE
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: EDGE 主题 KB 根节点，衍生多篇子文。
- summary_zh: Alarm.com 合作伙伴知识库中 2GIG EDGE 专区入口。
- key_points:
  - "KB根"
  - "EDGE专区"
- install_notes: None
- app_takeaway_zh: 支持工单先搜此树。
- training_snippet: Alarm.com EDGE KB root indexes villa panel support articles.

### SS542 | DriverCentral 附件：Bosch Solution 指南镜像入口
- id: SS542
- category: security
- brand: Bosch Security
- subsystem: intrusion-panel
- evidence_tier: E3
- region: Global
- source_url: https://drivercentral.io/index.php?attachment_id=905&dispatch=attachments.getfile
- source_name: DriverCentral
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 驱动站附件形式的安装指南入口。
- summary_zh: 提供 Bosch Solution 安装使用指南附件下载。
- key_points:
  - "附件指南"
  - "驱动站"
- install_notes: 链接可能需登录；备 APOL PDF 镜像。
- app_takeaway_zh: 文档冗余存储防链接失效。
- training_snippet: DriverCentral attachment mirrors Bosch Solution install guidance.

### SS543 | Crestron Home：Pools 章节（安防相邻子系统索引）
- id: SS543
- category: security
- brand: Crestron
- subsystem: works-with
- evidence_tier: E1
- region: Global
- source_url: https://docs.crestron.com/en-us/8525/Content/CP4R/Appendix/Works-With-Crestron-Home/Pools.htm
- source_name: Crestron Docs
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Crestron']
- control_layer_fit: 同文档树证明安防/泳池等同属 Works-with 体系，便于整案引用。
- summary_zh: 列出 Hayward/Jandy/Pentair 等泳池控制器支持，作为整宅联动上下文。
- key_points:
  - "整案上下文"
  - "泳池联动"
- install_notes: None
- app_takeaway_zh: 安防布防可联动关泳池 splasher（需编程）。
- training_snippet: Crestron Works-with pools chapter contextualizes security↔pool villa scenes.

### SS544 | Alarm.com Wellness 独立生活方案
- id: SS544
- category: security
- brand: Alarm.com
- subsystem: wellness
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/resources/wellness-solution/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 康养传感器方案可与别墅安防同平台；四老牌可订阅异常事件做照明/通知。
- summary_zh: 介绍独立生活监测：作息、睡眠、如厕、用药与紧急情况等。
- key_points:
  - "Wellness"
  - "独立生活"
  - "事件"
- install_notes: None
- app_takeaway_zh: 多代同堂别墅可叠加 Wellness 包。
- training_snippet: Alarm.com Wellness extends villa security platforms into aging-in-place monitoring.

### SS545 | Alarm.com KB：Water Management Overview
- id: SS545
- category: security
- brand: Alarm.com
- subsystem: water
- evidence_tier: E1
- region: Global
- source_url: https://answers.alarm.com/Partner/Installation_and_Troubleshooting/Water/Water_Management/General_Water_Management_Information/Water_Management_Overview
- source_name: Alarm.com KB
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 漏水关阀与安防同 App；可与四老牌「外出」场景联动思路。
- summary_zh: 概述水浸传感、Z-Wave 关阀、污水泵监测与自动关水。
- key_points:
  - "漏水"
  - "关阀"
  - "污水泵"
- install_notes: None
- app_takeaway_zh: 机房/厨房/泳池机房布置水浸点。
- training_snippet: Water Management overview supports villa leak-shutdown narratives beside security.

### SS546 | Alarm.com Next-Gen Outdoor Camera ADC-V730
- id: SS546
- category: security
- brand: Alarm.com
- subsystem: video
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/next-gen-outdoor-security-camera-adc-v730/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 新一代室外摄像机产品页，周界安防选型。
- summary_zh: 介绍 ADC-V730 室外安防摄像能力。
- key_points:
  - "室外摄像"
  - "V730"
- install_notes: None
- app_takeaway_zh: 与 Axis VMS 分工：值守分析用 ADC，连续取证用 Axis。
- training_snippet: ADC-V730 pages cover Alarm.com outdoor cameras for perimeter analytics.

### SS547 | Alarm.com：夏季室外安防要点
- id: SS547
- category: security
- brand: Alarm.com
- subsystem: outdoor
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/resources/outdoor-home-security/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 室外传感/灯/门铃/威慑组合话术。
- summary_zh: 列举室外安防要素与平台能力。
- key_points:
  - "室外安防"
  - "威慑"
- install_notes: None
- app_takeaway_zh: 布防场景可联动庭院灯（四老牌执行）。
- training_snippet: Outdoor security essentials articles feed villa perimeter scene design.

### SS548 | Alarm.com Locks & Garage
- id: SS548
- category: security
- brand: Alarm.com
- subsystem: locks-garage
- evidence_tier: E1
- region: Global
- source_url: https://alarm.com/locks-garage/
- source_name: Alarm.com
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 锁与车库门在安防 App 内控制；四老牌可镜像状态做欢迎回家。
- summary_zh: 介绍智能锁与车库控制器远程与告警能力。
- key_points:
  - "智能锁"
  - "车库"
- install_notes: 避免双控同一 Z-Wave 锁。
- app_takeaway_zh: 确定锁的主控平台。
- training_snippet: Locks & garage pages stress single-controller ownership for Z-Wave locks.

### SS549 | Alarm Grid FAQ：如何把 PRO Series 接入 Control4
- id: SS549
- category: security
- brand: Resideo
- subsystem: control4
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.alarmgrid.com/faq/how-do-i-integrate-a-pro-series-alarm-with-control4
- source_name: Alarm Grid
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 强调 PROWIFI/PROWIFIZW，仅 PROLTE 不够；AN360 Smart Home 包开关。
- summary_zh: FAQ 汇总通信模块、固件、AN360 与配对步骤要点。
- key_points:
  - "PROWIFI"
  - "AN360"
  - "配对"
- install_notes: None
- app_takeaway_zh: 勘察检查是否只有蜂窝无 Wi-Fi。
- training_snippet: PRO Series FAQ clarifies Wi-Fi communicator is required for Control4.

### SS550 | ADI：PROA7/PROA7PLUS 组装说明 PDF
- id: SS550
- category: security
- brand: Resideo
- subsystem: install
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://cdn.adiglobaldistribution.us/pim/Original/July-2026/PROA7_FA_Assembly_Instructions.pdf
- source_name: ADI / Resideo
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 面板组装官方说明。
- summary_zh: 组装说明覆盖 PROA7 系列硬件装配。
- key_points:
  - "组装"
  - "PROA7"
- install_notes: 不涉及系统编程细节。
- app_takeaway_zh: 到货验收附件。
- training_snippet: PROA7 assembly PDFs support receiving inspection checklists.

### SS551 | Somfy Pro FAQ：myLink 接入第三方控制系统
- id: SS551
- category: security
- brand: Somfy
- subsystem: security-cross
- evidence_tier: E1
- region: Global
- source_url: https://www.somfypro.com/support/faq?question=can-the-mylink-be-used-to-integrate-somfy-rts-motorized-products-into-third-party-control-systems
- source_name: Somfy Pro
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 虽为遮阳网关 FAQ，常被安防/自动化集成商引用；RTS→第三方限制说明。
- summary_zh: FAQ 回答 myLink 是否可用于第三方控制系统集成 RTS 产品。
- key_points:
  - "myLink"
  - "RTS"
  - "第三方"
- install_notes: 大系统仍建议 SDN。
- app_takeaway_zh: 安防集成商兼做遮阳时的边界说明。
- training_snippet: Somfy Pro myLink FAQ bounds RTS third-party control for hybrid security dealers.

### SS552 | Screen Innovations：Control4 集成 Tech Note
- id: SS552
- category: security
- brand: Screen Innovations
- subsystem: shades-security-cross
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.screeninnovations.com/docs/control4-integration-tech-note/
- source_name: Screen Innovations
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ['Control4']
- control_layer_fit: 影音遮阳品牌 C4 技术说明，常与安防场景（影院布防）交叉。
- summary_zh: Tech Note 说明 SI 遮阳/幕布与 Control4 集成要点。
- key_points:
  - "影院遮阳"
  - "C4"
- install_notes: None
- app_takeaway_zh: 私人影院「观影」场景可联动安防旁路策略（需慎重设计）。
- training_snippet: SI Control4 tech notes intersect AV shades with whole-home security scenes.

### SS553 | Somfy Connect BMS Interface V2 编程指南
- id: SS553
- category: security
- brand: Somfy
- subsystem: bms
- evidence_tier: E3
- region: Global
- source_url: https://automated.wickedwebsites.us/wp-content/uploads/2024/03/Programming-Guide-%E2%80%93-Somfy-Connect-BMS-Interface-V2-V1.0.pdf
- source_name: Somfy (hosted)
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: SDN/animeo IP 经 BACnet 进楼宇；大宅可与安防 BMS 并行。
- summary_zh: 编程指南覆盖 BMS Interface V2 对 SDN 与 animeo IP 的暴露点。
- key_points:
  - "BACnet"
  - "BMS"
  - "animeo IP"
- install_notes: None
- app_takeaway_zh: 超大庄园可走 BACnet 统一监视。
- training_snippet: Somfy BMS Interface guides enable BACnet exposure of shade networks.

