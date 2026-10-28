import Foundation

/// A downloadable on-device model. Weights never ship inside the app binary.
struct LocalModelSpec: Sendable, Equatable, Identifiable, Codable {
    let id: String
    let displayName: String
    let fileName: String
    /// Path below a Hugging Face–style host, e.g. `unsloth/Qwen3-1.7B-GGUF/resolve/main/<file>`.
    let repoPath: String
    let sizeBytes: Int64
    let sha256: String
    let license: String
    let licenseURL: String
    /// Physical RAM (GB) below which this model is not offered.
    let minimumRAMGB: Double
    /// Qwen checkpoints may think first; the template pre-fills an empty think block.
    let suppressThinking: Bool
    let contextLength: Int32

    var sizeLabel: String { ByteCountFormatter.string(fromByteCount: sizeBytes, countStyle: .file) }
}

enum LocalModelCatalog {
    /// Qwen3.5-2B, Q4_K_M (~1.3 GB, Apache-2.0): the warmest, most natural English and Chinese
    /// chat of the small models tested. Hybrid DeltaNet layers keep the KV cache tiny.
    static let standard = LocalModelSpec(
        id: "qwen3.5-2b-q4km",
        displayName: "Qwen3.5 2B",
        fileName: "Qwen3.5-2B-Q4_K_M.gguf",
        repoPath: "unsloth/Qwen3.5-2B-GGUF/resolve/main/Qwen3.5-2B-Q4_K_M.gguf",
        sizeBytes: 1_280_835_840,
        sha256: "aaf42c8b7c3cab2bf3d69c355048d4a0ee9973d48f16c731c0520ee914699223",
        license: "Apache-2.0",
        licenseURL: "https://huggingface.co/Qwen/Qwen3.5-2B/blob/main/LICENSE",
        minimumRAMGB: 5.5,
        suppressThinking: true,
        contextLength: 4096)

    /// Qwen3-1.7B, Q4_K_M (~1.1 GB, Apache-2.0): plain transformer, ~20% faster decoding.
    static let fast = LocalModelSpec(
        id: "qwen3-1.7b-q4km",
        displayName: "Qwen3 1.7B",
        fileName: "Qwen3-1.7B-Q4_K_M.gguf",
        repoPath: "unsloth/Qwen3-1.7B-GGUF/resolve/main/Qwen3-1.7B-Q4_K_M.gguf",
        sizeBytes: 1_107_409_472,
        sha256: "b139949c5bd74937ad8ed8c8cf3d9ffb1e99c866c823204dc42c0d91fa181897",
        license: "Apache-2.0",
        licenseURL: "https://huggingface.co/Qwen/Qwen3-1.7B/blob/main/LICENSE",
        minimumRAMGB: 5.5,
        suppressThinking: true,
        contextLength: 3072)

    /// Qwen3.5-0.8B, Q4_K_M (~530 MB, Apache-2.0): for 4 GB devices.
    static let lite = LocalModelSpec(
        id: "qwen3.5-0.8b-q4km",
        displayName: "Qwen3.5 0.8B (Lite)",
        fileName: "Qwen3.5-0.8B-Q4_K_M.gguf",
        repoPath: "unsloth/Qwen3.5-0.8B-GGUF/resolve/main/Qwen3.5-0.8B-Q4_K_M.gguf",
        sizeBytes: 532_517_120,
        sha256: "bd258782e35f7f458f8aced1adc053e6e92e89bc735ba3be89d38a06121dc517",
        license: "Apache-2.0",
        licenseURL: "https://huggingface.co/Qwen/Qwen3.5-0.8B/blob/main/LICENSE",
        minimumRAMGB: 3.5,
        suppressThinking: true,
        contextLength: 4096)

    static let all = [standard, fast, lite]

    static func spec(id: String) -> LocalModelSpec? { all.first { $0.id == id } }

    /// The best model this device can hold, or nil when on-device AI isn't offered.
    static func recommended(physicalMemory: UInt64 = ProcessInfo.processInfo.physicalMemory) -> LocalModelSpec? {
        let gb = Double(physicalMemory) / 1_073_741_824
        return all.first { gb >= $0.minimumRAMGB }
    }

    static func supported(physicalMemory: UInt64 = ProcessInfo.processInfo.physicalMemory) -> [LocalModelSpec] {
        let gb = Double(physicalMemory) / 1_073_741_824
        return all.filter { gb >= $0.minimumRAMGB }
    }
}

/// Where model weights are fetched from. The custom base lets the founder self-host
/// (e.g. a Supabase Storage public bucket or dearearth.space2.world) without an app update.
enum ModelMirror: String, Codable, Sendable, CaseIterable, Identifiable {
    case automatic
    case huggingFace
    case hfMirror
    case custom

    var id: String { rawValue }

    var title: String {
        switch self {
        case .automatic: return tr("Automatic", "自动")
        case .huggingFace: return "Hugging Face"
        case .hfMirror: return "hf-mirror.com"
        case .custom: return tr("Custom URL", "自定义地址")
        }
    }

    static let huggingFaceBase = "https://huggingface.co"
    static let hfMirrorBase = "https://hf-mirror.com"

    /// Candidate URLs in the order they should be tried.
    static func candidates(for spec: LocalModelSpec, mirror: ModelMirror, customBase: String) -> [URL] {
        let hf = URL(string: "\(huggingFaceBase)/\(spec.repoPath)")
        let mirrorURL = URL(string: "\(hfMirrorBase)/\(spec.repoPath)")
        let custom = customURL(base: customBase, spec: spec)
        let list: [URL?]
        switch mirror {
        case .automatic: return [custom, hf, mirrorURL].compactMap { $0 }
        case .huggingFace: list = [hf, mirrorURL]
        case .hfMirror: list = [mirrorURL, hf]
        case .custom: list = [custom, hf, mirrorURL]
        }
        return list.compactMap { $0 }
    }

    /// `https://host/path` → `https://host/path/<file>`; a base containing `{file}` or ending in `.gguf` is used as given.
    static func customURL(base: String, spec: LocalModelSpec) -> URL? {
        let trimmed = base.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, let scheme = URL(string: trimmed)?.scheme?.lowercased(), scheme == "https" || scheme == "http" else {
            return nil
        }
        if trimmed.contains("{file}") { return URL(string: trimmed.replacingOccurrences(of: "{file}", with: spec.fileName)) }
        if trimmed.lowercased().hasSuffix(".gguf") { return URL(string: trimmed) }
        let base = trimmed.hasSuffix("/") ? String(trimmed.dropLast()) : trimmed
        return URL(string: "\(base)/\(spec.fileName)")
    }
}

/// ChatML as used by the Qwen family. Past assistant turns keep the empty think block they were
/// generated with, so a new prompt extends the previous one verbatim and the runtime cache is reused.
enum ChatTemplate {
    static let emptyThink = "<think>\n\n</think>\n\n"

    static func chatML(system: String, turns: [ChatTurn], suppressThinking: Bool) -> String {
        var out = "<|im_start|>system\n\(system)<|im_end|>\n"
        for turn in turns {
            if turn.role == .user {
                out += "<|im_start|>user\n\(turn.content)<|im_end|>\n"
            } else {
                out += "<|im_start|>assistant\n\(suppressThinking ? emptyThink : "")\(turn.content)<|im_end|>\n"
            }
        }
        out += "<|im_start|>assistant\n"
        if suppressThinking { out += emptyThink }
        return out
    }
}
