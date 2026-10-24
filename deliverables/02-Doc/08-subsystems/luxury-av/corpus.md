# X Home Easy · 别墅豪华影音子系统方案库（Luxury AV Corpus）

- **收集日期**：2026-10-21（Asia/Shanghai）
- **条目数**：163（ID SS281–SS443）
- **范畴**：私人影院 / 沉浸声处理 / 电影服务器 / 投影幕 / 视频处理 / 分布式音频 / 住宅投影与 AVoIP 骨干
- **证据分层**：E1 厂商官方 · E2 行业媒体/协会 · E3 集成商案例 · E4 社区
- **控制层前提**：Control4 / Crestron / Savant / Lutron 常作整宅控制层；含 `control_layer_fit`，即使未点名四品牌亦可收录。
- **免责声明**：公开二手资料整理，供方案建议与本地模型训练；非施工规范、非电气安全指南。

## 品牌覆盖

| brand | count |
|---|---|
| JBL Synthesis | 21 |
| Meridian | 18 |
| StormAudio | 18 |
| Kaleidescape | 16 |
| Trinnov | 14 |
| Screen Innovations | 12 |
| Procella | 10 |
| madVR | 9 |
| Sonance | 7 |
| Lumagen | 6 |
| Crestron AV infrastructure | 5 |
| Stewart Filmscreen | 5 |
| Barco | 4 |
| Wisdom Audio | 4 |
| AudioControl | 3 |
| Industry / CEDIA | 3 |
| Triad Speakers | 3 |
| Bang & Olufsen | 2 |
| Origin Acoustics | 2 |
| Monitor Audio | 1 |

## 证据层级

| tier | count |
|---|---|
| E1 | 117 |
| E2 | 22 |
| E3 | 24 |

---

### SS281 | Kaleidescape Control4 Driver Integration Guide
- id: SS281
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/wp-content/uploads/Kaleidescape-Control4-Driver-Integration-Guide.pdf
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 官方 Control4 驱动：播放事件触发灯光/幕布；音量反馈 App。
- key_points:
  - "播放事件"
  - "灯光幕布"
- install_notes: null
- app_takeaway_zh: 绑定播放事件做 Movie 场景。
- training_snippet: Kaleidescape↔Control4 事件总线。

### SS282 | Kaleidescape Control Systems FAQ
- id: SS282
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/support/article/Control-Systems-FAQ
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Crestron", "Savant"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 支持 Crestron/Control4/Savant 等模块与 RS-232/TCP。
- key_points:
  - "多平台"
- install_notes: null
- app_takeaway_zh: 选型标注四老牌驱动。
- training_snippet: 三大控制平台官方支持。

### SS283 | Kaleidescape Savant Guide
- id: SS283
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/support/article/Savant-Control-System-Guide
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Savant"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Savant daVinci Strato profile、灯光/遮幅。
- key_points:
  - "Savant profile"
- install_notes: null
- app_takeaway_zh: 优先官方 profile。
- training_snippet: Savant+Kaleidescape 场景自动化。

### SS284 | Kaleidescape Strato players
- id: SS284
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/strato-movie-players/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Strato/Strato V 下载级片源前端。
- key_points:
  - "Strato V"
- install_notes: null
- app_takeaway_zh: 机架散热与网络。
- training_snippet: 片源层标准件。

### SS285 | Kaleidescape Terra Prime
- id: SS285
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/terra-prime-movie-server/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Terra Prime 集中片库。
- key_points:
  - "多厅片库"
- install_notes: null
- app_takeaway_zh: QoS 与控制网隔离。
- training_snippet: 多厅集中片库。

### SS286 | Kaleidescape Home Theater Guide
- id: SS286
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/home-theater-guide/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 官方影院设计指南入口。
- key_points:
  - "设计指南"
- install_notes: null
- app_takeaway_zh: 设计阶段必读。
- training_snippet: 检查清单来源。

### SS287 | Kaleidescape System Examples
- id: SS287
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/systems/examples/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 预算/厅型配置示例。
- key_points:
  - "配置示例"
- install_notes: null
- app_takeaway_zh: 报价分层对照。
- training_snippet: 片源 BOM 示例。

### SS288 | Kaleidescape Ultimate 4K
- id: SS288
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/systems/the-ultimate-4k-system/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 旗舰 4K 组合。
- key_points:
  - "旗舰"
- install_notes: null
- app_takeaway_zh: 旗舰档引用。
- training_snippet: 旗舰片源基准。

### SS289 | Cyberhomes London Dream Home
- id: SS289
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E3
- source_url: https://cyberhomes.co.uk/project-portfolio/london-luxury-dream-home
- source_name: Cyberhomes
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Strato×3+Terra；Control4 一键 Movie。
- key_points:
  - "一键Movie"
- install_notes: null
- app_takeaway_zh: 门洞限幕需定制。
- training_snippet: 一键观影编排范式。

### SS290 | Hastings Meridian+C4+Kaleidescape
- id: SS290
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E2
- source_url: https://essentialinstall.com/case-studies/meridian-control4-kaleidescape/
- source_name: Essential Install
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Meridian DSP+Kaleidescape+Control4。
- key_points:
  - "英系组合"
- install_notes: null
- app_takeaway_zh: 英豪宅经典栈。
- training_snippet: C4 编排 Meridian+片源。

### SS291 | Bangkok Crestron+Kaleidescape
- id: SS291
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E2
- source_url: https://essentialinstall.com/case-studies/one-night-in-bangkok/
- source_name: Essential Install
- region: Asia/Thailand
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Crestron+Kaleidescape+Meridian+Sonance。
- key_points:
  - "亚太"
- install_notes: null
- app_takeaway_zh: 东南亚别墅栈。
- training_snippet: 亚太 Crestron 影院。

### SS292 | Pulse Kaleidescape control API
- id: SS292
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E2
- source_url: https://pulsecinemas.com/news-and-media/latest-news/kickin-it-with-kaleidescape
- source_name: Pulse Cinemas
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Savant", "Control4"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 采访强调三大平台 API 与仪式感自动化。
- key_points:
  - "API"
- install_notes: null
- app_takeaway_zh: 解释仪式感依赖片源事件。
- training_snippet: API 级电影仪式。

### SS293 | AEG Lake Geneva Strato theater
- id: SS293
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E3
- source_url: https://aeghometheaters.com/projects/lake-geneva-theater/
- source_name: AEG
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Strato 4K+Sony+7.2.6。
- key_points:
  - "湖畔"
- install_notes: null
- app_takeaway_zh: 湖景别墅片源。
- training_snippet: 北美湖畔案。

### SS294 | Kaleidescape Vanhalla Crestron demo
- id: SS294
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E2
- source_url: https://essentialinstall.com/case-studies/kaleidescape-vanhalla/
- source_name: Essential Install
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Lutron"]
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 房车移动展厅 Crestron+Kaleidescape。
- key_points:
  - "移动演示"
- install_notes: null
- app_takeaway_zh: 经销商演示手法。
- training_snippet: 非常规演示场景。

### SS295 | Trinnov Altitude32
- id: SS295
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/products/altitude32/
- source_name: Trinnov
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 高通道沉浸声处理；Wizard/TCD。
- key_points:
  - "Altitude32"
- install_notes: null
- app_takeaway_zh: 参考级首选。
- training_snippet: 别墅参考处理核心。

### SS296 | Hyderabad LED + Optimizer
- id: SS296
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/led-wall-meets-trinnov-optimizer-in-a-non-rectangular-media-room/
- source_name: Trinnov
- region: Asia/India
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 异形厅+LED+Altitude32。
- key_points:
  - "异形"
  - "LED"
