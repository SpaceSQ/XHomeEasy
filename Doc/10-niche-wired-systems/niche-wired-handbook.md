# XHomeEasy Phase E1 — 北美小众/老牌有线系统手册

- 生成时间：2026-10-24T07:54:20+08:00（Asia/Shanghai）
- 总条数：**125**（目标 ≥120）
- ID 范围：`NW001` … `NW125`
- Corpus SHA256：`7858148567c4df53c6eafab0100df1e7cf429a0a0397d282ff0c56893e61b1f7`

## 产品触发场景
当业主/工程师在对话框输入 X-10、HAI、UPB、LiteTouch、Vantage、ADT、SPAN、UniFi PoE 等词时，调出本语料 9 大指标，并给出保留/桥接/替换至 Control4、Crestron、Savant、Lutron 的建议。

## 板块统计
| Section | Count | 主题 |
|---|---:|---|
| `01-legacy-plc-bus` | 38 | 历史 PLC / 经典有线总线与 CEDIA 控制 |
| `02-security-managed-platforms` | 30 | 安防与智能运营平台 |
| `03-hems-smart-panels` | 25 | HEMS / 智能配电 / 光储充 |
| `04-poe-ecommerce-hybrid` | 32 | PoE / 电商混合有线系统 |

## 继承豪宅（Inherited Luxury）决策要点
1. **先认主机与线缆资产**：VISTA/Elk 硬线防区、LiteTouch/GE RR 低压灯光线、结构化媒体箱星型铜缆，往往比“智能品牌”更值钱。
2. **PLC（X10/UPB/Insteon）**：短期可共存，长期不建议作豪宅主控；迁移 Lutron/C4 灯光。
3. **LiteTouch 停产**：优先 Touch-Plate / Lutron / Savant 路径复用低压线，禁止与旧面板混用。
4. **安防**：开放底座推 Elk M1 或保留硬线 + Konnected/EnvisaLink；运营层 ADC/ADT 与四巨头划界。
5. **HEMS**：SPAN/Lumin/Leviton/Eaton/ABB 管电；四巨头管场景体验；持证电工红线。
6. **UniFi/Sonos Amp**：作网络视频音频层并存，不替代 HomeWorks/Crestron 灯光中枢。

## 分节摘要表
### 01-legacy-plc-bus

