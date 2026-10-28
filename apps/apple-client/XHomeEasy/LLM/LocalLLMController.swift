import Foundation
import UIKit

struct LocalModelRow: Equatable, Identifiable, Sendable {
    var id: String
    var displayName: String
    var sizeLabel: String
    var license: String
    var installed: Bool
    var available: Bool
    var phase: String
    var progress: Double
    var receivedBytes: Int64
    var expectedBytes: Int64
    var errorCode: String?
    var decision: String?
    var publisherName: String?
}

struct LocalModelViewState: Equatable, Sendable {
    var rows: [LocalModelRow] = []
    var share: EcosystemShareStatus = .detecting
    var allowExternalSharing = false
    var channelAvailable = false
    var scanCompleted = false
    var runtimeAvailable = false
    var mirror: ModelMirror = .automatic
    var customBase = ""
    var allowsCellular = false
    var selectedSpecID: String?
    var recommendedSpecID: String?

    var selectedRow: LocalModelRow? {
        rows.first { $0.id == selectedSpecID } ?? rows.first
    }

    var modelReady: Bool {
        runtimeAvailable && rows.contains { $0.available }
    }
}

/// Owns the copied download manager, the App Group scan, and one llama.cpp runtime.
@MainActor
@Observable
final class LocalLLMController {
    static let shared = LocalLLMController()

    private enum Pref {
        static let spec = "xhomeeasy.llm.spec"
        static let mirror = "xhomeeasy.llm.mirror"
        static let custom = "xhomeeasy.llm.customBase"
        static let cellular = "xhomeeasy.llm.cellular"
        static let dismissed = "xhomeeasy.llm.cardDismissed"
    }

    let models: ModelDownloadManager
    let ecosystem: EcosystemModelCenter
    private(set) var scan = EcosystemScan.pending
    private(set) var viewState = LocalModelViewState()
    var offerDismissed: Bool {
        get { UserDefaults.standard.bool(forKey: Pref.dismissed) }
        set { UserDefaults.standard.set(newValue, forKey: Pref.dismissed) }
    }

    private var runtime: LlamaRuntime?
    private var loadedPath: String?
    private var scanGeneration = 0
    private var memoryObserver: NSObjectProtocol?