- install_notes: null
- app_takeaway_zh: 异形厅校正。
- training_snippet: 非矩形厅案例。

### SS297 | Cinema Pro 11.4.8 Focal
- id: SS297
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/cinema-pro-11.4.8-altitude32-home-theater/
- source_name: Trinnov
- region: Europe
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 38㎡ 11.4.8+Focal 隔声重建。
- key_points:
  - "11.4.8"
- install_notes: null
- app_takeaway_zh: 欧系高通道。
- training_snippet: Altitude32+Focal。

### SS298 | Blackroom Altitude16
- id: SS298
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/blackroom-altitude16-stingray-home-theater/
- source_name: Trinnov
- region: Europe
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 八角房 9.1.4。
- key_points:
  - "Altitude16"
- install_notes: null
- app_takeaway_zh: 中通道异形厅。
- training_snippet: Altitude16 覆盖9.x.4。

### SS299 | Sydney Mona Vale Krix
- id: SS299
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/sydney-hifi-mona-vale-19-channel-altitude16-home-theater/
- source_name: Trinnov
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Altitude16+Krix 19ch。
- key_points:
  - "Krix"
- install_notes: null
- app_takeaway_zh: 澳新组合。
- training_snippet: Trinnov+Krix。

### SS300 | Cotswold historic cinema
- id: SS300
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/cotswold-home-cinema/
- source_name: Trinnov
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 古建摆位校正。
- key_points:
  - "古建"
- install_notes: null
- app_takeaway_zh: 改造房价值高。
- training_snippet: Optimizer 补偿摆位。

### SS301 | Kuwait Pro Home Cinema
- id: SS301
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/3-trinnov-home-theaters-by-kuwaits-av-leader-pro-home-cinema/
- source_name: Trinnov
- region: Middle East/Kuwait
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 多套 Trinnov+Krix。
- key_points:
  - "中东"
- install_notes: null
- app_takeaway_zh: 海湾别墅参考。
- training_snippet: 中东渠道案。

### SS302 | Turkey WaveForming showroom
- id: SS302
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/flagship-turkish-showroom-launches-with-trinnov-waveforming-a-national-first/
- source_name: Trinnov
- region: Europe/Turkey
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: WaveForming 展厅。
- key_points:
  - "WaveForming"
- install_notes: null
- app_takeaway_zh: 一阶段定低音位。
- training_snippet: 低频设计约束。

### SS303 | WaveForming install requirements
- id: SS303
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E3
- source_url: https://www.customcontrols.co.uk/blog/trinnov-waveforming-what-it-is-how-it-works-and-what-you-need-to-install-it/
- source_name: Custom Controls
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: ≥4低音、房长、一阶段布线。
- key_points:
  - "安装约束"
- install_notes: null
- app_takeaway_zh: 新建清单前置条件。
- training_snippet: 不能后期按钮开启。

### SS304 | Which Altitude fits
- id: SS304
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/which-altitude-processor-fits-your-project/
- source_name: Trinnov
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: CI vs 16/32 选型。
- key_points:
  - "选型"
- install_notes: null
- app_takeaway_zh: 按通道网络选型。
- training_snippet: 选型文案依据。

### SS305 | AltitudeCI AoIP
- id: SS305
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/trinnov-unveils-altitudeci-scalable-audio-over-ip-for-every-project/
- source_name: Trinnov
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Dante/AES67 可扩展。
- key_points:
  - "AoIP"
- install_notes: null
- app_takeaway_zh: 交换机 QoS。
- training_snippet: 影院音频网络化。

### SS306 | Len Wallis Audio Trinnov
- id: SS306
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.trinnov.com/en/blog/posts/len-wallis-audio/
- source_name: Trinnov
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 玻璃墙多排座补偿。
- key_points:
  - "玻璃墙"
- install_notes: null
- app_takeaway_zh: 玻璃客厅影院。
- training_snippet: 澳系案。

### SS307 | Villa Haaksbergen Storm+Savant+Lutron
- id: SS307
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-luxury-cinema-befitting-a-stunning-villa-beyond-compare
- source_name: StormAudio
- region: Europe/Netherlands
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Savant", "Lutron"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: ISP Elite32+Meridian+Barco+Stewart；Savant+Lutron。
- key_points:
  - "别墅整案"
- install_notes: null
- app_takeaway_zh: 镜面投影。
- training_snippet: Storm+Savant+Lutron 欧陆别墅。

### SS308 | UK dual ISP Control4
- id: SS308
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/outstanding-home-deserves-equivalent-av-system
- source_name: StormAudio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 双 ISP Elite16 + Control4 多区/泳池。
- key_points:
  - "多区"
- install_notes: null
- app_takeaway_zh: 低延迟模式。
- training_snippet: Storm+Control4 多区。

### SS309 | Swiss chateau bunker
- id: SS309
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/stormaudio-helps-transform-the-basement-bunker-of-a-swiss-chateau-into-a-luxury-cinema-room
- source_name: StormAudio
- region: Europe/Switzerland
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Storm+Wisdom+Kaleidescape+madVR。
- key_points:
  - "完整栈"
- install_notes: null
- app_takeaway_zh: 混凝土异形校准。
- training_snippet: 城堡改造影音栈。

### SS310 | Cloister CEDIA 2023
- id: SS310
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/cedia-best-global-home-cinema-2023-inside-the-remarkable-cloister-cinema-project
- source_name: StormAudio
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: CEDIA 2023 全球最佳影院。
- key_points:
  - "大奖"
- install_notes: null
- app_takeaway_zh: 参考标杆。
- training_snippet: 全球最佳影院。

### SS311 | Bermuda Wisdom+Barco
- id: SS311
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-home-theater-as-blue-as-the-ocean-in-bermuda
- source_name: StormAudio
- region: North America/Bermuda
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 11.4.4 Wisdom+Njord+Dirac ART。
- key_points:
  - "11.4.4"
- install_notes: null
- app_takeaway_zh: 现场 ART。
- training_snippet: 海岛别墅大幕。

### SS312 | Digital Picture Hilltop
- id: SS312
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/global-award-winning-cinema-from-the-digital-picture
- source_name: StormAudio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: ISP Core16 7.4.4 获奖。
- key_points:
  - "ISP Core"
- install_notes: null
- app_takeaway_zh: 中通道亦可大奖。
- training_snippet: ISP Core 获奖厅。

### SS313 | Saudi Retal Control4
- id: SS313
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-modern-avant-garde-design-living-experience
- source_name: StormAudio
- region: Middle East/Saudi Arabia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 9.2.4+Control4 37座。
- key_points:
  - "中东"
- install_notes: null
- app_takeaway_zh: 后装声学。
- training_snippet: 沙特 Control4 影院。

### SS314 | Vancouver 9.4.4
- id: SS314
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-home-cinema-in-vancouver
- source_name: StormAudio
- region: North America/Canada
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 温哥华 9.4.4。
- key_points:
  - "9.4.4"
- install_notes: null
- app_takeaway_zh: 北美西岸。
- training_snippet: 温哥华案。

### SS315 | Thailand reference cinema
- id: SS315
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-reference-level-private-cinema-in-thailand-engineered-for-precision
- source_name: StormAudio
- region: Asia/Thailand
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 泰国参考级私人影院。
- key_points:
  - "泰国"
- install_notes: null
- app_takeaway_zh: 亚太参考。
- training_snippet: 东南亚参考厅。

### SS316 | AU Bond hideaway
- id: SS316
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-tropical-bond-hideaway-cinema-audio-perfection-down-under
- source_name: StormAudio
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 热带隐匿影院。
- key_points:
  - "隐匿"
- install_notes: null
- app_takeaway_zh: 澳宅灵感。
- training_snippet: 澳系隐匿厅。

