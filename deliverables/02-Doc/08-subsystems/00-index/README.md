# 08-subsystems · 别墅子系统方案库

收集窗口：2026-10-21 起  
用途：X Home Easy 融合/整案建议与本地大模型训练素材。  
前提：Control4 / Crestron / Savant / Lutron 常作整宅控制层；本库收录**与之高度配合或典型联动**的子系统方案、案例、部署与使用经验。  
**即使正文未点名四老牌**，只要从集成实施角度属于别墅有线控制常见子系统，也应收录，并在 `control_layer_fit` 标注为何适合由四老牌作控制中枢。

## 目录
- `hvac/` 中央空调 / VRF / 多联机
- `ventilation-erv/` 新风 / ERV / HRV / 净化加湿
- `luxury-av/` 豪华影音 / 私人影院 / 分布式音频
- `security/` 安防运营与报警平台
- `shades-climate-aux/` 遮阳、泳池水疗、温控辅件等其它联动子系统
- `99-raw/` 抓取缓存

## 条目字段（统一）
id, category, brand, subsystem, title, source_url, source_name, evidence_tier (E1厂商/E2行业媒体/E3集成商案例/E4社区), region, published, fetched_on, mentions_legacy_brands[], control_layer_fit, summary_zh, key_points[], install_notes, app_takeaway_zh, training_snippet

## 数量目标
数十品牌 × 约 20 篇/品牌 ≈ **≥500** 条独立公开 URL。

## 本路进度（千里眼 · 2026-10-21）
- security/: **103** 条（SS451-SS553）
- shades-climate-aux/: **74** 条（SS561-SS634）
- 本路合计: **177**


## 收集进度（2026-10-21 Asia/Shanghai）
- **总条目**：564（目标 ≥500：已达标）
- **独立 URL**：557
- **品类**：HVAC 140 · 新风 84 · 豪华影音 163 · 安防 103 · 遮阳/泳池辅机 74
- **品牌数**：60
- 总清单：`00-index/master.corpus.jsonl` · `00-index/master-manifest.json`
