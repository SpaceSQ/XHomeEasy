# X Home Easy · 别墅新风/ERV 子系统方案库

- **主题**：ERV/HRV/IAQ 新风与四老牌/KNX 控制层融合
- **收集日期**：2026-10-21（Asia/Shanghai）
- **条目数**：84
- **证据分层**：E1 厂商官方；E2 协会/贸易媒体；E3 集成商/渠道；E4 社区
- **免责声明**：公开二手资料，供方案建议与本地模型训练；非法律意见、非施工规范。

## 品牌计数

| brand | count |
|---|---|
| Zehnder | 25 |
| RenewAire | 13 |
| Broan-NuTone | 11 |
| Panasonic Ventilation | 10 |
| UltimateAir | 7 |
| ERV/HRV generic villa | 6 |
| Venmar | 5 |
| Aprilaire | 4 |
| Mitsubishi Electric | 2 |
| Control4 | 1 |

| **total** | **84** |

---

### SS181 | Zehnder ComfoConnect KNX C international
- id: SS181
- category: ventilation-erv
- brand: Zehnder
- subsystem: KNX C
- evidence_tier: E1
- region: Europe
- source_url: https://www.international.zehnder-systems.com/en/comfortable-indoor-ventilation/products/connectivity/interface-module/zehnder-comfoconnect-knx-c
- source_name: Zehnder International
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: KNX C 把 ComfoAir Q 挂上 KNX，再经 KNX 网关进 Control4/Crestron/Savant。
- summary_zh: 官方接口模块页：风量、工况、加强、传感器设定、维护报警。KNX C 把 ComfoAir Q 挂上 KNX，再经 KNX 网关进 Control4/Crestron/Savant。要点：KNX C；ComfoAir Q。来源为Zehnder International（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：欧式别墅：ERV→KNX→四老牌。安装边界：仅兼容 Q 系列，ComfoNet 四线。
- key_points:
  - "KNX C"
  - "ComfoAir Q"
- install_notes: "仅兼容 Q 系列，ComfoNet 四线。"
- app_takeaway_zh: 欧式别墅：ERV→KNX→四老牌。
- training_snippet: 公开资料表明 Zehnder 的 KNX C 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS182 | ComfoConnect KNX C Manual PDF
- id: SS182
- category: ventilation-erv
- brand: Zehnder
- subsystem: KNX manual
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://zehnderamerica.com/wp-content/uploads/2024/08/ComfoConnect-KNX-C-Manual-1.pdf
- source_name: Zehnder America
- published: 2024
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ETS 库与对象表支撑有线中枢映射。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 完整手册：ComfoNet、ETS5、对象。ETS 库与对象表支撑有线中枢映射。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：ETS；手册。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / KNX manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：须 ETS 工程。
- key_points:
  - "ETS"
  - "手册"
- install_notes: "须 ETS 工程。"
- app_takeaway_zh: 将「Zehnder / KNX manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 KNX manual 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS183 | Zehnder smart home for ventilation
- id: SS183
- category: ventilation-erv
- brand: Zehnder
- subsystem: Smart home
- evidence_tier: E1
- region: Europe
- source_url: https://www.international.zehnder-systems.com/en/comfortable-indoor-ventilation/products/connectivity/smarthome-for-ventilation-systems
- source_name: Zehnder International
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 智能家居连接总述。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 通风系统智能连接选项。智能家居连接总述。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：智能家居总述。来源为Zehnder International（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：将「Zehnder / Smart home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 Smart home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "智能家居总述"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / Smart home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Smart home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS184 | Zehnder America Control KNX C interface
- id: SS184
- category: ventilation-erv
- brand: Zehnder
- subsystem: US KNX product
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://zehnderamerica.com/products/control-options/knx-c-interface
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美站产品页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: KNX C 产品说明。北美站产品页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：北美。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / US KNX product」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 US KNX product 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "北美"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / US KNX product」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 US KNX product 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS185 | Zehnder UK ComfoConnect KNX
- id: SS185
- category: ventilation-erv
- brand: Zehnder
- subsystem: UK KNX
- evidence_tier: E1
- region: UK
- source_url: https://www.zehnder.co.uk/en/indoor-ventilation/solutions/controls-sensors-connectivity/zehnder-comfoconnect-knx
- source_name: Zehnder UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 英国站 KNX 页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: UK 产品与连接说明。英国站 KNX 页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：UK。来源为Zehnder UK（E1），地域标签 UK，抓取日 2026-10-21。应用提示：将「Zehnder / UK KNX」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 UK KNX 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "UK"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / UK KNX」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 UK KNX 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS186 | Zehnder UK ComfoConnect LAN C
- id: SS186
- category: ventilation-erv
- brand: Zehnder
- subsystem: LAN C UK
- evidence_tier: E1
- region: UK
- source_url: https://www.zehnder.co.uk/en/indoor-ventilation/solutions/controls-sensors-connectivity/zehnder-comfoconnect-lan
- source_name: Zehnder UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: LAN C 经 App 控制，中枢可用网络/继电器联锁加强档。
- summary_zh: LAN 接口远程监控与日程。LAN C 经 App 控制，中枢可用网络/继电器联锁加强档。要点：LAN C；App。来源为Zehnder UK（E1），地域标签 UK，抓取日 2026-10-21。应用提示：App+中枢场景并行。公开资料表明 Zehnder 的 LAN C UK 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "LAN C"
  - "App"
- install_notes: null
- app_takeaway_zh: App+中枢场景并行。
- training_snippet: 公开资料表明 Zehnder 的 LAN C UK 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS187 | ComfoConnect LAN C datasheet PDF
- id: SS187
- category: ventilation-erv
- brand: Zehnder
- subsystem: LAN datasheet
- evidence_tier: E1
- region: Europe
- source_url: https://zehnder.hu/wp-content/uploads/2023/05/Zehnder_CSY_ComfoConnect_LAN-C_UK-en_productdatasheet.pdf
- source_name: Zehnder
- published: 2023
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 数据表规格。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: LAN C 产品数据表。数据表规格。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：数据表。来源为Zehnder（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：将「Zehnder / LAN datasheet」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 LAN datasheet 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "数据表"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / LAN datasheet」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 LAN datasheet 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS188 | Baulinks：ComfoAir Q600 活化老别墅
- id: SS188
- category: ventilation-erv
- brand: Zehnder
- subsystem: Stuttgart villa
- evidence_tier: E3
- region: Germany
- source_url: https://www.baulinks.de/webplugin/2025/0962.php4
- source_name: Baulinks
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 德式老别墅案例：地下室 Q600+App 控制，可再接 KNX/中枢。
- summary_zh: 1910 斯图加特别墅改造通风案例。德式老别墅案例：地下室 Q600+App 控制，可再接 KNX/中枢。要点：案例；老别墅。来源为Baulinks（E3），地域标签 Germany，抓取日 2026-10-21。应用提示：将「Zehnder / Stuttgart villa」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 Stuttgart villa 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "案例"
  - "老别墅"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / Stuttgart villa」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Stuttgart villa 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS189 | Modena overheating reduction ComfoPost case PDF
