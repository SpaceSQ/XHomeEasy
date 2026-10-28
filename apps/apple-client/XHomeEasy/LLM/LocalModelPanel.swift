import SwiftUI

struct LocalModelSettings: View {
    var chinese: Bool
    @State private var llm = LocalLLMController.shared
    @State private var customDraft = ""

    var body: some View {
        let state = llm.viewState
        StudioCard {
            Text(tx("本机模型", "On-device model")).font(.headline)
            Text(state.share.message(in: chinese ? .zh : .en))
                .font(.subheadline)
                .foregroundStyle(Studio.ink)
                .fixedSize(horizontal: false, vertical: true)
            Toggle(tx("允许外部 App 共享本机模型", "Allow external apps to share local AI models"), isOn: Binding(
                get: { state.allowExternalSharing },
                set: { llm.setAllowExternalSharing($0) }
            ))
            .disabled(state.scanCompleted && !state.channelAvailable)
            Text(tx("22 个生态 App 可以共用已经下载的模型。其他 App 默认关闭，直到打开这个开关。", "The 22 ecosystem apps may use a model any of them has already downloaded. Other apps stay refused until this is on."))
                .font(.caption)
                .foregroundStyle(Studio.mist)
            if state.rows.isEmpty {
                Text(tx("这台 iPhone 的内存不够运行本机模型。固定问诊仍然可用。", "This iPhone does not have enough memory for an on-device model. The fixed questions still work."))
                    .font(.subheadline)
            }
            ForEach(state.rows) { row in
                modelRow(row, state: state)
            }
            Text(tx("来源", "Source")).font(.subheadline.weight(.semibold))
            mirrorPicker(state)
            if state.mirror == .automatic || state.mirror == .custom {
                TextField(tx("自定义基址", "Custom base URL"), text: $customDraft)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onSubmit { llm.setCustomBase(customDraft) }
            }
            Toggle(tx("允许用蜂窝网络下载", "Allow cellular download"), isOn: Binding(
                get: { state.allowsCellular },
                set: { llm.setAllowsCellular($0) }
            ))
        }
        .task {
            customDraft = llm.customBase
            await llm.monitor()
        }
        .onChange(of: llm.viewState.customBase) { _, value in
            if customDraft != value { customDraft = value }
        }
    }