### SS317 | China 32ch AoIP cinema
- id: SS317
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/feather-sound-2
- source_name: StormAudio
- region: Asia/China
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 32ch AES67/Dante。
- key_points:
  - "AoIP"
- install_notes: null
- app_takeaway_zh: 时钟与交换机。
- training_snippet: 中国 AoIP 影院。

### SS318 | Star Wars theme theater
- id: SS318
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/a-dream-star-wars-home-theater
- source_name: StormAudio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 星战主题影院。
- key_points:
  - "主题"
- install_notes: null
- app_takeaway_zh: 主题厅。
- training_snippet: 主题影院。

### SS319 | Habitech experience center
- id: SS319
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/award-winning-habitech-experience-center-relies-on-stormaudio-to-deliver-awe-inspiring-sound
- source_name: StormAudio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Habitech 体验中心 Storm。
- key_points:
  - "展厅"
- install_notes: null
- app_takeaway_zh: 经销商展厅。
- training_snippet: 英系体验中心。

### SS320 | madVR Labs experience + Storm
- id: SS320
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.stormaudio.com/madvr-labs-experience-center
- source_name: StormAudio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 与 madVR 体验中心合作展示。
- key_points:
  - "madVR"
- install_notes: null
- app_takeaway_zh: 视频+音频联合演示。
- training_snippet: 跨品牌体验中心。

### SS321 | Wavetrain Cloister project page
- id: SS321
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E3
- source_url: https://www.wavetrain.com.au/projects/cloister-cinema/
- source_name: Wavetrain
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 集成商 Cloister 项目页。
- key_points:
  - "Wavetrain"
- install_notes: null
- app_takeaway_zh: 声学室内一体。
- training_snippet: 澳系参考。

### SS322 | CEDIA Tour Cloister
- id: SS322
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E2
- source_url: https://cedia.org/en-us/homeowners/smart-home-inspirations/the-cloister/
- source_name: CEDIA
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: CEDIA 业主向导览。
- key_points:
  - "CEDIA Tour"
- install_notes: null
- app_takeaway_zh: 对客讲解。
- training_snippet: 官方导览。

### SS323 | Brewer Residence SDP-80 + Control4
- id: SS323
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/case-study-brewer-residence.html
- source_name: JBL Synthesis
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: SDP-80 34ch+Control4 场景/浴室 Join+Revel 全屋。
- key_points:
  - "SDP-80"
  - "Control4"
- install_notes: null
- app_takeaway_zh: 旗舰+Control4。
- training_snippet: Synthesis+C4 旗舰案。

### SS324 | JPRO certified cinema
- id: SS324
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/case-study-jpro-synthesis.html
- source_name: JBL Synthesis
- region: Oceania/New Zealand
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: SDR-38+Dirac；AMX Muse。
- key_points:
  - "认证"
- install_notes: null
- app_takeaway_zh: 逻辑可迁四老牌。
- training_snippet: 认证展厅。

### SS325 | JBL Synthesis gallery: Case Study Van Cave
- id: SS325
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/case-study-van-cave.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Case Study Van Cave》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Case Study Van Cave。

### SS326 | JBL Synthesis gallery: Calibrating The Dream
- id: SS326
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/calibrating-the-dream.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Calibrating The Dream》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Calibrating The Dream。

### SS327 | JBL Synthesis gallery: Europes Best Home Cinema
- id: SS327
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/europes-best-home-cinema.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Europes Best Home Cinema》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Europes Best Home Cinema。

### SS328 | JBL Synthesis gallery: Yacht Cinema
- id: SS328
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/yacht-cinema.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Yacht Cinema》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Yacht Cinema。

### SS329 | JBL Synthesis gallery: Antique Theater
- id: SS329
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/antique-theater.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Antique Theater》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Antique Theater。

### SS330 | JBL Synthesis gallery: Bauhaus
- id: SS330
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/bauhaus.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Bauhaus》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Bauhaus。

### SS331 | JBL Synthesis gallery: Cinema De La Mer
- id: SS331
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/cinema-de-la-mer.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Cinema De La Mer》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Cinema De La Mer。

### SS332 | JBL Synthesis gallery: Dark Knight Cinema
- id: SS332
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/dark-knight-cinema.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Dark Knight Cinema》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Dark Knight Cinema。

### SS333 | JBL Synthesis gallery: Hancock Park
- id: SS333
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/hancock-park.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Hancock Park》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Hancock Park。

### SS334 | JBL Synthesis gallery: House Strydom
- id: SS334
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/house-strydom.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《House Strydom》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 House Strydom。

### SS335 | JBL Synthesis gallery: Immersed In Sound
- id: SS335
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/immersed-in-sound.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Immersed In Sound》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Immersed In Sound。

### SS336 | JBL Synthesis gallery: Signature Private Cinema
- id: SS336
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/signature-private-cinema.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Signature Private Cinema》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Signature Private Cinema。

### SS337 | JBL Synthesis gallery: Notre Dame Theater
- id: SS337
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/notre-dame-theater.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Notre Dame Theater》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Notre Dame Theater。

### SS338 | JBL Synthesis gallery: Five Screens In One
- id: SS338
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/five-screens-in-one.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Five Screens In One》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Five Screens In One。

### SS339 | JBL Synthesis gallery: The Blue Room
- id: SS339
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/the-blue-room.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《The Blue Room》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 The Blue Room。

### SS340 | JBL Synthesis gallery: Spiro Razatos
- id: SS340
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive cinema loudspeakers / processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/installation-gallery/spiro-razatos.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 官方安装画廊《Spiro Razatos》。
- key_points:
  - "画廊"
- install_notes: null
- app_takeaway_zh: 视觉灵感。
- training_snippet: 画廊 Spiro Razatos。

### SS341 | Meridian case: Bespoke Home Cinema Garage Conversion Leeds
- id: SS341
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/bespoke-home-cinema-garage-conversion-leeds
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Bespoke Home Cinema Garage Conversion Leeds》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Bespoke Home Cinema Garage Conversion Leeds。

### SS342 | Meridian case: Bespoke Home Cinema Luxurious Home Cinema Manchester
- id: SS342
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/bespoke-home-cinema-luxurious-home-cinema-manchester
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Bespoke Home Cinema Luxurious Home Cinema Manchester》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Bespoke Home Cinema Luxurious Home Cinema Manchester。

### SS343 | Meridian case: Bnc Technology Platinum Cinema
- id: SS343
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/bnc-technology-platinum-cinema
- source_name: Meridian Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Bnc Technology Platinum Cinema》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Bnc Technology Platinum Cinema。

### SS344 | Meridian case: Cyberhomes Moguls Media Room London
- id: SS344
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/cyberhomes-moguls-media-room-london
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Cyberhomes Moguls Media Room London》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Cyberhomes Moguls Media Room London。

### SS345 | Meridian case: Cyberhomes The Ruby Cinema Uk
- id: SS345
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/cyberhomes-the-ruby-cinema-uk
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Cyberhomes The Ruby Cinema Uk》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Cyberhomes The Ruby Cinema Uk。

### SS346 | Meridian case: Electric String Knightsbridge London
- id: SS346
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/electric-string-knightsbridge-london
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Electric String Knightsbridge London》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Electric String Knightsbridge London。

### SS347 | Meridian case: Erskine Group Home Cinema Utah
- id: SS347
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/erskine-group-home-cinema-utah
- source_name: Meridian Audio
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Erskine Group Home Cinema Utah》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Erskine Group Home Cinema Utah。