- id: SS189
- category: ventilation-erv
- brand: Zehnder
- subsystem: Modena case
- evidence_tier: E1
- region: Italy
- source_url: https://www.specifiedby.com/zehnder-group-uk-ltd/zehnder-comfopost-cw8/comfopost-modena-case-study_1ce7cd5e.pdf
- source_name: Zehnder/SpecifiedBy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 意大利住宅平衡通风+后冷案例。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 过热缓解与 ComfoPost 案例。意大利住宅平衡通风+后冷案例。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：意大利；后冷。来源为Zehnder/SpecifiedBy（E1），地域标签 Italy，抓取日 2026-10-21。应用提示：将「Zehnder / Modena case」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 Modena case 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "意大利"
  - "后冷"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / Modena case」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Modena case 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS190 | Verhees villa WPL+ComfoAir Q450
- id: SS190
- category: ventilation-erv
- brand: Zehnder
- subsystem: NL villa
- evidence_tier: E3
- region: Netherlands
- source_url: https://www.verheesenvandijk.nl/galerie/moderne-villa-met-geavanceerde-installaties
- source_name: Verhees en van Dijk
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 现代别墅热泵+Zehnder 新风集成商案例，上层可加有线中枢。
- summary_zh: 荷兰现代别墅设备展示。现代别墅热泵+Zehnder 新风集成商案例，上层可加有线中枢。要点：荷兰别墅；热泵+新风。来源为Verhees en van Dijk（E3），地域标签 Netherlands，抓取日 2026-10-21。应用提示：将「Zehnder / NL villa」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 NL villa 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "荷兰别墅"
  - "热泵+新风"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / NL villa」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 NL villa 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS191 | Alta Lake Passive House award Zehnder
- id: SS191
- category: ventilation-erv
- brand: Zehnder
- subsystem: Alta Lake
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com/award-won-for-alta-lake-passive-house
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 被动房获奖项目用 ComfoAir HRV。
- summary_zh: Alta Lake 被动房新闻。被动房获奖项目用 ComfoAir HRV。要点：被动房；获奖。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / Alta Lake」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 Alta Lake 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "被动房"
  - "获奖"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / Alta Lake」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Alta Lake 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS192 | Zehnder ERV IAQ family home testing
- id: SS192
- category: ventilation-erv
- brand: Zehnder
- subsystem: IAQ testing
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com/results-are-in-testing-confirms-zehnder-erv-boosts-indoor-air-quality-in-family-home
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 实测 IAQ 提升，支撑中枢 IAQ 场景。
- summary_zh: 家庭住宅 ERV 测试结果。实测 IAQ 提升，支撑中枢 IAQ 场景。要点：IAQ实测。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：卖点：可量化 IAQ。公开资料表明 Zehnder 的 IAQ testing 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "IAQ实测"
- install_notes: null
- app_takeaway_zh: 卖点：可量化 IAQ。
- training_snippet: 公开资料表明 Zehnder 的 IAQ testing 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS193 | ComfoFond-L Q ST brine HEX
- id: SS193
- category: ventilation-erv
- brand: Zehnder
- subsystem: ComfoFond
- evidence_tier: E1
- region: Europe
- source_url: https://www.international.zehnder-systems.com/en/comfortable-indoor-ventilation/products/units/ventilation-units-up-to-600-m3/h/brine-earth-heat-exchanger/zehnder-comfofond-l-q-st
- source_name: Zehnder International
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 地埋预热/预冷与 Q 系列联用，由中枢季节场景切换。
- summary_zh: 盐水式地热交换器产品页。地埋预热/预冷与 Q 系列联用，由中枢季节场景切换。要点：地热交换；预冷热。来源为Zehnder International（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：高端别墅加 ComfoFond。公开资料表明 Zehnder 的 ComfoFond 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "地热交换"
  - "预冷热"
- install_notes: null
- app_takeaway_zh: 高端别墅加 ComfoFond。
- training_snippet: 公开资料表明 Zehnder 的 ComfoFond 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS194 | Zehnder America geothermal heat exchangers
- id: SS194
- category: ventilation-erv
- brand: Zehnder
- subsystem: Geothermal US
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com/products/geothermal-heat-exchangers
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美地热交换器品类。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 地热新风附件。北美地热交换器品类。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：地热。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / Geothermal US」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 Geothermal US 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "地热"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / Geothermal US」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Geothermal US 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS195 | Zehnder ComfoSystems install videos
- id: SS195
- category: ventilation-erv
- brand: Zehnder
- subsystem: Install videos
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com/installation-videos/comfosystems-hrv
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安装视频界定施工边界。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: HRV 安装视频集。安装视频界定施工边界。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：安装视频。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / Install videos」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：视频非规范替代。
- key_points:
  - "安装视频"
- install_notes: "视频非规范替代。"
- app_takeaway_zh: 将「Zehnder / Install videos」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 Install videos 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS196 | Broan Overture Control4 instruction guide PDF
- id: SS196
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Overture C4 guide
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://broan-nutone.com/getmedia/41b69354-ae25-45f1-818c-b776b9c35f60/Broan-NuTone-Instruction-Guide_Control4.pdf
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 官方 C4 集成指南，四老牌直接控 IAQ/新风联动。
- summary_zh: Overture Cloud 驱动安装与变量。官方 C4 集成指南，四老牌直接控 IAQ/新风联动。要点：Overture；C4官方。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：北美 IAQ 首选 C4 路径。安装边界：需 OS 3.2+。
- key_points:
  - "Overture"
  - "C4官方"
- install_notes: "需 OS 3.2+。"
- app_takeaway_zh: 北美 IAQ 首选 C4 路径。
- training_snippet: 公开资料表明 Broan-NuTone 的 Overture C4 guide 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS197 | Broan Overture Zone Control4 API docs PDF
- id: SS197
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Overture API
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://broan-nutone.com/getmedia/d7ce7eef-5723-41ae-8714-8757a6a3e996/Broan-NuTone-and-Control4-API-Driver-Documentation-Zone-and-Cloud.pdf
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: Zone/Cloud 驱动 API 文档。
- summary_zh: CO2/TVOC/PM2.5 等变量与事件。Zone/Cloud 驱动 API 文档。要点：API；IAQ变量。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：场景用 IAQ 事件触发加强通风。公开资料表明 Broan-NuTone 的 Overture API 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "API"
  - "IAQ变量"