    @ViewBuilder
    private func modelRow(_ row: LocalModelRow, state: LocalModelViewState) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Button {
                llm.select(specID: row.id)
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Text((state.selectedSpecID == row.id ? "● " : "○ ") + row.displayName)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Studio.ink)
                    Text("\(row.sizeLabel) · \(row.license)")
                        .font(.caption)
                        .foregroundStyle(Studio.mist)
                }
            }
            .buttonStyle(.plain)
            if row.available, !state.runtimeAvailable {
                Text(tx("权重已经在这台 iPhone 上，但这个构建还没有链上 llama.cpp。见 apple-client/AGENTS.md。", "The weights are on this iPhone, but this build does not include llama.cpp yet. See AGENTS.md in the apple-client folder."))
                    .font(.caption)
                    .foregroundStyle(Studio.clay)
            }
            if let shared = sharedLine(row) {
                Text(shared).font(.caption).foregroundStyle(Studio.forest)
            } else if row.installed || row.available {
                Text(tx("已校验，可以使用", "Checked and ready")).font(.caption).foregroundStyle(Studio.forest)
                Button(tx("移除模型", "Remove model")) { llm.delete(specID: row.id) }
                    .buttonStyle(.bordered)
            } else {
                downloadControls(row)
            }
        }
        .padding(.vertical, 4)
    }

    private func sharedLine(_ row: LocalModelRow) -> String? {
        guard !row.installed, row.available, row.decision == "green" || row.decision == "external" else { return nil }
        let name = row.publisherName ?? ""
        return tx("由 \(name) 共享", "Shared by \(name)")
    }

    @ViewBuilder
    private func downloadControls(_ row: LocalModelRow) -> some View {
        if row.phase == "downloading" {
            Text(tx("\(Int(row.progress * 100))% · \(format(row.receivedBytes)) / \(row.sizeLabel)", "\(Int(row.progress * 100))% · \(format(row.receivedBytes)) / \(row.sizeLabel)"))
                .font(.caption.monospacedDigit())
        } else if row.phase == "verifying" {
            Text(tx("正在校验…", "Checking…")).font(.caption)
        }
        if row.phase == "failed" {
            Text(errorText(row.errorCode)).font(.caption).foregroundStyle(Studio.clay)
        }
        HStack {
            if row.phase == "downloading" {
                Button(tx("暂停", "Pause")) { llm.pauseDownload() }.buttonStyle(.bordered)
                Button(tx("取消", "Cancel")) { llm.cancelDownload() }.buttonStyle(.bordered)
            } else if row.phase == "paused" || row.phase == "failed" || row.phase == "idle" {
                Button(downloadTitle(row)) { llm.startDownload(specID: row.id) }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
                if row.phase == "paused" {
                    Button(tx("取消", "Cancel")) { llm.cancelDownload() }.buttonStyle(.bordered)
                }
            }
        }
    }

    private func downloadTitle(_ row: LocalModelRow) -> String {
        switch row.phase {
        case "paused": return tx("继续", "Resume")
        case "failed": return tx("重试", "Try again")
        default: return tx("下载（\(row.sizeLabel)）", "Download (\(row.sizeLabel))")
        }
    }

    private func errorText(_ code: String?) -> String {
        switch code {
        case "checksum": return tx("文件没有通过 SHA-256 校验，已删除。", "The file failed the SHA-256 check and was removed.")
        case "incomplete": return tx("下载不完整。", "The download was incomplete.")
        case "no_mirror": return tx("没有可用的下载源。", "No download source could be reached.")
        case "http": return tx("服务器拒绝了下载。可以换一个来源。", "The server refused the download. Another source may help.")
        case "interrupted": return tx("下载中断了。继续会从上次的位置接着下。", "The download stopped. Resume continues from the last point.")
        default: return tx("下载失败。", "The download failed.")
        }
    }

    private func mirrorPicker(_ state: LocalModelViewState) -> some View {
        let choices: [(ModelMirror, String)] = [
            (.automatic, tx("自动", "Automatic")),
            (.huggingFace, "Hugging Face"),
            (.hfMirror, "hf-mirror.com"),
            (.custom, tx("自定义地址", "Custom URL"))
        ]
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(choices, id: \.0) { choice, title in
                    Button(title) { llm.setMirror(choice) }
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(state.mirror == choice ? Studio.ink : Studio.paper)
                        .foregroundStyle(state.mirror == choice ? Studio.paper : Studio.ink)
                        .clipShape(Capsule())
                }
            }
        }
    }

    private func format(_ bytes: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: bytes, countStyle: .file)
    }

    private func tx(_ zh: String, _ en: String) -> String { chinese ? zh : en }
}

struct LocalModelOffer: View {
    var chinese: Bool
    @State private var llm = LocalLLMController.shared

    var body: some View {
        let state = llm.viewState
        if llm.offerDismissed || state.rows.isEmpty && state.scanCompleted {
            EmptyView()
        } else if state.modelReady {
            readyCard(state)
        } else if let row = state.selectedRow {
            offerCard(row, state: state)
        }
    }

    @ViewBuilder
    private func readyCard(_ state: LocalModelViewState) -> some View {
        switch state.share {
        case .detecting, .channelUnavailable:
            EmptyView()
        case .hostedOnThisIPhone, .greenChannel, .external:
            StudioCard {
                Text(state.share.message(in: chinese ? .zh : .en))
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                Button(tx("先不看", "Not now")) { llm.dismissOffer() }
                    .buttonStyle(.bordered)
            }
        }
    }