| ID | Brand / Protocol | Status | Tier |
|---|---|---|---|
| NW001 | X10 (X-10 Powerline Carrier / 电力载波) | LEGACY_MAINTENANCE | E2 |
| NW002 | UPB (Universal Powerline Bus) | LEGACY_MAINTENANCE | E2 |
| NW003 | Simply Automated (UPB Modules) | LEGACY_MAINTENANCE | E3 |
| NW004 | Insteon (Dual-Band Powerline + RF Mesh) | ACTIVE_NICHE | E1 |
| NW005 | Leviton HAI OmniPro II / Omni Controllers | LEGACY_MAINTENANCE | E2 |
| NW006 | Leviton GreenMAX DRC (Wired Lighting Control) | ACTIVE_NICHE | E2 |
| NW007 | Leviton Structured Media Center (SMC / 结构化布线箱) | ACTIVE_MAIN | E1 |
| NW008 | LiteTouch (LiteTouch 2000 / 5000LC) | DISCONTINUED | E2 |
| NW009 | Vantage Controls InFusion (Legrand) | ACTIVE_NICHE | E2 |
| NW010 | Centralite LiteJet (Centralized Wired Dimming) | LEGACY_MAINTENANCE | E3 |
| NW011 | Centralite Elegance / Illuminations | LEGACY_MAINTENANCE | E3 |
| NW012 | Touch-Plate (Ultra / Genesis Low-Voltage Lighting) | ACTIVE_NICHE | E2 |
| NW013 | GE RR7 / RR9 Low-Voltage Relay Lighting | LEGACY_MAINTENANCE | E3 |
| NW014 | RTI (Remote Technologies Inc. / AVPro) | ACTIVE_NICHE | E2 |
| NW015 | ELAN Home Systems (Nice North America) | ACTIVE_NICHE | E2 |
| NW016 | URC Total Control (MRX Processors) | ACTIVE_NICHE | E2 |
| NW017 | AMX (Harman / Samsung) NetLinx / Muse | ACTIVE_NICHE | E2 |
| NW018 | Loxone Miniserver / Tree Bus (North America) | ACTIVE_NICHE | E2 |
| NW019 | Schneider Electric / Clipsal C-Bus | ACTIVE_NICHE | E2 |
| NW020 | Schneider Electric Square D (Residential Power / Wiser Context) | ACTIVE_MAIN | E1 |
| NW021 | Philips Dynalite (Signify) | ACTIVE_NICHE | E2 |
| NW022 | Crestron Pyng (Historical Residential Platform) | LEGACY_MAINTENANCE | E3 |
| NW023 | Bang & Olufsen Beolink / Master Link Ecosystem | ACTIVE_NICHE | E2 |
| NW024 | Josh.ai (Josh Core PoE Voice Hub) | ACTIVE_NICHE | E2 |
| NW025 | Legrand On-Q Structured Wiring | ACTIVE_MAIN | E1 |
| NW026 | NuVo (Legacy Multiroom Wired Audio) | LEGACY_MAINTENANCE | E3 |
| NW027 | Niles Audio (Legacy Multiroom / IR) | LEGACY_MAINTENANCE | E3 |
| NW028 | SpeakerCraft (Architectural Speakers / Legacy Control) | ACTIVE_NICHE | E3 |
| NW029 | PCS PulseWorx (UPB Branding) | LEGACY_MAINTENANCE | E3 |
| NW030 | BitWise Controls (BC Controllers) | ACTIVE_NICHE | E3 |
| NW031 | Clare Controls (Legacy Smart Home OS) | LEGACY_MAINTENANCE | E4 |
| NW032 | Autonomic Controls (Mirage Audio Servers) | ACTIVE_NICHE | E2 |
| NW033 | Pro Control (URC Sister / Controllers) | ACTIVE_NICHE | E3 |
| NW034 | Key Digital Compass Control | ACTIVE_NICHE | E3 |
| NW035 | Lutron GRAFIK Eye / LP (Legacy Wired Preset) | ACTIVE_NICHE | E2 |
| NW036 | Lightolier Controls / by Signify (Legacy Architectural) | LEGACY_MAINTENANCE | E4 |
| NW037 | Wattstopper / Legrand Lighting Controls (Commercial Wired) | ACTIVE_NICHE | E2 |
| NW038 | ESI / iLight / Cooper Wired Lighting (Legacy Names) | LEGACY_MAINTENANCE | E4 |

### 02-security-managed-platforms