- install_notes: null
- app_takeaway_zh: 场景用 IAQ 事件触发加强通风。
- training_snippet: 公开资料表明 Broan-NuTone 的 Overture API 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS198 | Broan Overture fresh air system
- id: SS198
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Overture product
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.broan-nutone.com/en-us/overture
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 全宅自动化新风/IAQ 产品页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 传感器驱动 ERV/排风扇等。全宅自动化新风/IAQ 产品页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：Overture；全宅IAQ。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：与 HVAC 子系统并列。公开资料表明 Broan-NuTone 的 Overture product 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "Overture"
  - "全宅IAQ"
- install_notes: null
- app_takeaway_zh: 与 HVAC 子系统并列。
- training_snippet: 公开资料表明 Broan-NuTone 的 Overture product 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS199 | Overture IBS connected IAQ fact sheet PDF
- id: SS199
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: IBS factsheet
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.buildersshow.com/assets/docs/ibs/pressKits/PK_35372_ConnectedIAQFactSheet.pdf
- source_name: IBS/Broan
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 展会事实页强调云连接 IAQ。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 首个云连接全宅 IAQ 系统宣传。展会事实页强调云连接 IAQ。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：展会；云IAQ。来源为IBS/Broan（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / IBS factsheet」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 IBS factsheet 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "展会"
  - "云IAQ"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / IBS factsheet」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 IBS factsheet 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS200 | Venmar wall controls spec sheet
- id: SS200
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Venmar wall controls
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://broan-nutone.com/getmedia/1a874c5f-c8e9-4695-87a3-08558cae8d44/Venmar_Wall_Controls_Spec_Sheet_En.pdf?ext=.pdf
- source_name: Broan-NuTone/Venmar
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Venmar 墙控低压双向通信，中枢可用干接点/接口联锁。
- summary_zh: 墙控规格表。Venmar 墙控低压双向通信，中枢可用干接点/接口联锁。要点：Venmar墙控。来源为Broan-NuTone/Venmar（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：保留墙控+中枢场景。公开资料表明 Broan-NuTone 的 Venmar wall controls 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "Venmar墙控"
- install_notes: null
- app_takeaway_zh: 保留墙控+中枢场景。
- training_snippet: 公开资料表明 Broan-NuTone 的 Venmar wall controls 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS201 | Venmar IAQ complete brochure PDF
- id: SS201
- category: ventilation-erv
- brand: Venmar
- subsystem: Brochure
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://constructioninstruction.com/wp-content/uploads/2020/11/Venmar-complete-brochure.pdf
- source_name: Venmar/CI
- published: 2020
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 产品册覆盖 ERV/HRV 别墅应用。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 全线 IAQ 产品册。产品册覆盖 ERV/HRV 别墅应用。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：产品册。来源为Venmar/CI（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Venmar / Brochure」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Venmar 的 Brochure 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "产品册"
- install_notes: null
- app_takeaway_zh: 将「Venmar / Brochure」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Venmar 的 Brochure 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS202 | Venmar wall controls EN/FR spec
- id: SS202
- category: ventilation-erv
- brand: Venmar
- subsystem: Wall controls FR
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://broan-nutone.com/getmedia/a91b1616-4d06-449c-abfa-0c14add1aa99/Spec_Sheet_WallControls_En_Fr.pdf?ext=.pdf
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 双语墙控规格。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 墙控规格英法。双语墙控规格。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：双语规格。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Venmar / Wall controls FR」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Venmar 的 Wall controls FR 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "双语规格"
- install_notes: null
- app_takeaway_zh: 将「Venmar / Wall controls FR」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Venmar 的 Wall controls FR 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS203 | Venmar touchscreen control 41403 dealer page
- id: SS203
- category: ventilation-erv
- brand: Venmar
- subsystem: Touchscreen 41403
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://impressiveclimate.com/products/new-venmar-touchscreen-control-41403
- source_name: Impressive Climate
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 触摸屏控制器零售说明。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 41403 控制面板。触摸屏控制器零售说明。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：触摸屏。来源为Impressive Climate（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Venmar / Touchscreen 41403」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Venmar 的 Touchscreen 41403 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "触摸屏"
- install_notes: null
- app_takeaway_zh: 将「Venmar / Touchscreen 41403」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Venmar 的 Touchscreen 41403 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS204 | Build with Rise: add ERV/HRV to existing home
- id: SS204
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: Retrofit guide
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.buildwithrise.com/stories/can-you-add-an-erv-or-hrv-to-an-existing-home
- source_name: Build with Rise
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 改造加装经验，适合四老牌改造项目并行。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 既有住宅加装 ERV/HRV 可行性与注意点。改造加装经验，适合四老牌改造项目并行。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：改造；加装。来源为Build with Rise（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / Retrofit guide」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：须专业风系统设计。
- key_points:
  - "改造"
  - "加装"
- install_notes: "须专业风系统设计。"
- app_takeaway_zh: 将「ERV/HRV generic villa / Retrofit guide」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 Retrofit guide 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS205 | Panasonic Intelli-Balance 100 Any Climate ERV
- id: SS205
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Intelli-Balance 100
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://iaq.na.panasonic.com/erv/intelli-balance-100-any-climate-corded
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 30-100 CFM 平衡新风，可经 Swidget/干接点进中枢。
- summary_zh: 产品页：ASHRAE 62.2、Boost。30-100 CFM 平衡新风，可经 Swidget/干接点进中枢。要点：Intelli-Balance；62.2。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / Intelli-Balance 100」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 Intelli-Balance 100 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "Intelli-Balance"
  - "62.2"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / Intelli-Balance 100」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Intelli-Balance 100 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS206 | Panasonic Swidget Wi-Fi control module
- id: SS206
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Swidget module
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://iaq.na.panasonic.com/smart-controls/swidget/wi-fi-control-module
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Wi-Fi 模块使 App/自动化可触发 Boost，中枢可间接联动。
- summary_zh: WP100PBA 模块页。Wi-Fi 模块使 App/自动化可触发 Boost，中枢可间接联动。要点：Swidget；Wi-Fi。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：Boost 场景联动。公开资料表明 Panasonic Ventilation 的 Swidget module 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "Swidget"
  - "Wi-Fi"
- install_notes: null
- app_takeaway_zh: Boost 场景联动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Swidget module 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS207 | Swidget compatible Panasonic products FAQ
- id: SS207
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Swidget compat
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://support.swidget.com/hc/en-us/articles/30548772736532-What-Panasonic-products-are-compatible-with-the-Wi-Fi-module
- source_name: Swidget
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 兼容机型列表。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Elite/Elite Plus 等兼容说明。兼容机型列表。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：兼容列表。来源为Swidget（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / Swidget compat」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 Swidget compat 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "兼容列表"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / Swidget compat」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Swidget compat 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS208 | About Swidget Wi-Fi module WP100PBA
- id: SS208
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: WP100 about
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://support.swidget.com/hc/en-us/articles/50316083310228-About-the-Wi-Fi-Control-Module-WP100PBA
- source_name: Swidget
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 模块功能说明。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 状态、报警、日程。模块功能说明。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：功能。来源为Swidget（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / WP100 about」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 WP100 about 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "功能"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / WP100 about」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 WP100 about 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS209 | Which ERV actions automatable Swidget
- id: SS209
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Automations
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://support.swidget.com/hc/en-us/articles/50943508453780-Which-ERV-actions-can-be-automated-or-scheduled
- source_name: Swidget
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 目前主要 Boost 可自动化——中枢场景设计边界。
- summary_zh: 可自动化动作说明。目前主要 Boost 可自动化——中枢场景设计边界。要点：Boost；自动化边界。来源为Swidget（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：勿承诺未开放的风量细调。公开资料表明 Panasonic Ventilation 的 Automations 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "Boost"
  - "自动化边界"