### SS348 | Meridian case: High End Electro Flanders House Belgium
- id: SS348
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/high-end-electro-flanders-house-belgium
- source_name: Meridian Audio
- region: Europe
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《High End Electro Flanders House Belgium》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian High End Electro Flanders House Belgium。

### SS349 | Meridian case: Home Theater Of Long Island Beatrice Manhattan
- id: SS349
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/home-theater-of-long-island-beatrice-manhattan
- source_name: Meridian Audio
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Home Theater Of Long Island Beatrice Manhattan》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Home Theater Of Long Island Beatrice Manhattan。

### SS350 | Meridian case: Len Wallis Audio Beachfront Home Sydney
- id: SS350
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/len-wallis-audio-beachfront-home-sydney
- source_name: Meridian Audio
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Len Wallis Audio Beachfront Home Sydney》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Len Wallis Audio Beachfront Home Sydney。

### SS351 | Meridian case: Len Wallis Audio State Of The Art Cinema Room Australia
- id: SS351
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/len-wallis-audio-state-of-the-art-cinema-room-australia
- source_name: Meridian Audio
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Len Wallis Audio State Of The Art Cinema Room Australia》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Len Wallis Audio State Of The Art Cinema Room Australia。

### SS352 | Meridian case: Media Max Home Cinema System Surrey
- id: SS352
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/media-max-home-cinema-system-surrey
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Media Max Home Cinema System Surrey》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Media Max Home Cinema System Surrey。

### SS353 | Meridian case: Media Max Russian Cottage Surrey
- id: SS353
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/media-max-russian-cottage-surrey
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Media Max Russian Cottage Surrey》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Media Max Russian Cottage Surrey。

### SS354 | Meridian case: New Land Group Modern Sanctuary Oxfordshire
- id: SS354
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/new-land-group-modern-sanctuary-oxfordshire
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《New Land Group Modern Sanctuary Oxfordshire》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian New Land Group Modern Sanctuary Oxfordshire。

### SS355 | Meridian case: Nv Integration Siam Smart House Thailand
- id: SS355
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/nv-integration-siam-smart-house-thailand
- source_name: Meridian Audio
- region: Asia/Thailand
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Nv Integration Siam Smart House Thailand》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Nv Integration Siam Smart House Thailand。

### SS356 | Meridian case: Prestige Audio Mount Street Mayfair
- id: SS356
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/prestige-audio-mount-street-mayfair
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Prestige Audio Mount Street Mayfair》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Prestige Audio Mount Street Mayfair。

### SS357 | SI.Fi Lutron HomeWorks
- id: SS357
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E1
- source_url: https://www.screeninnovations.com/docs/si-fi-lutron-integration/
- source_name: SI/Integrator
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Lutron"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: SI.Fi↔HomeWorks QS 电机组/Telnet。
- key_points:
  - "HomeWorks"
- install_notes: Telnet 先就绪。
- app_takeaway_zh: 幕/帘与 Lutron 同键。
- training_snippet: SI 幕控经验。

### SS358 | SI Control4 tech note
- id: SS358
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E1
- source_url: https://www.screeninnovations.com/docs/control4-integration-tech-note/
- source_name: SI/Integrator
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: Control4 RS-485/Zigbee 集成说明。
- key_points:
  - "Control4"
- install_notes: 按说明选接口。
- app_takeaway_zh: 纳入 C4 设备树。
- training_snippet: SI 幕控经验。

### SS359 | Donn Dunn Zero-G Control4
- id: SS359
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/donn-dunn-master-bedroom-project
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 主卧 Nano+Zero-G ALR+Control4。
- key_points:
  - "Zero-G"
- install_notes: 混凝土钢构用无线。
- app_takeaway_zh: 主卧一键观影。
- training_snippet: SI 幕控经验。

### SS360 | Land & Sea 170 Crestron JBL
- id: SS360
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/land-sea-entertainment
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 170" Maestro+Crestron 一键+JBL Synthesis。
- key_points:
  - "170寸"
- install_notes: 旧幕前藏电动幕。
- app_takeaway_zh: 大幕客厅编排。
- training_snippet: SI 幕控经验。

### SS361 | Zero Edge Pro Control4 B&O
- id: SS361
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/zero-edge-pro-infinite-home-theater/
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: Black Diamond+B&O+Control4。
- key_points:
  - "ALR"
- install_notes: null
- app_takeaway_zh: 零边框媒体室。
- training_snippet: SI 幕控经验。

### SS362 | SI pool theater
- id: SS362
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/dive-in-pool-theater-reinvents-home-theater-experience
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 泳池影院。
- key_points:
  - "户外"
- install_notes: 防水眩光。
- app_takeaway_zh: 户外影院。
- training_snippet: SI 幕控经验。

### SS363 | Solo Pro 2 rooftop
- id: SS363
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/solo-pro-2-screen-turns-rooftop-deck-into-an-outdoor-cinema
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 屋顶户外影院。
- key_points:
  - "屋顶"
- install_notes: 抗风收纳。
- app_takeaway_zh: 屋顶幕。
- training_snippet: SI 幕控经验。

### SS364 | Zero-G showroom
- id: SS364
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/levitating-showroom-demo-sets-a-new-media-room-and-home-theater-standard
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 悬浮幕展厅。
- key_points:
  - "Zero-G"
- install_notes: null
- app_takeaway_zh: 设计卖点。
- training_snippet: SI 幕控经验。

### SS365 | Seattle high-rise SI
- id: SS365
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/si-screen-helps-sell-properties-at-luxury-seattle-high-rise
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 高层样板 SI 幕。
- key_points:
  - "样板"
- install_notes: null
- app_takeaway_zh: 开发商展示。
- training_snippet: SI 幕控经验。

### SS366 | Bespoke suburban theater
- id: SS366
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/articles/bespoke-in-the-burbs-home-theater
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 郊区定制影院。
- key_points:
  - "郊区"
- install_notes: null
- app_takeaway_zh: 别墅参考。
- training_snippet: SI 幕控经验。

### SS367 | Stewart residential apps
- id: SS367
- category: luxury-av
- brand: Stewart Filmscreen
- subsystem: projection screen / masking
- evidence_tier: E1
- source_url: https://www.stewartfilmscreen.com/en/applications/residential
- source_name: Stewart/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 住宅私人影院应用。
- key_points:
  - "住宅幕"
- install_notes: null
- app_takeaway_zh: 产品入口。
- training_snippet: Stewart 住宅总览。

### SS368 | Stewart CVM wiring
- id: SS368
- category: luxury-av
- brand: Stewart Filmscreen
- subsystem: projection screen / masking
- evidence_tier: E1
- source_url: https://support.stewartfilmscreen.com/hc/en-us/articles/25103726157083-CVM-Control-and-Wiring-Diagram
- source_name: Stewart/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: CVM 遮幅控制接线。
- key_points:
  - "CVM"
- install_notes: null
- app_takeaway_zh: 遮幅入控制层。
- training_snippet: CVM↔四老牌。

### SS369 | Stewart CVM PDF
- id: SS369
- category: luxury-av
- brand: Stewart Filmscreen
- subsystem: projection screen / masking
- evidence_tier: E1
- source_url: https://www.stewartfilmscreen.com/Files/files/Support%20Material/Controls/CVM.pdf
- source_name: Stewart/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: CVM 手册。
- key_points:
  - "手册"
- install_notes: null
- app_takeaway_zh: 串口/IP。
- training_snippet: CVM 手册。

### SS370 | Stewart Crestron driver news
- id: SS370
- category: luxury-av
- brand: Stewart Filmscreen
- subsystem: projection screen / masking
- evidence_tier: E2
- source_url: https://www.residentialsystems.com/news/stewart-adds-crestron-control-driver
- source_name: Stewart/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 增加 Crestron 驱动报道。
- key_points:
  - "驱动"