| ID | Brand / Protocol | Status | Tier |
|---|---|---|---|
| NW039 | Alarm.com (Managed Security & Automation Platform) | ACTIVE_MAIN | E1 |
| NW040 | ADT (Command / Professional Monitoring) | ACTIVE_MAIN | E2 |
| NW041 | Vivint Smart Home | ACTIVE_MAIN | E3 |
| NW042 | Resideo Honeywell Home VISTA-20P | ACTIVE_NICHE | E1 |
| NW043 | Resideo VISTA-128BPT / High-Zone VISTA | ACTIVE_NICHE | E2 |
| NW044 | Resideo V-Plex (Two-Wire Polling Loop) | ACTIVE_NICHE | E3 |
| NW045 | Resideo ProSeries (ProHub / Modern Platform) | ACTIVE_MAIN | E2 |
| NW046 | Elk Products M1 Gold | ACTIVE_NICHE | E1 |
| NW047 | Elk M1 Cross / Automation Expansions | ACTIVE_NICHE | E2 |
| NW048 | DMP XR150 | ACTIVE_MAIN | E2 |
| NW049 | DMP XR550 | ACTIVE_MAIN | E2 |
| NW050 | DSC PowerSeries Neo | ACTIVE_MAIN | E2 |
| NW051 | DSC / Qolsys IQ Panel Line (Dealer Panels) | ACTIVE_MAIN | E2 |
| NW052 | Bosch Security B Series | ACTIVE_MAIN | E2 |
| NW053 | Bosch G Series Panels | ACTIVE_MAIN | E3 |
| NW054 | Napco Security Gemini | ACTIVE_NICHE | E3 |
| NW055 | Brinks Home | ACTIVE_MAIN | E3 |
| NW056 | Guardian Protection | ACTIVE_MAIN | E3 |
| NW057 | Konnected Alarm Panel Interface (PoE / Wired Retrofit) | ACTIVE_NICHE | E1 |
| NW058 | EnvisaLink EVL-4 (EyezOn) | ACTIVE_NICHE | E1 |
| NW059 | EyezOn UNO IP Panel | ACTIVE_NICHE | E2 |
| NW060 | 2GIG (Nice / Nortek Heritage Panels) | ACTIVE_MAIN | E2 |
| NW061 | Alula (Security Communicators / Platform) | ACTIVE_NICHE | E3 |
| NW062 | Telguard / Telular Cellular Communicators | ACTIVE_NICHE | E2 |
| NW063 | Interlogix / GE Security (Legacy Panels) | LEGACY_MAINTENANCE | E3 |
| NW064 | Resolution Products / Alarm.com Partner Sensors | ACTIVE_NICHE | E3 |
| NW065 | Frontpoint Security | ACTIVE_MAIN | E3 |
| NW066 | Qolsys IQ Pro / Wired Expansion Context | ACTIVE_MAIN | E2 |
| NW067 | Sur-Gard / Receiver Side (Monitoring Infrastructure) | ACTIVE_MAIN | E3 |
| NW068 | Honeywell Total Connect (Legacy Branding) | ACTIVE_NICHE | E3 |

### 03-hems-smart-panels

| ID | Brand / Protocol | Status | Tier |
|---|---|---|---|
| NW069 | SPAN Smart Electrical Panel | ACTIVE_MAIN | E2 |
| NW070 | SPAN Drive (EV Charger Integration) | ACTIVE_MAIN | E3 |
| NW071 | Lumin Smart Panel (Retrofit Load Management) | ACTIVE_MAIN | E2 |
| NW072 | Schneider Electric Square D Energy Center / Pulse | ACTIVE_MAIN | E2 |
| NW073 | Schneider Wiser Energy Monitoring | ACTIVE_MAIN | E3 |
| NW074 | Leviton Second-Generation Smart Load Center | ACTIVE_MAIN | E2 |
| NW075 | Eaton AbleEdge Home Energy Management | ACTIVE_MAIN | E2 |
| NW076 | Eaton Brightlayer / Residential Smart Breaker Context | ACTIVE_MAIN | E3 |
| NW077 | ABB ReliaHome Smart Panel | ACTIVE_MAIN | E2 |
| NW078 | Tesla Powerwall 3 + Gateway | ACTIVE_MAIN | E2 |
| NW079 | Tesla Wall Connector | ACTIVE_MAIN | E1 |
| NW080 | Enphase IQ Combiner / IQ System Controller | ACTIVE_MAIN | E2 |
| NW081 | Enphase IQ Battery | ACTIVE_MAIN | E2 |
| NW082 | Generac PWRcell / PWRview | ACTIVE_MAIN | E3 |
| NW083 | Generac Guardian / Automatic Transfer Switch (ATS) | ACTIVE_MAIN | E1 |
| NW084 | Kohler Residential Generators / OnCue | ACTIVE_MAIN | E2 |
| NW085 | SolarEdge Home Hub / Energy Bank | ACTIVE_MAIN | E2 |
| NW086 | FranklinWH Energy System | ACTIVE_NICHE | E3 |
| NW087 | Savant Power System (Smart Breakers) | ACTIVE_MAIN | E2 |
| NW088 | Emporia Vue Energy Monitor | ACTIVE_MAIN | E1 |
| NW089 | Sense Energy Monitor | ACTIVE_MAIN | E2 |
| NW090 | Sol-Ark Hybrid Inverter | ACTIVE_NICHE | E3 |
| NW091 | Sonnen Home Battery | ACTIVE_NICHE | E3 |
| NW092 | Fortress Power Battery Systems | ACTIVE_NICHE | E3 |
| NW093 | MidNite Solar / Energy Equipment | ACTIVE_NICHE | E3 |