- install_notes: null
- app_takeaway_zh: 勿承诺未开放的风量细调。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Automations 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS210 | RenewAire BACnet Fan Control product
- id: SS210
- category: ventilation-erv
- brand: RenewAire
- subsystem: BACnet fan control
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/parts-accessories/bacnet-fan-control
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: BACnet MS/TP 风扇控制，四老牌 BACnet 恒温器/对象可直接驱。
- summary_zh: 配件页：启停与 HE 系列风速。BACnet MS/TP 风扇控制，四老牌 BACnet 恒温器/对象可直接驱。要点：BACnet；风扇。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：别墅 ERV 走 BACnet 附件。公开资料表明 RenewAire 的 BACnet fan control 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "BACnet"
  - "风扇"
- install_notes: null
- app_takeaway_zh: 别墅 ERV 走 BACnet 附件。
- training_snippet: 公开资料表明 RenewAire 的 BACnet fan control 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS211 | BACnet Fan Control supplement manual PDF
- id: SS211
- category: ventilation-erv
- brand: RenewAire
- subsystem: BACnet manual
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/06/BACnet_Fan_Control_Supplement_105802_003_FEB26.pdf
- source_name: RenewAire
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 对象定义与接线。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 安装与 BACnet 对象手册。对象定义与接线。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：对象表；接线。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / BACnet manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：24VAC 等由持证人员。
- key_points:
  - "对象表"
  - "接线"
- install_notes: "24VAC 等由持证人员。"
- app_takeaway_zh: 将「RenewAire / BACnet manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 BACnet manual 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS212 | BACnet fan controller flyer PDF
- id: SS212
- category: ventilation-erv
- brand: RenewAire
- subsystem: BACnet flyer
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/05/BACNet-fan-controller-flyer-digital.pdf
- source_name: RenewAire
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 宣传折页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: BACnet 风扇控制折页。宣传折页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：折页。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / BACnet flyer」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 BACnet flyer 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "折页"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / BACnet flyer」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 BACnet flyer 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS213 | ERV Controls At-A-Glance flyer PDF
- id: SS213
- category: ventilation-erv
- brand: RenewAire
- subsystem: Controls glance
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/05/LIT167-Laminated-ERVControlsAtAGlance.pdf
- source_name: RenewAire
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 控制选项一览，含 Premium BACnet/Modbus。
- summary_zh: 控制层级对照表。控制选项一览，含 Premium BACnet/Modbus。要点：控制一览。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / Controls glance」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 Controls glance 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "控制一览"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / Controls glance」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 Controls glance 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS214 | Integrated Programmable Controls brochure PDF
- id: SS214
- category: ventilation-erv
- brand: RenewAire
- subsystem: IPC brochure
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/05/RenewAire-IPC-Controls-Brochure.pdf
- source_name: RenewAire
- published: 2025
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 可编程控制宣传。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: IPC 控制册。可编程控制宣传。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：IPC。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / IPC brochure」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 IPC brochure 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "IPC"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / IPC brochure」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 IPC brochure 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS215 | HE Series ERV installation manual PDF
- id: SS215
- category: ventilation-erv
- brand: RenewAire
- subsystem: HE install
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/05/HE07-20INMan_147621.pdf
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: HE 系列安装手册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 安装与运行说明。HE 系列安装手册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：HE安装。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / HE install」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：专业安装。
- key_points:
  - "HE安装"
- install_notes: "专业安装。"
- app_takeaway_zh: 将「RenewAire / HE install」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 HE install 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS216 | RenewAire RTC manual PDF
- id: SS216
- category: ventilation-erv
- brand: RenewAire
- subsystem: RTC manual
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/wp-content/uploads/2025/05/RTCMan_134769_010_MAY24.pdf
- source_name: RenewAire
- published: 2024
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 另一控制/机型手册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: RTC 相关手册。另一控制/机型手册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：RTC。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / RTC manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 RTC manual 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "RTC"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / RTC manual」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 RTC manual 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS217 | UltimateAir ERV control compatibility GBA
- id: SS217
- category: ventilation-erv
- brand: UltimateAir
- subsystem: GBA thread
- evidence_tier: E4
- region: NorthAmerica
- source_url: https://www.greenbuildingadvisor.com/question/ultimate-air-erv
- source_name: GreenBuildingAdvisor
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 社区讨论 0-10V/干接点，便于中枢模拟量/继电器接入。
- summary_zh: 控制兼容性问答。社区讨论 0-10V/干接点，便于中枢模拟量/继电器接入。要点：0-10V；干接点。来源为GreenBuildingAdvisor（E4），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：用 0-10V 网关进中枢。安装边界：社区经验。本条收录品牌「UltimateAir」子系统「GBA thread」公开页面《UltimateAir ERV control compatibility GBA》，供别墅有线智能家居控制层融合方案与本地模型训练检索。
- key_points:
  - "0-10V"
  - "干接点"
- install_notes: "社区经验。"
- app_takeaway_zh: 用 0-10V 网关进中枢。
- training_snippet: 公开资料表明 UltimateAir 的 GBA thread 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E4。

### SS218 | RecoupAerator fresh filtered air Monolithic
- id: SS218
- category: ventilation-erv
- brand: UltimateAir
- subsystem: Monolithic
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.monolithic.org/products-interior/the-recoupaerator-fresh-filtered-air
- source_name: Monolithic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 产品介绍含外部控制输入。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: RecoupAerator 功能叙述。产品介绍含外部控制输入。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：RecoupAerator。来源为Monolithic（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / Monolithic」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 UltimateAir 的 Monolithic 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "RecoupAerator"
- install_notes: null
- app_takeaway_zh: 将「UltimateAir / Monolithic」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 Monolithic 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS219 | UltimateAir ERV WiFi control blog
- id: SS219
- category: ventilation-erv
- brand: UltimateAir
- subsystem: Twinsprings WiFi
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://blog.twinsprings.com/2018/04/19/ultimateair-erv-wifi-control
- source_name: Twinsprings Research
- published: 2018
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: WiFi 0-10V 控制器实践，可桥接中枢。
- summary_zh: 自建 WiFi 控制经验。WiFi 0-10V 控制器实践，可桥接中枢。要点：WiFi；0-10V。来源为Twinsprings Research（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / Twinsprings WiFi」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：勿并联多路 0-10V。
- key_points:
  - "WiFi"
  - "0-10V"