- install_notes: null
- app_takeaway_zh: 优先官方驱动。
- training_snippet: 媒体确认。

### SS371 | Control4 home Stewart screen
- id: SS371
- category: luxury-av
- brand: Stewart Filmscreen
- subsystem: projection screen / masking
- evidence_tier: E2
- source_url: https://essentialinstall.com/automation/homeowners-design-custom-luxury-smart-home-using-control4-technology/
- source_name: Stewart/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: Control4 豪宅含大型 Stewart。
- key_points:
  - "大幕"
- install_notes: null
- app_takeaway_zh: 一键观影。
- training_snippet: Stewart+C4。

### SS372 | Lumagen Radiance Pro
- id: SS372
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E1
- source_url: https://www.lumagen.com/products-sales/p/explore-radiance-pro
- source_name: Lumagen
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Radiance Pro 视频处理器产品页。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Lumagen Radiance Pro。

### SS373 | Lumagen Artisan 8K
- id: SS373
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E1
- source_url: https://www.lumagen.com/products-sales/p/artisan-8k
- source_name: Lumagen
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Artisan 8K 视频处理器。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Lumagen Artisan 8K。

### SS374 | Lumagen manuals & tech tips
- id: SS374
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E1
- source_url: https://www.lumagen.com/support/manuals-tech-tips
- source_name: Lumagen
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 手册与技术提示合集。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Lumagen manuals & tech tips。

### SS375 | Lumagen remote/control files
- id: SS375
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E1
- source_url: https://www.lumagen.com/support/remote-files
- source_name: Lumagen
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 遥控/控制相关文件。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Lumagen remote/control files。

### SS376 | Control4 Lumagen driver
- id: SS376
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E2
- source_url: https://drivercentral.io/platforms/control4-drivers/audio-video/lumagen/
- source_name: DriverCentral
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Control4 双向 Radiance Pro 驱动。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Control4 Lumagen driver。

### SS377 | madVR Envy calibration
- id: SS377
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/calibration
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Envy 校准说明。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR Envy calibration。

### SS378 | madVR Envy product overview
- id: SS378
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/pr-core
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Envy 产品线概述。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR Envy product overview。

### SS379 | madVR Envy Control4 guide
- id: SS379
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Envy-Control4.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Envy↔Control4 PDF。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR Envy Control4 guide。

### SS380 | madVR Envy Savant profile
- id: SS380
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Envy-Savant-Profile-Guide-r1_0.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Savant"]
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Envy Savant profile。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR Envy Savant profile。

### SS381 | Envy masking + Control4
- id: SS381
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Envy-Screen-Masking-Control-with-Control4.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 遮幅与 Control4。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：Envy masking + Control4。

### SS382 | Envy + Kaleidescape setup
- id: SS382
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Envy-Setup-Guide-KScape.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Envy+Kaleidescape 设置。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：Envy + Kaleidescape setup。

### SS383 | Barco + Envy setup
- id: SS383
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Barco-Envy-Setup-Guide.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: Barco+Envy 设置。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：Barco + Envy setup。

### SS384 | madVR customer success
- id: SS384
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/Customer-Success-Story-Meet-Don-C.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 用户成功故事。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR customer success。

### SS385 | Procella: Private Home Theater In The Netherlands
- id: SS385
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/private-home-theater-in-the-netherlands
- source_name: Procella Audio
- region: Europe/Netherlands
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Private Home Theater In The Netherlands》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Private Home Theater In The Netherlands。

### SS386 | Procella: Procella Star Wars Cinema Bio Royal Iii
- id: SS386
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/procella-star-wars-cinema-bio-royal-iii
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Procella Star Wars Cinema Bio Royal Iii》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Procella Star Wars Cinema Bio Royal Iii。

### SS387 | Procella: Uk Reference Home Cinema
- id: SS387
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/uk-reference-home-cinema
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Uk Reference Home Cinema》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Uk Reference Home Cinema。

### SS388 | Procella: Electronic House Home Of The Year
- id: SS388
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/electronic-house-home-of-the-year
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Electronic House Home Of The Year》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Electronic House Home Of The Year。

### SS389 | Procella: Cinematic Leverages Procella Audio To Match Luxury Of Bentley Home Cinema
- id: SS389
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/cinematic-leverages-procella-audio-to-match-luxury-of-bentley-home-cinema
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Cinematic Leverages Procella Audio To Match Luxury Of Bentley Home Cinema》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Cinematic Leverages Procella Audio To Match Luxury Of Bentley Home Cinema。

### SS390 | Procella: Chinas First Waveforming Superior Theater With Miro Sound Vision
- id: SS390
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/chinas-first-waveforming-superior-theater-with-miro-sound-vision
- source_name: Procella Audio
- region: Asia/China
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Chinas First Waveforming Superior Theater With Miro Sound Vision》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Chinas First Waveforming Superior Theater With Miro Sound Vision。

### SS391 | Procella: Reference Theater 11 4 8 At Cedia Hq
- id: SS391
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/reference-theater-11-4-8-at-cedia-hq
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Reference Theater 11 4 8 At Cedia Hq》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Reference Theater 11 4 8 At Cedia Hq。

### SS392 | Procella: The Home Cinema Install Of A Lifetime
- id: SS392
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/the-home-cinema-install-of-a-lifetime
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《The Home Cinema Install Of A Lifetime》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella The Home Cinema Install Of A Lifetime。

### SS393 | Newport Coast Sonance Invisible + Control4
- id: SS393
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://essentialinstall.com/case-studies/control4-powers-whole-home-transformation-at-newport-coast-luxury-residence/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Invisible 全屋+Control4 CORE3。
- key_points:
  - "Invisible"
- install_notes: null
- app_takeaway_zh: 建筑协同预埋。
- training_snippet: 隐蔽全屋音频。

### SS394 | ADI Newport Coast Control4 Sonance
- id: SS394
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.adiglobal.com/company-news/control4-integration-transforms-newport-coast-residence-with-advanced-smart-home-systems
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 渠道稿含 Lutron/户外。
- key_points:
  - "Lutron"
- install_notes: null
- app_takeaway_zh: 远程运维。
- training_snippet: Snap One 生态。

### SS395 | 5200sqft Control4 Sonance
- id: SS395
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.installation-international.com/case-studies/control4-platform-unifies-smart-home-across-5200sqft-us-home
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 中大型别墅平台统一。
- key_points:
  - "全屋"
- install_notes: null
- app_takeaway_zh: 平台化。
- training_snippet: Control4 统一层。

### SS396 | CE Pro coastal estate
- id: SS396
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.cepro.com/projects/coastal-contemporary-estate-adds-dash-of-luxury-with-advanced-home-automation/619043/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 海岸宅自动化音频。
- key_points:
  - "海岸"
- install_notes: null
- app_takeaway_zh: 户外分区。
- training_snippet: 海岸别墅。

### SS397 | Sonance award One Touch House
- id: SS397
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E1
- source_url: https://www.sonance.com/blogs/spotlights/one-touch-house-wins-2026-sonance-design-award-designed-to-disappear
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 设计隐消失获奖。
- key_points:
  - "设计奖"
- install_notes: null
- app_takeaway_zh: 早期介入建筑。
- training_snippet: 隐蔽设计奖。

### SS398 | Sonance Invisible Series award
- id: SS398
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E1
- source_url: https://www.sonance.com/blogs/spotlights/vibes-wins-2026-sonance-design-award-for-best-application-invisible-series
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Invisible 最佳应用。
- key_points:
  - "Invisible"
- install_notes: null
- app_takeaway_zh: 泥灰工艺。
- training_snippet: Invisible 奖。