    private init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let directory = support.appendingPathComponent("models", isDirectory: true)
        let store = LocalModelStore(directory: directory)
        try? store.prepare()
        models = ModelDownloadManager(store: store)
        ecosystem = EcosystemModelCenter.live(identity: .current, legacyModelsDirectory: directory)
        models.onInstalled = { [weak self] spec in
            self?.publish(spec)
        }
        memoryObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] _ in
            Task { @MainActor in await self?.unloadRuntime() }
        }
        models.reconnect()
        publish()
    }

    func reconnectDownloads() {
        models.reconnect()
    }

    func monitor() async {
        scheduleScan()
        while !Task.isCancelled {
            publish()
            try? await Task.sleep(for: .milliseconds(700))
        }
    }

    var selectedSpec: LocalModelSpec? {
        if let id = UserDefaults.standard.string(forKey: Pref.spec), let spec = LocalModelCatalog.spec(id: id) {
            return spec
        }
        return LocalModelCatalog.recommended()
    }

    var mirror: ModelMirror {
        let raw = UserDefaults.standard.string(forKey: Pref.mirror) ?? ModelMirror.automatic.rawValue
        return ModelMirror(rawValue: raw) ?? .automatic
    }

    var customBase: String { UserDefaults.standard.string(forKey: Pref.custom) ?? "" }
    var allowsCellular: Bool { UserDefaults.standard.bool(forKey: Pref.cellular) }

    func select(specID: String) {
        guard LocalModelCatalog.spec(id: specID) != nil else { return }
        UserDefaults.standard.set(specID, forKey: Pref.spec)
        publish()
    }

    func setMirror(_ mirror: ModelMirror) {
        UserDefaults.standard.set(mirror.rawValue, forKey: Pref.mirror)
        publish()
    }

    func setCustomBase(_ value: String) {
        UserDefaults.standard.set(value, forKey: Pref.custom)
        publish()
    }

    func setAllowsCellular(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Pref.cellular)
        publish()
    }

    func setAllowExternalSharing(_ allowed: Bool) {
        if ecosystem.channelAvailable {
            try? ecosystem.setAllowExternalSharing(allowed)
        }
        scheduleScan()
    }

    func dismissOffer() {
        offerDismissed = true
        publish()
    }

    func startDownload(specID: String?) {
        guard let spec = specID.flatMap(LocalModelCatalog.spec(id:)) ?? selectedSpec else { return }
        select(specID: spec.id)
        models.start(spec, mirror: mirror, customBase: customBase, allowsCellular: allowsCellular)
        publish()
    }

    func pauseDownload() {
        models.pause()
        publish()
    }

    func cancelDownload() {
        models.cancel()
        publish()
    }

    func delete(specID: String) {
        guard let spec = LocalModelCatalog.spec(id: specID) else { return }
        if loadedPath == resolvedURL(for: spec)?.path {
            Task { await unloadRuntime() }
        }
        ecosystem.removeOwnPublication(specID: spec.id)
        LegacyDearUniverseChannel.removeOwn(spec: spec)
        models.delete(spec)
        scheduleScan()
    }

    func scheduleScan() {
        scanGeneration += 1
        let generation = scanGeneration
        let center = ecosystem
        let mirrored = false
        Task.detached(priority: .utility) {
            var next = center.performScan(specs: LocalModelCatalog.all, mirroredAllowExternal: mirrored)
            for mount in LegacyDearUniverseChannel.mounts(matching: LocalModelCatalog.all) where next.mount(for: mount.specID) == nil {
                next.mounts.append(mount)
            }
            let schemes = await MainActor.run { EcosystemModelCenter.probeInstalledKeywords() }
            await MainActor.run { [weak self] in
                guard let self, self.scanGeneration == generation else { return }
                next.installedKeywords = schemes
                self.scan = next
                self.publish()
            }
        }
    }

    var runtimeReady: Bool {
        LlamaRuntime.isAvailable && specForInference().flatMap(resolvedURL(for:)) != nil
    }

    func specForInference() -> LocalModelSpec? {
        if let selected = selectedSpec, resolvedURL(for: selected) != nil { return selected }
        return LocalModelCatalog.supported().first { resolvedURL(for: $0) != nil }
    }

    func resolvedURL(for spec: LocalModelSpec) -> URL? {
        if let mount = scan.mount(for: spec.id) { return mount.fileURL }
        if models.isInstalled(spec) { return models.store.installedURL(spec) }
        return nil
    }

    func publish() {
        let supported = LocalModelCatalog.supported()
        let selected = selectedSpec
        var rows: [LocalModelRow] = []
        for spec in supported {
            let phase = models.phase(for: spec)
            let mount = scan.mount(for: spec.id)
            let active = models.activeSpecID == spec.id
            rows.append(LocalModelRow(
                id: spec.id,
                displayName: spec.displayName,
                sizeLabel: spec.sizeLabel,
                license: spec.license,
                installed: models.isInstalled(spec),
                available: resolvedURL(for: spec) != nil,
                phase: phaseName(phase),
                progress: active ? models.progress : 0,
                receivedBytes: active ? models.receivedBytes : 0,
                expectedBytes: active ? models.expectedBytes : spec.sizeBytes,
                errorCode: active ? models.failureCode : nil,
                decision: mount.map { decisionName($0.decision) },
                publisherName: mount?.publisher.displayName
            ))
        }
        viewState = LocalModelViewState(
            rows: rows,
            share: EcosystemShareStatus.resolve(scan: scan, specID: selected?.id),
            allowExternalSharing: scan.scanCompleted ? scan.allowExternalSharing : false,
            channelAvailable: scan.scanCompleted ? scan.channelAvailable : ecosystem.channelAvailable,
            scanCompleted: scan.scanCompleted,
            runtimeAvailable: LlamaRuntime.isAvailable,
            mirror: mirror,
            customBase: customBase,
            allowsCellular: allowsCellular,
            selectedSpecID: selected?.id,
            recommendedSpecID: LocalModelCatalog.recommended()?.id
        )
    }

    func complete(system: String, turns: [ChatTurn], maxTokens: Int, temperature: Double) async throws -> String {
        guard LlamaRuntime.isAvailable else { throw LLMRuntimeError.runtimeUnavailable }
        guard let spec = specForInference(), let url = resolvedURL(for: spec) else { throw LLMRuntimeError.modelMissing }
        if runtime == nil || loadedPath != url.path {
            let next = LlamaRuntime(configuration: .deviceDefault(contextLength: spec.contextLength))
            _ = try await next.load(url)
            runtime = next
            loadedPath = url.path
        }
        guard let runtime else { throw LLMRuntimeError.runtimeUnavailable }
        let prompt = ChatTemplate.chatML(system: system, turns: turns, suppressThinking: spec.suppressThinking)
        var options = LLMGenerationOptions()
        options.maxTokens = Int(max(32, min(maxTokens, 640)))
        options.temperature = Float(min(1.2, max(0, temperature)))
        var output = ""
        for try await piece in runtime.generate(prompt: prompt, options: options) {
            output += piece
            if output.count > 6000 { break }
        }
        return Self.stripThink(output).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func stripThink(_ text: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: #"<think>[\s\S]*?</think>"#, options: []) else { return text }
        let range = NSRange(text.startIndex..., in: text)
        return regex.stringByReplacingMatches(in: text, range: range, withTemplate: "")
    }

    private func unloadRuntime() async {
        await runtime?.unload()
        runtime = nil
        loadedPath = nil
    }

    private func publish(_ spec: LocalModelSpec) {
        let source = models.store.installedURL(spec)
        let center = ecosystem
        Task.detached(priority: .utility) {
            let published = (try? center.publish(spec: spec, sourceURL: source)) ?? source
            LegacyDearUniverseChannel.publish(spec: spec, source: published)
            await MainActor.run { [weak self] in self?.scheduleScan() }
        }
    }

    private func phaseName(_ phase: ModelDownloadManager.Phase) -> String {
        switch phase {
        case .idle: return "idle"
        case .downloading: return "downloading"
        case .paused: return "paused"
        case .verifying: return "verifying"
        case .installed: return "installed"
        case .failed: return "failed"
        }
    }

    private func decisionName(_ decision: ModelShareDecision) -> String {
        switch decision {
        case .ownImmediate: return "own"
        case .greenChannel: return "green"
        case .externalAllowed: return "external"
        case .externalRefused: return "refused"
        }
    }
}