- install_notes: "勿并联多路 0-10V。"
- app_takeaway_zh: 将「UltimateAir / Twinsprings WiFi」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 Twinsprings WiFi 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS220 | UltimateAir 200DX install instructions mirror
- id: SS220
- category: ventilation-erv
- brand: UltimateAir
- subsystem: 200DX manual mirror
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://usersmanualguide.com/ultimateair/heating-system/200dx/installation-and-operating-instructions/1bm6n
- source_name: Manual mirror
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 安装操作说明镜像。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 200DX 安装与运行。安装操作说明镜像。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：200DX。来源为Manual mirror（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / 200DX manual mirror」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：以厂家原件为准。
- key_points:
  - "200DX"
- install_notes: "以厂家原件为准。"
- app_takeaway_zh: 将「UltimateAir / 200DX manual mirror」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 200DX manual mirror 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS221 | RecoupAerator 2000DX safety guide mirror
- id: SS221
- category: ventilation-erv
- brand: UltimateAir
- subsystem: 2000DX safety
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://usersmanualguide.com/ultimateair/heating-system/recoupaerator-2000dx/safety-guide/14zk6
- source_name: Manual mirror
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 大风量机型安全/外部控制提示。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 2000DX 安全指南。大风量机型安全/外部控制提示。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：2000DX。来源为Manual mirror（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / 2000DX safety」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：安全须合规。
- key_points:
  - "2000DX"
- install_notes: "安全须合规。"
- app_takeaway_zh: 将「UltimateAir / 2000DX safety」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 2000DX safety 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS222 | Zehnder international ventilation hub
- id: SS222
- category: ventilation-erv
- brand: Zehnder
- subsystem: International home
- evidence_tier: E1
- region: Europe
- source_url: https://www.international.zehnder-systems.com/en/comfortable-indoor-ventilation
- source_name: Zehnder International
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 国际站通风中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 舒适通风产品导航。国际站通风中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：导航。来源为Zehnder International（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：将「Zehnder / International home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 International home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "导航"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / International home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 International home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS223 | Zehnder America home
- id: SS223
- category: ventilation-erv
- brand: Zehnder
- subsystem: America home
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美站首页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 产品与案例入口。北美站首页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：北美站。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / America home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 America home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "北美站"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / America home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 America home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS224 | Broan-NuTone official home
- id: SS224
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Brand home
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.broan-nutone.com
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 品牌总站含通风与 IAQ。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 官网首页。品牌总站含通风与 IAQ。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：品牌。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / Brand home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 Brand home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "品牌"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / Brand home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 Brand home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS225 | Panasonic NA IAQ hub
- id: SS225
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: IAQ hub
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://iaq.na.panasonic.com
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美 IAQ/ERV 中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: IAQ 产品导航。北美 IAQ/ERV 中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：IAQ中心。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / IAQ hub」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 IAQ hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "IAQ中心"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / IAQ hub」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 IAQ hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS226 | RenewAire official home
- id: SS226
- category: ventilation-erv
- brand: RenewAire
- subsystem: Brand home
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ERV 品牌总站。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 官网首页。ERV 品牌总站。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：品牌。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / Brand home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 Brand home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "品牌"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / Brand home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 Brand home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS227 | RenewAire Premium Controls owner manual mirror
- id: SS227
- category: ventilation-erv
- brand: RenewAire
- subsystem: Premium controls mirror
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://manuzoid.com/manuals/AYPl5-RenewAire%20Premium%20Controls%20Owner's%20manual
- source_name: Manual mirror
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Premium 控制含 BACnet/Modbus 说明镜像。
- summary_zh: 所有者手册镜像。Premium 控制含 BACnet/Modbus 说明镜像。要点：Premium。来源为Manual mirror（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / Premium controls mirror」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。安装边界：以官网 PDF 为准。
- key_points:
  - "Premium"