### SS399 | Brisbane Control4 + Triad
- id: SS399
- category: luxury-av
- brand: Triad Speakers
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://essentialinstall.com/case-studies/modern-brisbane-abode-control4-triad/
- source_name: Vendor/Media
- region: Oceania/Australia
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 涂装 Triad+Control4。
- key_points:
  - "Triad"
- install_notes: null
- app_takeaway_zh: 饰面协同设计。
- training_snippet: 澳系 Triad。

### SS400 | Hiddenwires Triad cinema Control4
- id: SS400
- category: luxury-av
- brand: Triad Speakers
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.hiddenwires.co.uk/case-studies/article/home-cinema-perfection-with-triad
- source_name: Vendor/Media
- region: Europe
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Triad Gold/Silver Atmos+Control4。
- key_points:
  - "Atmos"
- install_notes: null
- app_takeaway_zh: 嵌壁吸顶。
- training_snippet: 欧刊 Triad。

### SS401 | Cyberhomes Triad Gold Control4 cinema
- id: SS401
- category: luxury-av
- brand: Triad Speakers
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E3
- source_url: https://cyberhomes.co.uk/project-portfolio/premium-cinema-in-luxury-smart-home
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Triad Gold+McIntosh+Control4。
- key_points:
  - "Triad Gold"
- install_notes: null
- app_takeaway_zh: 功放匹配。
- training_snippet: 英系获奖向。

### SS402 | Origin Acoustics partner spotlight
- id: SS402
- category: luxury-av
- brand: Origin Acoustics
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E3
- source_url: https://restrepoinnovations.com/blog/partner-spotlight-origin-acoustics.html
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Origin 吸顶/户外+Crestron 分布式。
- key_points:
  - "Origin"
- install_notes: null
- app_takeaway_zh: 定向控音。
- training_snippet: Origin+Crestron。

### SS403 | CE Pro AudioControl×Origin/Triad partners
- id: SS403
- category: luxury-av
- brand: Origin Acoustics
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.cepro.com/news/audiocontrol_partners_with_origin_james_triad_stealth/1453/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Sound Partners DSP 配置合作。
- key_points:
  - "DSP配置"
- install_notes: null
- app_takeaway_zh: 用官方配置文件。
- training_snippet: 功放-音箱生态。

### SS404 | AudioControl Director Control4 driver
- id: SS404
- category: luxury-av
- brand: AudioControl
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E1
- source_url: https://support.avproglobal.com/portal/en/kb/articles/control4-director-series-driver-module
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Director Control4 驱动包。
- key_points:
  - "驱动"
- install_notes: null
- app_takeaway_zh: Composer 配 IP/区。
- training_snippet: Director↔C4。

### SS405 | Director D3400/4400 manual
- id: SS405
- category: luxury-av
- brand: AudioControl
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E1
- source_url: https://www.audiocontrol.com/downloads/home/current/director-model-d3400-4400/d3400-4400-user-manual.pdf
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 多通道网络功放手册。
- key_points:
  - "手册"
- install_notes: null
- app_takeaway_zh: 机架温控网络。
- training_snippet: Director 部署。

### SS406 | RS Director more control
- id: SS406
- category: luxury-av
- brand: AudioControl
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E2
- source_url: https://www.residentialsystems.com/technology/audiocontrol-gives-more-control-to-the-director-series-network-amplifiers
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: Director 控制能力增强。
- key_points:
  - "网络功放"
- install_notes: null
- app_takeaway_zh: 区监看 EQ。
- training_snippet: 功放智能化。

### SS407 | B&O 3rd-party drivers
- id: SS407
- category: luxury-av
- brand: Bang & Olufsen
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://support.bang-olufsen.com/hc/en-us/articles/360049859212-Drivers-for-3rd-Party-integration
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Crestron"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Mozart API、C4 SDDP、Crestron 模块。
- key_points:
  - "API"
- install_notes: null
- app_takeaway_zh: 走官方集成。
- training_snippet: B&O 可入四老牌。

### SS408 | Dorset Beovision + Control4
- id: SS408
- category: luxury-av
- brand: Bang & Olufsen
- subsystem: private cinema / luxury AV
- evidence_tier: E3
- source_url: https://livinghometech.co.uk/smart-home-blog/bangandolfuseninstallationdorset
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Theatre 电动架+C4 场景。
- key_points:
  - "电动架"
- install_notes: null
- app_takeaway_zh: 承重走线。
- training_snippet: B&O 机械动作入场景。

### SS409 | Wisdom Miami project
- id: SS409
- category: luxury-av
- brand: Wisdom Audio
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.wisdomaudio.com/sound-components-miami-project/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 迈阿密 Wisdom 项目。
- key_points:
  - "Sage"
- install_notes: null
- app_takeaway_zh: 平面振膜嵌入。
- training_snippet: Wisdom 豪宅。

### SS410 | CE Pro Wisdom 11.4.6 Crestron
- id: SS410
- category: luxury-av
- brand: Wisdom Audio
- subsystem: private cinema / luxury AV
- evidence_tier: E2
- source_url: https://www.cepro.com/projects/11-4-6-home-theater-234-inch-screen/28363/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 16座+234" +Crestron GUI。
- key_points:
  - "11.4.6"
- install_notes: null
- app_takeaway_zh: 巨幕。
- training_snippet: Wisdom+Crestron。

### SS411 | Fairfield Hall Wisdom Control4
- id: SS411
- category: luxury-av
- brand: Wisdom Audio
- subsystem: private cinema / luxury AV
- evidence_tier: E3
- source_url: https://www.clarkeinfinity.com/fairfield-hall-home-cinema-beautiful-design-meets-exceptional-performance/
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 9.1.4 Wisdom+Control4。
- key_points:
  - "9.1.4"
- install_notes: null
- app_takeaway_zh: 设计性能并重。
- training_snippet: 英系 Wisdom+C4。

### SS412 | Hyde Park Wisdom Crestron
- id: SS412
- category: luxury-av
- brand: Wisdom Audio
- subsystem: private cinema / luxury AV
- evidence_tier: E3
- source_url: https://vertexav.co.uk/projects/modern-townhouse-hyde-park
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 联排 Wisdom+CP4。
- key_points:
  - "联排"
- install_notes: null
- app_takeaway_zh: 空间约束。
- training_snippet: 伦敦联排。

### SS413 | Monitor Audio cinema Control4
- id: SS413
- category: luxury-av
- brand: Monitor Audio
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.monitoraudio.com/en/stories/custom-install-authentic-cinema-experience/
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 7.2.4+Control4。
- key_points:
  - "7.2.4"
- install_notes: null
- app_takeaway_zh: 建筑扬声器。
- training_snippet: MA+Control4。

### SS414 | Barco Swiss chalet
- id: SS414
- category: luxury-av
- brand: Barco
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.barco.com/en/news/customer-stories/residential/swiss-chalet
- source_name: Vendor/Media
- region: Europe/Switzerland
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 住宅激光投影由控制层做电源时序、镜头记忆与输入；常与幕布/灯光场景绑定。
- summary_zh: 瑞士木屋住宅投影。
- key_points:
  - "住宅投影"
- install_notes: null
- app_takeaway_zh: 高亮遮光。
- training_snippet: Barco 住宅。

### SS415 | Barco Njord Beijing villa
- id: SS415
- category: luxury-av
- brand: Barco
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.barco.com/en/news/customer-stories/residential/barco-njord-cs-redefines-home-theater-beijing
- source_name: Vendor/Media
- region: Asia/China
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 住宅激光投影由控制层做电源时序、镜头记忆与输入；常与幕布/灯光场景绑定。
- summary_zh: Njord CS 220" 北京别墅。
- key_points:
  - "Njord"