### 04-poe-ecommerce-hybrid

| ID | Brand / Protocol | Status | Tier |
|---|---|---|---|
| NW094 | Ubiquiti UniFi Protect (PoE Cameras / NVR) | ACTIVE_MAIN | E1 |
| NW095 | Ubiquiti UniFi Access (PoE Access Control) | ACTIVE_MAIN | E2 |
| NW096 | Ubiquiti UniFi Connect (PoE Displays / Lighting IoT) | ACTIVE_NICHE | E3 |
| NW097 | Ubiquiti UniFi Play / PowerAmp | ACTIVE_NICHE | E2 |
| NW098 | UniFi Dream Machine / Console (Network Brain) | ACTIVE_MAIN | E1 |
| NW099 | Ring Video Doorbell Elite (PoE) | ACTIVE_MAIN | E2 |
| NW100 | Ring Alarm Pro | ACTIVE_MAIN | E2 |
| NW101 | Ring Retrofit Alarm Kit | ACTIVE_NICHE | E3 |
| NW102 | Reolink PoE NVR Camera Systems | ACTIVE_MAIN | E1 |
| NW103 | Lorex PoE Wired Surveillance | ACTIVE_MAIN | E2 |
| NW104 | Amcrest PoE Cameras | ACTIVE_MAIN | E2 |
| NW105 | Sonos Amp (Wired Multiroom Amplifier) | ACTIVE_MAIN | E1 |
| NW106 | Russound MBX / MCA Multiroom | ACTIVE_NICHE | E2 |
| NW107 | AudioControl Director Series | ACTIVE_NICHE | E3 |
| NW108 | Monoprice 6-Zone Home Audio Multizone Controller | ACTIVE_NICHE | E2 |
| NW109 | HTD Lync / MCA Whole-Home Audio | ACTIVE_NICHE | E3 |
| NW110 | Dayton Audio DAX88 | ACTIVE_NICHE | E2 |
| NW111 | Shelly Pro 4PM (DIN Rail Ethernet) | ACTIVE_MAIN | E1 |
| NW112 | Shelly Pro Dimmer / Pro Dual Cover | ACTIVE_MAIN | E2 |
| NW113 | Brilliant Smart Home Control (In-Wall Hub Panel) | LEGACY_MAINTENANCE | E3 |
| NW114 | Aqara Camera Hub G5 Pro (PoE Option Context) | ACTIVE_MAIN | E3 |
| NW115 | Instar PoE Network Cameras | ACTIVE_NICHE | E3 |
| NW116 | Axis Communications Network Cameras | ACTIVE_MAIN | E1 |
| NW117 | Hanwha Vision / Wisenet PoE | ACTIVE_MAIN | E2 |
| NW118 | Synology Surveillance Station (NAS NVR Stack) | ACTIVE_MAIN | E1 |
| NW119 | Blue Iris NVR Software | ACTIVE_NICHE | E2 |
| NW120 | ControlByWeb Relays (Ethernet I/O) | ACTIVE_NICHE | E2 |
| NW121 | Pakedge / Control4 Networking Heritage | LEGACY_MAINTENANCE | E3 |
| NW122 | Luxul Network Equipment (AV Installer) | ACTIVE_NICHE | E2 |
| NW123 | Netgear Orbi / Insight Pro Networking (PoE Switches) | ACTIVE_MAIN | E2 |
| NW124 | Verkada (Cloud Enterprise Cameras) | ACTIVE_MAIN | E2 |
| NW125 | Binary / SnapAV HDBaseT & PoE Extenders | ACTIVE_NICHE | E3 |

## 安全与行动权
- 只读公开源；无登录、无付费墙绕过。
- 不收录市电 DIY 接线步骤；配电/发电机/储能仅拓扑与持证电工分工。