- install_notes: "以官网 PDF 为准。"
- app_takeaway_zh: 将「RenewAire / Premium controls mirror」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 Premium controls mirror 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS228 | Search landing via KNX page parent connectivity
- id: SS228
- category: ventilation-erv
- brand: Zehnder
- subsystem: ComfoAir Q product family intl
- evidence_tier: E1
- region: Europe
- source_url: https://www.international.zehnder-systems.com/en/comfortable-indoor-ventilation/products/connectivity
- source_name: Zehnder International
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 连接产品品类页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Connectivity 产品集合。连接产品品类页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：连接品类。来源为Zehnder International（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：选 KNX/LAN/App。公开资料表明 Zehnder 的 ComfoAir Q product family intl 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "连接品类"
- install_notes: null
- app_takeaway_zh: 选 KNX/LAN/App。
- training_snippet: 公开资料表明 Zehnder 的 ComfoAir Q product family intl 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS229 | AprilAire ventilation products
- id: SS229
- category: ventilation-erv
- brand: Aprilaire
- subsystem: Official ventilation products
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.aprilaire.com/healthy-air-products/ventilation
- source_name: AprilAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 官方新风产品线，经恒温器/中枢控制。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 通风产品品类。官方新风产品线，经恒温器/中枢控制。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：新风产品。来源为AprilAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Aprilaire / Official ventilation products」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Aprilaire 的 Official ventilation products 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "新风产品"
- install_notes: null
- app_takeaway_zh: 将「Aprilaire / Official ventilation products」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Aprilaire 的 Official ventilation products 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS230 | AprilAire dehumidifiers healthy air
- id: SS230
- category: ventilation-erv
- brand: Aprilaire
- subsystem: Dehumidifiers
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.aprilaire.com/healthy-air-products/dehumidifiers
- source_name: AprilAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 除湿与通风常一并进气候场景。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 除湿机品类。除湿与通风常一并进气候场景。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：除湿。来源为AprilAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Aprilaire / Dehumidifiers」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Aprilaire 的 Dehumidifiers 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "除湿"
- install_notes: null
- app_takeaway_zh: 将「Aprilaire / Dehumidifiers」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Aprilaire 的 Dehumidifiers 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS231 | AprilAire humidifiers
- id: SS231
- category: ventilation-erv
- brand: Aprilaire
- subsystem: Humidifiers
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.aprilaire.com/healthy-air-products/humidifiers
- source_name: AprilAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 加湿同样由恒温器/中枢统一。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 加湿器品类。加湿同样由恒温器/中枢统一。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：加湿。来源为AprilAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Aprilaire / Humidifiers」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Aprilaire 的 Humidifiers 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "加湿"
- install_notes: null
- app_takeaway_zh: 将「Aprilaire / Humidifiers」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Aprilaire 的 Humidifiers 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS232 | Panasonic ventilation fans hub
- id: SS232
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Whisper line hub
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://na.panasonic.com/us/home-and-building-solutions/ventilation-indoor-air-quality
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 排风/IAQ 解决方案中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 通风与 IAQ 业务页。排风/IAQ 解决方案中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：排风。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：局部排风+ERV 组合。公开资料表明 Panasonic Ventilation 的 Whisper line hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "排风"
- install_notes: null
- app_takeaway_zh: 局部排风+ERV 组合。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Whisper line hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS233 | RenewAire residential/light commercial ERVs
- id: SS233
- category: ventilation-erv
- brand: RenewAire
- subsystem: Residential ERVs
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/products
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 产品列表含住宅机型。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 产品中心。产品列表含住宅机型。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：产品列表。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：选 HE/EV 系列。公开资料表明 RenewAire 的 Residential ERVs 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "产品列表"
- install_notes: null
- app_takeaway_zh: 选 HE/EV 系列。
- training_snippet: 公开资料表明 RenewAire 的 Residential ERVs 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS234 | Zehnder UK indoor ventilation hub
- id: SS234
- category: ventilation-erv
- brand: Zehnder
- subsystem: UK home
- evidence_tier: E1
- region: UK
- source_url: https://www.zehnder.co.uk/en/indoor-ventilation
- source_name: Zehnder UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 英国室内通风中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: UK 产品与方案。英国室内通风中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：UK中心。来源为Zehnder UK（E1），地域标签 UK，抓取日 2026-10-21。应用提示：将「Zehnder / UK home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 UK home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "UK中心"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / UK home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 UK home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS235 | Broan fresh air systems
- id: SS235
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Fresh air systems category
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.broan-nutone.com/en-us/products/fresh-air-systems
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 新风系统品类（含 ERV/HRV）。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Fresh air 产品集合。新风系统品类（含 ERV/HRV）。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：新风品类。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / Fresh air systems category」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 Fresh air systems category 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "新风品类"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / Fresh air systems category」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 Fresh air systems category 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS236 | SpecifiedBy ComfoPost product host
- id: SS236
- category: ventilation-erv
- brand: Zehnder
- subsystem: SpecifiedBy Modena host
- evidence_tier: E2
- region: UK
- source_url: https://www.specifiedby.com/zehnder-group-uk-ltd/zehnder-comfopost-cw8
- source_name: SpecifiedBy
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ComfoPost 产品托管页，链向案例。
- summary_zh: 后冷产品规格入口。ComfoPost 产品托管页，链向案例。要点：ComfoPost。来源为SpecifiedBy（E2），地域标签 UK，抓取日 2026-10-21。应用提示：将「Zehnder / SpecifiedBy Modena host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 SpecifiedBy Modena host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "ComfoPost"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / SpecifiedBy Modena host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 SpecifiedBy Modena host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS237 | Broan support documents media root sample
- id: SS237
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Overture support path
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://broan-nutone.com/en-us/support
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 支持中心下载 C4 指南等。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 支持与文档入口。支持中心下载 C4 指南等。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：支持。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / Overture support path」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 Overture support path 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "支持"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / Overture support path」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 Overture support path 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS238 | Swidget support home
- id: SS238
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Swidget brand
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://support.swidget.com/hc/en-us
- source_name: Swidget
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: Swidget 支持中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 帮助中心首页。Swidget 支持中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：Swidget支持。来源为Swidget（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / Swidget brand」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 Swidget brand 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "Swidget支持"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / Swidget brand」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Swidget brand 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS239 | RenewAire parts and accessories
- id: SS239
- category: ventilation-erv
- brand: RenewAire
- subsystem: Parts accessories
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/parts-accessories
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 配件中心含 BACnet 控制。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 配件导航。配件中心含 BACnet 控制。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：配件。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：加购 BACnet 模块。公开资料表明 RenewAire 的 Parts accessories 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "配件"
- install_notes: null
- app_takeaway_zh: 加购 BACnet 模块。
- training_snippet: 公开资料表明 RenewAire 的 Parts accessories 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS240 | Construction Instruction Venmar resources
- id: SS240
- category: ventilation-erv
- brand: Venmar
- subsystem: Construction Instruction host
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://constructioninstruction.com
- source_name: Construction Instruction
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 施工教育站点承载 Venmar 册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 建筑教学资源站。施工教育站点承载 Venmar 册。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：施工教育。来源为Construction Instruction（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Venmar / Construction Instruction host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Venmar 的 Construction Instruction host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "施工教育"
- install_notes: null
- app_takeaway_zh: 将「Venmar / Construction Instruction host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Venmar 的 Construction Instruction host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS241 | Monolithic dome products interior
- id: SS241
- category: ventilation-erv
- brand: UltimateAir
- subsystem: Brand search monolithic host
- evidence_tier: E3
- region: NorthAmerica
- source_url: https://www.monolithic.org/products-interior
- source_name: Monolithic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 异形住宅产品目录含 RecoupAerator。
- summary_zh: 室内产品列表。异形住宅产品目录含 RecoupAerator。要点：异形宅。来源为Monolithic（E3），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / Brand search monolithic host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 UltimateAir 的 Brand search monolithic host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "异形宅"
- install_notes: null
- app_takeaway_zh: 将「UltimateAir / Brand search monolithic host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 Brand search monolithic host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS242 | Baulinks Zehnder topic area
- id: SS242
- category: ventilation-erv
- brand: Zehnder
- subsystem: ComfoAir Q600 case baulinks brand
- evidence_tier: E3
- region: Germany
- source_url: https://www.baulinks.de
- source_name: Baulinks
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 德语建筑媒体可检索更多 Zehnder 案例。
- summary_zh: Baulinks 首页。德语建筑媒体可检索更多 Zehnder 案例。要点：德语媒体。来源为Baulinks（E3），地域标签 Germany，抓取日 2026-10-21。应用提示：将「Zehnder / ComfoAir Q600 case baulinks brand」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 ComfoAir Q600 case baulinks brand 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "德语媒体"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / ComfoAir Q600 case baulinks brand」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 ComfoAir Q600 case baulinks brand 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS243 | EPA indoor air plus / ventilation guidance gateway
- id: SS243
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: Energy recovery basics EPA
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.epa.gov/indoor-air-quality-iaq/improving-indoor-air-quality
- source_name: EPA
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: IAQ 改善公共指南，支撑别墅新风必要性叙事。
- summary_zh: EPA 改善室内空气质量页。IAQ 改善公共指南，支撑别墅新风必要性叙事。要点：EPA；IAQ。来源为EPA（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / Energy recovery basics EPA」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 ERV/HRV generic villa 的 Energy recovery basics EPA 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "EPA"
  - "IAQ"
