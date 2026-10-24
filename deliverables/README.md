# X Home Easy · 开发交付包（2026-10-21）

## 如何使用

1. **先读** `00-交底书-开发部门.md`（详细内容、数量、字段与接入方法）。
2. 需求与事实边界：`01-PRD/`（docx / txt + 市场核实表）。
3. 知识图库与语料：`02-Doc/`（完整 Doc 树；训练优先 `*.jsonl` 与渠道 `*.csv`）。
4. 姊妹产品附录（非本仓核心）：`03-suite-related/`。
5. 校验：`04-CHECKSUMS.sha256`（在本目录执行 `sha256sum -c 04-CHECKSUMS.sha256`）。

## 解压

若持有 `XHomeEasy-DevHandoff-2026-10-21.tar.gz`：

```bash
tar -xzf XHomeEasy-DevHandoff-2026-10-21.tar.gz
cd XHomeEasy-DevHandoff-2026-10-21
```

## 关键数量（收集截止 2026-10-21 Asia/Shanghai）

| 项 | 数量 |
|---|---|
| 融合趋势 corpus | 194 |
| 子系统 corpus | 564（独立 URL 557） |
| 渠道 master CSV | 1132 商户行 |
| 阶段 B 案例摘要 | 30 |
| Doc 文件数 | 约 238（含 99-raw） |

收集方：千里眼 · 只读公开源。