- install_notes: null
- app_takeaway_zh: 超宽幕亮度。
- training_snippet: 中国别墅投影。

### SS416 | Barco Beverly Hills + Kaleidescape
- id: SS416
- category: luxury-av
- brand: Barco
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.barco.com/en/news/customer-stories/residential/beverly-hills-a-most-beautiful-cinema-story
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 住宅激光投影由控制层做电源时序、镜头记忆与输入；常与幕布/灯光场景绑定。
- summary_zh: Prometheus+DCI/Kaleidescape。
- key_points:
  - "Prometheus"
- install_notes: null
- app_takeaway_zh: 特殊片源流程。
- training_snippet: 好莱坞向住宅。

### SS417 | Barco Madeira Consexto
- id: SS417
- category: luxury-av
- brand: Barco
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.barco.com/en/news/customer-stories/residential/consexto-madeira
- source_name: Vendor/Media
- region: Europe/Portugal
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 住宅激光投影由控制层做电源时序、镜头记忆与输入；常与幕布/灯光场景绑定。
- summary_zh: 马德拉影院故事。
- key_points:
  - "马德拉"
- install_notes: null
- app_takeaway_zh: 岛居别墅。
- training_snippet: 葡系投影。

### SS418 | DM NVX 7 projects
- id: SS418
- category: luxury-av
- brand: Crestron AV infrastructure
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.crestron.com/News/Blog/January-2024/DM-NVX-AV-OVER-IP-7-STATE-OF-THE-ART-PROJECTS
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: Crestron DM/NVX 等作为别墅影音视频骨干，本身即控制品牌基础设施，常与影院子系统并存。
- summary_zh: NVX AVoIP 尖端项目。
- key_points:
  - "NVX"
- install_notes: null
- app_takeaway_zh: VLAN/交换机。
- training_snippet: 别墅视频骨干。

### SS419 | Italian Residence DM NVX
- id: SS419
- category: luxury-av
- brand: Crestron AV infrastructure
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.crestron.com/News/Case-Studies/2023/Pages/Italian-Residence-Takes-Comfort-To-A-Whole-New-Lev
- source_name: Vendor/Media
- region: Europe/Italy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: Crestron DM/NVX 等作为别墅影音视频骨干，本身即控制品牌基础设施，常与影院子系统并存。
- summary_zh: 意大利宅 NVX 全屋 4K。
- key_points:
  - "意大利"
- install_notes: null
- app_takeaway_zh: 全屋视频。
- training_snippet: 欧宅 NVX。

### SS420 | Robin House seaside
- id: SS420
- category: luxury-av
- brand: Crestron AV infrastructure
- subsystem: private cinema / luxury AV
- evidence_tier: E1
- source_url: https://www.crestron.com/News/Case-Studies/2024/Robin-House
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: Crestron DM/NVX 等作为别墅影音视频骨干，本身即控制品牌基础设施，常与影院子系统并存。
- summary_zh: 海滨智能住宅。
- key_points:
  - "海滨"
- install_notes: null
- app_takeaway_zh: 潮湿选型。
- training_snippet: 海滨别墅。

### SS421 | CEDIA Cinema PA53 Crestron Home
- id: SS421
- category: luxury-av
- brand: Crestron AV infrastructure
- subsystem: private cinema / luxury AV
- evidence_tier: E2
- source_url: https://cedia.org/en-us/homeowners/smart-home-inspirations/cinema-pa53/
- source_name: Vendor/Media
- region: Europe/Germany
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: Crestron DM/NVX 等作为别墅影音视频骨干，本身即控制品牌基础设施，常与影院子系统并存。
- summary_zh: 汉堡古建 Crestron Home 影院。
- key_points:
  - "古建"
- install_notes: null
- app_takeaway_zh: 布线约束。
- training_snippet: CEDIA 灵感。

### SS422 | Preston Hollow 15-seat Crestron
- id: SS422
- category: luxury-av
- brand: Crestron AV infrastructure
- subsystem: private cinema / luxury AV
- evidence_tier: E3
- source_url: https://www.star-power.com/portfolio/preston-hollow-estate
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Lutron"]
- control_layer_fit: Crestron DM/NVX 等作为别墅影音视频骨干，本身即控制品牌基础设施，常与影院子系统并存。
- summary_zh: 15座 Atmos+180"幕+47区音频。
- key_points:
  - "超大宅"
- install_notes: null
- app_takeaway_zh: 分区规划。
- training_snippet: 德州豪宅。

### SS423 | CEDIA 2023 Americas awards
- id: SS423
- category: luxury-av
- brand: Industry / CEDIA
- subsystem: private cinema / luxury AV
- evidence_tier: E2
- source_url: https://cedia.org/en-us/smart-home-professionals/news/cedia-names-2023-cedia-smart-home-award-winners-americas/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Savant"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 含 Trinnov WaveForming 等。
- key_points:
  - "奖项"
- install_notes: null
- app_takeaway_zh: 技术趋势。
- training_snippet: 2023 奖项语料。

### SS424 | Inside CI CEDIA 2023 guide
- id: SS424
- category: luxury-av
- brand: Industry / CEDIA
- subsystem: private cinema / luxury AV
- evidence_tier: E2
- source_url: https://www.insideci.co.uk/articles/cedia-awards-2023-your-guide-to-all-the-winners.aspx
- source_name: Vendor/Media
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 获奖指南。
- key_points:
  - "指南"
- install_notes: null
- app_takeaway_zh: 欧刊导读。
- training_snippet: CEDIA 导读。

### SS425 | eCoustics Best CEDIA 2024
- id: SS425
- category: luxury-av
- brand: Industry / CEDIA
- subsystem: private cinema / luxury AV
- evidence_tier: E2
- source_url: https://www.ecoustics.com/news/best-cedia-expo-2024/
- source_name: Vendor/Media
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Expo 最佳展示。
- key_points:
  - "展会"
- install_notes: null
- app_takeaway_zh: 跟踪新品。
- training_snippet: 展会趋势。

### SS426 | CEDIA 2024 Strato V award
- id: SS426
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E2
- source_url: https://cedia.org/en-us/smart-home-professionals/news/cedia-celebrates-the-2024-cedia-smart-home-awards-americas-winners/
- source_name: CEDIA
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: Strato V 获最佳新硬件等。
- key_points:
  - "奖项"
- install_notes: null
- app_takeaway_zh: 片源层背书。
- training_snippet: Strato V 行业认可。

### SS427 | Kaleidescape gallery
- id: SS427
- category: luxury-av
- brand: Kaleidescape
- subsystem: movie server / cinema source
- evidence_tier: E1
- source_url: https://www.kaleidescape.com/gallery/
- source_name: Kaleidescape
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电影服务器播放事件适合触发控制层灯光淡入淡出、电动幕/遮幅、投影与音频输入选择（Control4/Crestron/Savant 均有官方或成熟驱动）。
- summary_zh: 官方安装图库。
- key_points:
  - "图库"
- install_notes: null
- app_takeaway_zh: 对客视觉。
- training_snippet: 官方案视觉。

### SS428 | Zebra Lumagen calibration
- id: SS428
- category: luxury-av
- brand: Lumagen
- subsystem: video processor
- evidence_tier: E3
- source_url: https://zebrahomecinema.com/blog/how-to-get-the-best-picture-on-tv-and-projector-lumagen-pro-calibration-with-gor
- source_name: Zebra
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 集成商 Lumagen 校准博文。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: Lumagen：Zebra Lumagen calibration。