- install_notes: null
- app_takeaway_zh: 将「ERV/HRV generic villa / Energy recovery basics EPA」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 Energy recovery basics EPA 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS244 | ASHRAE residential resources hub
- id: SS244
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: ASHRAE residential
- evidence_tier: E1
- region: Global
- source_url: https://www.ashrae.org/technical-resources/bookstore/standard-62-1-62-2
- source_name: ASHRAE
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 62.2 住宅通风标准入口（书店/标准页）。
- summary_zh: 标准 62.1/62.2 资源。62.2 住宅通风标准入口（书店/标准页）。要点：ASHRAE 62.2。来源为ASHRAE（E1），地域标签 Global，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / ASHRAE residential」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 ERV/HRV generic villa 的 ASHRAE residential 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "ASHRAE 62.2"
- install_notes: null
- app_takeaway_zh: 将「ERV/HRV generic villa / ASHRAE residential」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 ASHRAE residential 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS245 | Builders Show press kits area
- id: SS245
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: IBS press kits root
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.buildersshow.com
- source_name: IBS
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 展会站点承载 Overture 事实页。
- summary_zh: IBS 官网。展会站点承载 Overture 事实页。要点：展会。来源为IBS（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / IBS press kits root」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 IBS press kits root 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "展会"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / IBS press kits root」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 IBS press kits root 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS246 | Zehnder Hungary resources host
- id: SS246
- category: ventilation-erv
- brand: Zehnder
- subsystem: HU datasheet host
- evidence_tier: E3
- region: Europe
- source_url: https://zehnder.hu
- source_name: Zehnder HU
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 匈语区资源站存 LAN C 数据表。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Zehnder 匈站。匈语区资源站存 LAN C 数据表。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：区域站。来源为Zehnder HU（E3），地域标签 Europe，抓取日 2026-10-21。应用提示：将「Zehnder / HU datasheet host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 HU datasheet host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "区域站"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / HU datasheet host」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 HU datasheet host 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS247 | ME NZ ventilation manuals hub
- id: SS247
- category: ventilation-erv
- brand: Mitsubishi Electric
- subsystem: NZ ventilation manuals
- evidence_tier: E1
- region: Oceania
- source_url: https://www.mitsubishi-electric.co.nz/ventilation
- source_name: Mitsubishi Electric NZ
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 新西兰站通风资料。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 通风产品与手册入口（若改版以检索为准）。新西兰站通风资料。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：NZ。来源为Mitsubishi Electric NZ（E1），地域标签 Oceania，抓取日 2026-10-21。应用提示：将「Mitsubishi Electric / NZ ventilation manuals」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Mitsubishi Electric 的 NZ ventilation manuals 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "NZ"
- install_notes: null
- app_takeaway_zh: 将「Mitsubishi Electric / NZ ventilation manuals」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Mitsubishi Electric 的 NZ ventilation manuals 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS248 | Verhees gallery home
- id: SS248
- category: ventilation-erv
- brand: Zehnder
- subsystem: NL integrator gallery
- evidence_tier: E3
- region: Netherlands
- source_url: https://www.verheesenvandijk.nl
- source_name: Verhees en van Dijk
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 荷兰集成商作品集入口。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 公司站点。荷兰集成商作品集入口。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：集成商。来源为Verhees en van Dijk（E3），地域标签 Netherlands，抓取日 2026-10-21。应用提示：将「Zehnder / NL integrator gallery」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 NL integrator gallery 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。
- key_points:
  - "集成商"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / NL integrator gallery」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 NL integrator gallery 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E3。

### SS249 | Panasonic ERV category
- id: SS249
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Intelli-Balance family
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://iaq.na.panasonic.com/erv
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ERV 品类页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Intelli-Balance 等 ERV 列表。ERV 品类页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：ERV品类。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / Intelli-Balance family」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 Intelli-Balance family 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "ERV品类"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / Intelli-Balance family」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Intelli-Balance family 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS250 | RenewAire literature downloads
- id: SS250
- category: ventilation-erv
- brand: RenewAire
- subsystem: Support docs
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/resources
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 资料下载中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 手册与折页资源。资料下载中心。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：资料中心。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / Support docs」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 Support docs 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "资料中心"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / Support docs」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 Support docs 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS251 | Zehnder America products
- id: SS251
- category: ventilation-erv
- brand: Zehnder
- subsystem: America products
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.zehnderamerica.com/products
- source_name: Zehnder America
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 北美产品目录。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 产品导航。北美产品目录。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：产品。来源为Zehnder America（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Zehnder / America products」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 America products 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "产品"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / America products」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 America products 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS252 | Broan indoor air quality topic
- id: SS252
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: IAQ sensors overture related
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.broan-nutone.com/en-us/indoor-air-quality
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: IAQ 主题页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 室内空气质量解决方案。IAQ 主题页。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：IAQ主题。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Broan-NuTone / IAQ sensors overture related」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Broan-NuTone 的 IAQ sensors overture related 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "IAQ主题"
- install_notes: null
- app_takeaway_zh: 将「Broan-NuTone / IAQ sensors overture related」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Broan-NuTone 的 IAQ sensors overture related 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS253 | Venmar AVS via Broan Canada path
- id: SS253
- category: ventilation-erv
- brand: Venmar
- subsystem: Canada brand path
- evidence_tier: E1
- region: Canada
- source_url: https://www.broan-nutone.com/en-ca
- source_name: Broan-NuTone CA
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 加拿大站含 Venmar 线。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 加站首页。加拿大站含 Venmar 线。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：加拿大。来源为Broan-NuTone CA（E1），地域标签 Canada，抓取日 2026-10-21。应用提示：将「Venmar / Canada brand path」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Venmar 的 Canada brand path 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "加拿大"
- install_notes: null
- app_takeaway_zh: 将「Venmar / Canada brand path」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Venmar 的 Canada brand path 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS254 | GreenBuildingAdvisor home
- id: SS254
- category: ventilation-erv
- brand: UltimateAir
- subsystem: GBA home
- evidence_tier: E2
- region: NorthAmerica
- source_url: https://www.greenbuildingadvisor.com
- source_name: GBA
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 高性能建筑社区，多 ERV 讨论。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: GBA 首页。高性能建筑社区，多 ERV 讨论。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：社区媒体。来源为GBA（E2），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「UltimateAir / GBA home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 UltimateAir 的 GBA home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。
- key_points:
  - "社区媒体"
- install_notes: null
- app_takeaway_zh: 将「UltimateAir / GBA home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 UltimateAir 的 GBA home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E2。