    private func offerCard(_ row: LocalModelRow, state: LocalModelViewState) -> some View {
        let shared = row.available && (row.decision == "green" || row.decision == "external" || row.decision == "own")
        return StudioCard {
            Text(shared ? tx("这台 iPhone 上已经有共享模型", "A shared model is already on this iPhone") : tx("把较长的描述读得更准", "Read longer descriptions more precisely"))
                .font(.headline)
            Text(offerBody(row, shared: shared, state: state))
                .font(.subheadline)
                .foregroundStyle(Studio.ink)
                .fixedSize(horizontal: false, vertical: true)
            Text(statusLine(state))
                .font(.caption)
                .foregroundStyle(Studio.mist)
                .fixedSize(horizontal: false, vertical: true)
            if !shared {
                Text(tx("下载只在你点了之后开始。文件会做 SHA-256 校验，并且不进 iCloud 备份。路径分数和价格带宽仍由固定计算给出。", "It downloads only when you ask, is checked with SHA-256, and is kept out of iCloud backup. Path scores and price bands still come from the fixed calculator."))
                    .font(.caption)
                    .foregroundStyle(Studio.mist)
            }
            HStack {
                if shared {
                    Button(tx("使用共享模型", "Use the shared model")) { llm.select(specID: row.id) }
                        .buttonStyle(.borderedProminent)
                        .tint(Studio.ink)
                } else if row.phase == "downloading" || row.phase == "verifying" {
                    Text(row.phase == "verifying" ? tx("正在校验…", "Checking…") : "\(Int(row.progress * 100))%")
                        .font(.caption.monospacedDigit())
                    Button(tx("暂停", "Pause")) { llm.pauseDownload() }.buttonStyle(.bordered)
                } else {
                    Button(row.phase == "paused" ? tx("继续", "Resume") : tx("下载（\(row.sizeLabel)）", "Download (\(row.sizeLabel))")) {
                        llm.startDownload(specID: row.id)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
                }
                Button(tx("先不看", "Not now")) { llm.dismissOffer() }
                    .buttonStyle(.bordered)
            }
        }
        .task { await llm.monitor() }
    }

    private func offerBody(_ row: LocalModelRow, shared: Bool, state: LocalModelViewState) -> String {
        if row.available, !state.runtimeAvailable {
            return tx("权重已经在这台 iPhone 上，但这个构建还没有链上 llama.cpp。见 apple-client/AGENTS.md。", "The weights are on this iPhone, but this build does not include llama.cpp yet. See AGENTS.md in the apple-client folder.")
        }
        if shared {
            let name = row.publisherName ?? state.share.publisherName ?? "X Home Easy"
            return tx("可以直接读取 \(name) 的模型，不必再下一份。", "This app can read the model from \(name). Nothing else needs to be downloaded.")
        }
        return tx("一个约 \(row.sizeLabel) 的私有模型留在这台 iPhone 上，用来把长对话读成设计字段。", "A private model (\(row.sizeLabel)) stays on this iPhone and reads a long conversation into design fields.")
    }

    private func statusLine(_ state: LocalModelViewState) -> String {
        switch state.share {
        case .detecting:
            return tx("正在生态里查找共享模型…", "Looking for a shared ecosystem model…")
        case .channelUnavailable:
            return tx("这台安装没有共享通道。模型会留在本 App 里。", "Local AI model sharing is unavailable on this install. The model stays inside this app.")
        case .hostedOnThisIPhone, .greenChannel, .external:
            return state.share.message(in: chinese ? .zh : .en)
        }
    }

    private func tx(_ zh: String, _ en: String) -> String { chinese ? zh : en }
}

private extension EcosystemShareStatus {
    var publisherName: String? {
        switch self {
        case .hostedOnThisIPhone(let name), .greenChannel(let name), .external(let name):
            return name
        case .detecting, .channelUnavailable:
            return nil
        }
    }
}