### SS429 | Restrepo SI+Crestron+Lutron
- id: SS429
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://restrepoinnovations.com/services/portfolio-case-studies.html
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron", "Lutron"]
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 140" SI+Crestron+RadioRA。
- key_points:
  - "历史宅"
- install_notes: 仿护墙板声学。
- app_takeaway_zh: 改造双品牌控制。
- training_snippet: SI 幕控经验。

### SS430 | Airbnb SI motorized
- id: SS430
- category: luxury-av
- brand: Screen Innovations
- subsystem: projection screen / shading
- evidence_tier: E3
- source_url: https://www.screeninnovations.com/blog/gordon-vanzuidens-airbnb-featuring-si-motorized-projection-screen
- source_name: SI/Integrator
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 电动投影幕与遮阳是控制层高频负载：Lutron 键位或 Control4/Crestron/Savant 场景与片源/投影时序联动。
- summary_zh: 民宿电动幕。
- key_points:
  - "民宿"
- install_notes: null
- app_takeaway_zh: 轻量部署。
- training_snippet: SI 幕控经验。

### SS431 | Sonance Small Aperture award
- id: SS431
- category: luxury-av
- brand: Sonance
- subsystem: distributed / cinema loudspeakers & amplification
- evidence_tier: E1
- source_url: https://www.sonance.com/blogs/spotlights/ght-group-wins-2026-sonance-design-award-for-best-application-small-aperture-series
- source_name: Vendor/Media
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全屋分布式音频（Sonance/Triad/Origin/AudioControl）是四老牌 Watch/Listen 生态的核心子系统。
- summary_zh: 小开孔系列奖。
- key_points:
  - "小开孔"
- install_notes: null
- app_takeaway_zh: 天花开孔最小化。
- training_snippet: Small Aperture。

### SS432 | Resolute Crestron+Storm+KNX
- id: SS432
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E3
- source_url: https://resolute-av.com/case-study-integrated-audio-visual-system-for-luxury-residence/
- source_name: Resolute AV
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Crestron"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: Crestron+Storm+Meridian+KNX。
- key_points:
  - "KNX融合"
- install_notes: null
- app_takeaway_zh: 舒适层+体验层。
- training_snippet: 影音楼宇融合。

### SS433 | Puur Villa Haaksbergen
- id: SS433
- category: luxury-av
- brand: StormAudio
- subsystem: immersive AV processor
- evidence_tier: E3
- source_url: https://puuravd.com/inspiratie/audio-video-domotica-gerealiseerd-in-villa-haaksbergen
- source_name: Puur AVD
- region: Europe/Netherlands
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Savant", "Lutron"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 集成商侧互证官方案。
- key_points:
  - "互证"
- install_notes: null
- app_takeaway_zh: 与 Storm 官方对照。
- training_snippet: 荷系整案。

### SS434 | HTT Trinnov+Wisdom 7.1.4
- id: SS434
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E3
- source_url: https://hometheatertours.com/project/high-end-7-1-4-dolby-atmos-home-theater-tour-trinnov-and-wisdom-audio/
- source_name: Home Theater Tours
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: 7.1.4 Trinnov+Wisdom。
- key_points:
  - "Wisdom"
- install_notes: null
- app_takeaway_zh: 美式旗舰配对。
- training_snippet: Trinnov+Wisdom。

### SS435 | Trinnov CEDIA 2024 hub
- id: SS435
- category: luxury-av
- brand: Trinnov
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://hub.trinnov.com/cedia2024
- source_name: Trinnov
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: WaveForming+Barco+Kaleidescape+madVR 生态演示。
- key_points:
  - "生态"
- install_notes: null
- app_takeaway_zh: 参考演示栈。
- training_snippet: 厂商生态同台。

### SS436 | madVR testimonials
- id: SS436
- category: luxury-av
- brand: madVR
- subsystem: video processor
- evidence_tier: E1
- source_url: https://madvrenvy.com/wp-content/uploads/madVR-Envy-Testimonials.pdf
- source_name: madVR
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 视频处理器（Lumagen/madVR）串在片源与投影之间，控制层可切换记忆/宽高比并与遮幅联动。
- summary_zh: 推荐证言集。
- key_points:
  - "视频处理"
- install_notes: null
- app_takeaway_zh: 片源→VP→投影。
- training_snippet: madVR：madVR testimonials。

### SS437 | SDP-58 Control4/Crestron drivers
- id: SS437
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/products/electronics/SDP58-.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Crestron"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: SDP-58 Control4/Crestron drivers。
- key_points:
  - "驱动"
- install_notes: null
- app_takeaway_zh: BOM 验证驱动。
- training_snippet: 官方四老牌驱动。

### SS438 | SDP-75 Savant/C4/Crestron drivers
- id: SS438
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/SDP-75-.html
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Crestron", "Savant"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: SDP-75 Savant/C4/Crestron drivers。
- key_points:
  - "驱动"
- install_notes: null
- app_takeaway_zh: BOM 验证驱动。
- training_snippet: 官方四老牌驱动。

### SS439 | JBL Synthesis support drivers
- id: SS439
- category: luxury-av
- brand: JBL Synthesis
- subsystem: immersive AV processor
- evidence_tier: E1
- source_url: https://www.jblsynthesis.com/support/
- source_name: JBL Synthesis
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4", "Crestron"]
- control_layer_fit: 沉浸声/环绕处理器通常经 IP 或串口接入 Control4/Crestron/Savant：切换输入、调用预设、音量与开/待机；灯光/幕布/投影由控制层统一编排。
- summary_zh: JBL Synthesis support drivers。
- key_points:
  - "驱动"
- install_notes: null
- app_takeaway_zh: BOM 验证驱动。
- training_snippet: 官方四老牌驱动。

### SS440 | Procella: Residents Only Procella Cinema Pan Peninsula
- id: SS440
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/residents-only-procella-cinema---pan-peninsula
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Residents Only Procella Cinema Pan Peninsula》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Residents Only Procella Cinema Pan Peninsula。

### SS441 | Procella: Private Cinema Robert Andersson In Herrljunga
- id: SS441
- category: luxury-av
- brand: Procella
- subsystem: cinema loudspeakers
- evidence_tier: E1
- source_url: https://www.procella.audio/case-studies/private-cinema-robert-andersson-in-herrljunga
- source_name: Procella Audio
- region: global
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: Procella 官方案《Private Cinema Robert Andersson In Herrljunga》。
- key_points:
  - "官方案"
- install_notes: null
- app_takeaway_zh: 参考扬声器案例。
- training_snippet: Procella Private Cinema Robert Andersson In Herrljunga。

### SS442 | Meridian case: Progressive Home Technology Prestigious New Build Hastings
- id: SS442
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/progressive-home-technology-prestigious-new-build-hastings
- source_name: Meridian Audio
- region: Europe/UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Progressive Home Technology Prestigious New Build Hastings》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Progressive Home Technology Prestigious New Build Hastings。

### SS443 | Meridian case: Sav Digital Environments Big Sky Montana
- id: SS443
- category: luxury-av
- brand: Meridian
- subsystem: active DSP loudspeakers / cinema audio
- evidence_tier: E1
- source_url: https://www.meridian-audio.com/case-studies/luxury-home-audio/sav-digital-environments-big-sky-montana
- source_name: Meridian Audio
- region: North America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 有源/分布式扬声器与多通道功放由控制层做区切、场景与音量；影院通道仍由沉浸声处理器管理。
- summary_zh: 官方豪华住宅案《Sav Digital Environments Big Sky Montana》。
- key_points:
  - "DSP有源"
- install_notes: 有源扬声器独立供电与数字链路。
- app_takeaway_zh: 官方案例库引用。
- training_snippet: Meridian Sav Digital Environments Big Sky Montana。