### SS255 | ENERGY STAR indoor air packages
- id: SS255
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: Energy Star ventilation
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.energystar.gov/products/indoor_air_package
- source_name: ENERGY STAR
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 能效与 IAQ 包装要求影响别墅通风设计。
- summary_zh: Indoor Air Package 页。能效与 IAQ 包装要求影响别墅通风设计。要点：ENERGY STAR。来源为ENERGY STAR（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / Energy Star ventilation」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 ERV/HRV generic villa 的 Energy Star ventilation 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "ENERGY STAR"
- install_notes: null
- app_takeaway_zh: 将「ERV/HRV generic villa / Energy Star ventilation」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 Energy Star ventilation 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS256 | ME UK document library
- id: SS256
- category: ventilation-erv
- brand: Mitsubishi Electric
- subsystem: UK library home
- evidence_tier: E1
- region: Europe
- source_url: https://library.mitsubishielectric.co.uk
- source_name: Mitsubishi Electric UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 英国文档库检索 Lossnay。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 资料库首页。英国文档库检索 Lossnay。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：资料库。来源为Mitsubishi Electric UK（E1），地域标签 Europe，抓取日 2026-10-21。应用提示：搜 Lossnay PDF。公开资料表明 Mitsubishi Electric 的 UK library home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "资料库"
- install_notes: null
- app_takeaway_zh: 搜 Lossnay PDF。
- training_snippet: 公开资料表明 Mitsubishi Electric 的 UK library home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS257 | AprilAire healthy air products
- id: SS257
- category: ventilation-erv
- brand: Aprilaire
- subsystem: Healthy air products hub
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.aprilaire.com/healthy-air-products
- source_name: AprilAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 健康空气产品总汇。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 产品总览。健康空气产品总汇。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：总汇。来源为AprilAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Aprilaire / Healthy air products hub」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Aprilaire 的 Healthy air products hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "总汇"
- install_notes: null
- app_takeaway_zh: 将「Aprilaire / Healthy air products hub」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Aprilaire 的 Healthy air products hub 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS258 | Broan kitchen ventilation hub
- id: SS258
- category: ventilation-erv
- brand: Broan-NuTone
- subsystem: Range hood IAQ link
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.broan-nutone.com/en-us/products/range-hoods
- source_name: Broan-NuTone
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 厨房排风可与 Overture/中枢联动。
- summary_zh: 烟机品类。厨房排风可与 Overture/中枢联动。要点：厨房排风。来源为Broan-NuTone（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：烹饪时加强排风场景。公开资料表明 Broan-NuTone 的 Range hood IAQ link 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "厨房排风"
- install_notes: null
- app_takeaway_zh: 烹饪时加强排风场景。
- training_snippet: 公开资料表明 Broan-NuTone 的 Range hood IAQ link 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS259 | Panasonic spot ERVs / fans crossover
- id: SS259
- category: ventilation-erv
- brand: Panasonic Ventilation
- subsystem: Spot ERV
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://iaq.na.panasonic.com/fans
- source_name: Panasonic
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 局部风扇与全宅 ERV 组合。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 风扇产品。局部风扇与全宅 ERV 组合。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：局部通风。来源为Panasonic（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「Panasonic Ventilation / Spot ERV」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Panasonic Ventilation 的 Spot ERV 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "局部通风"
- install_notes: null
- app_takeaway_zh: 将「Panasonic Ventilation / Spot ERV」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Panasonic Ventilation 的 Spot ERV 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS260 | RenewAire how ERVs work / about
- id: SS260
- category: ventilation-erv
- brand: RenewAire
- subsystem: About ERV tech
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://renewaire.com/about-erv
- source_name: RenewAire
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: ERV 原理页，客户教育。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 关于 ERV。ERV 原理页，客户教育。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：原理。来源为RenewAire（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「RenewAire / About ERV tech」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 RenewAire 的 About ERV tech 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "原理"
- install_notes: null
- app_takeaway_zh: 将「RenewAire / About ERV tech」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 RenewAire 的 About ERV tech 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS261 | Zehnder UK controls sensors connectivity hub
- id: SS261
- category: ventilation-erv
- brand: Zehnder
- subsystem: UK controls sensors
- evidence_tier: E1
- region: UK
- source_url: https://www.zehnder.co.uk/en/indoor-ventilation/solutions/controls-sensors-connectivity
- source_name: Zehnder UK
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 控制/传感器/连接集合。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: UK connectivity hub。控制/传感器/连接集合。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：传感器。来源为Zehnder UK（E1），地域标签 UK，抓取日 2026-10-21。应用提示：将「Zehnder / UK controls sensors」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Zehnder 的 UK controls sensors 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "传感器"
- install_notes: null
- app_takeaway_zh: 将「Zehnder / UK controls sensors」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Zehnder 的 UK controls sensors 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS262 | WHO household air pollution / IAQ gateway
- id: SS262
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: WHO IAQ
- evidence_tier: E1
- region: Global
- source_url: https://www.who.int/health-topics/air-pollution
- source_name: WHO
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 公共健康视角支撑新风必要性。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: 空气污染健康主题。公共健康视角支撑新风必要性。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：WHO。来源为WHO（E1），地域标签 Global，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / WHO IAQ」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 ERV/HRV generic villa 的 WHO IAQ 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "WHO"
- install_notes: null
- app_takeaway_zh: 将「ERV/HRV generic villa / WHO IAQ」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 WHO IAQ 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS263 | Control4 product documentation home
- id: SS263
- category: ventilation-erv
- brand: Control4
- subsystem: Docs home
- evidence_tier: E1
- region: Global
- source_url: https://docs.control4.com
- source_name: Control4
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: ["Control4"]
- control_layer_fit: 文档站可检索恒温器/通风相关。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: C4 文档首页。文档站可检索恒温器/通风相关。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：文档站。来源为Control4（E1），地域标签 Global，抓取日 2026-10-21。应用提示：将「Control4 / Docs home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 Control4 的 Docs home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "文档站"
- install_notes: null
- app_takeaway_zh: 将「Control4 / Docs home」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 Control4 的 Docs home 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。

### SS264 | DOE Building America ventilation resources
- id: SS264
- category: ventilation-erv
- brand: ERV/HRV generic villa
- subsystem: DOE Building America
- evidence_tier: E1
- region: NorthAmerica
- source_url: https://www.energy.gov/eere/buildings/building-america-solution-center
- source_name: DOE
- published: unknown
- fetched_on: 2026-10-21
- mentions_legacy_brands: []
- control_layer_fit: 美国建筑能效解决方案中心含通风实践。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。
- summary_zh: Building America Solution Center。美国建筑能效解决方案中心含通风实践。 别墅有线中枢（Control4/Crestron/Savant/Lutron）适合作为统一 UI/场景层，经 BACnet、厂商网关、串口/云驱动或 KNX 桥接本子系统。要点：DOE；实践。来源为DOE（E1），地域标签 NorthAmerica，抓取日 2026-10-21。应用提示：将「ERV/HRV generic villa / DOE Building America」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。公开资料表明 ERV/HRV generic villa 的 DOE Building America 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
- key_points:
  - "DOE"
  - "实践"
- install_notes: null
- app_takeaway_zh: 将「ERV/HRV generic villa / DOE Building America」作为气候或新风子系统写入方案库，控制层优先评估开放协议或官方驱动。
- training_snippet: 公开资料表明 ERV/HRV generic villa 的 DOE Building America 可通过网关或开放协议纳入别墅有线控制中枢；证据层级 E1。
