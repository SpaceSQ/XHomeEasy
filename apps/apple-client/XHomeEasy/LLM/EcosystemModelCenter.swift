import Darwin
import Foundation
import UIKit

/// `flock(2)`. Swift imports the `flock` struct under this name, which hides the function.
@_silgen_name("flock")
private func ecosystemFlock(_ fd: Int32, _ operation: Int32) -> Int32

/// Shared on-device model channel for the 22-app ecosystem.
///
/// iOS apps cannot read each other's private sandboxes. Scanning reads this App Group
/// container (`group.com.robotzero.shared.ai`), which each member publishes into.
/// `scanEcosystemModels()` is the Swift replacement for the TypeScript stub that returned null.
struct EcosystemIdentity: Sendable, Equatable, Codable {
    var keyword: String
    var displayName: String
    var bundleID: String
}

enum EcosystemCatalog {
    static let appGroupIdentifier = "group.com.robotzero.shared.ai"

    /// Lowercase keywords for all 22 apps. URL schemes use the same strings.
    static let keywords: [String] = [
        "dearearth", "dearsage", "dearecho", "dearhome", "dearpet", "dearbody", "dearmuse", "dearalien",
        "ahomeeasy", "mhomeeasy", "khomeeasy", "xhomeeasy",
        "voltpilot", "starscope", "quoteshield", "meshdoctor", "powerark", "ghostradar", "elderguard", "hometwin", "solartruth", "billsniper"
    ]

    static func contains(_ keyword: String) -> Bool {
        let folded = keyword.lowercased()
        return keywords.contains(folded)
    }
}

extension EcosystemIdentity {
    /// This app's row in the 22-app ecosystem.
    static let current = EcosystemIdentity(keyword: "xhomeeasy", displayName: "X Home Easy", bundleID: "com.scrlab.xhomeeasy")
}

/// Who may use a published weight. Pure: no disk, no entitlement.
enum ModelShareDecision: Equatable, Sendable {
    case ownImmediate
    case greenChannel
    case externalAllowed
    case externalRefused

    var rank: Int {
        switch self {
        case .ownImmediate: return 0
        case .greenChannel: return 1
        case .externalAllowed: return 2
        case .externalRefused: return 3
        }
    }
}

enum EcosystemModelScheduler {
    static func decide(currentKeyword: String, publisherKeyword: String, allowExternal: Bool) -> ModelShareDecision {
        let current = currentKeyword.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let publisher = publisherKeyword.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !publisher.isEmpty, publisher == current { return .ownImmediate }
        if EcosystemCatalog.contains(publisher) { return .greenChannel }
        return allowExternal ? .externalAllowed : .externalRefused
    }
}

struct EcosystemRegistryEntry: Codable, Equatable, Sendable {
    var keyword: String
    var displayName: String
    var bundleID: String
    var lastSeen: Date
}

struct ModelPublisherRecord: Codable, Equatable, Sendable {
    var keyword: String
    var displayName: String
    var bundleID: String
    var specID: String
    var sha256: String
    var byteSize: Int64
    var publishedAt: Date
}

struct SharedModelMount: Equatable, Sendable {
    var specID: String
    var fileURL: URL
    var publisher: ModelPublisherRecord
    var decision: ModelShareDecision
}

struct EcosystemScan: Equatable, Sendable {
    var channelAvailable: Bool
    var scanCompleted: Bool
    var allowExternalSharing: Bool
    var registry: [EcosystemRegistryEntry]
    var installedKeywords: [String]
    var mounts: [SharedModelMount]

    static let pending = EcosystemScan(channelAvailable: true, scanCompleted: false, allowExternalSharing: false,
                                       registry: [], installedKeywords: [], mounts: [])

    func mount(for specID: String) -> SharedModelMount? {
        mounts.first { $0.specID == specID }
    }
}

/// Settings copy for the companion-engine screen.
enum EcosystemShareStatus: Equatable, Sendable {
    case detecting
    case channelUnavailable
    case hostedOnThisIPhone(appName: String)
    case greenChannel(publisherName: String)
    case external(publisherName: String)

    static func resolve(scan: EcosystemScan, specID: String?) -> EcosystemShareStatus {
        guard scan.scanCompleted else { return .detecting }
        guard scan.channelAvailable else { return .channelUnavailable }
        let mount = specID.flatMap { scan.mount(for: $0) } ?? scan.mounts.min { $0.decision.rank < $1.decision.rank }
        guard let mount else { return .detecting }
        switch mount.decision {
        case .ownImmediate:
            return .hostedOnThisIPhone(appName: mount.publisher.displayName)
        case .greenChannel:
            return .greenChannel(publisherName: mount.publisher.displayName)
        case .externalAllowed:
            return .external(publisherName: mount.publisher.displayName)
        case .externalRefused:
            return .detecting
        }
    }

    func message(in language: ContentLanguage) -> String {
        switch self {
        case .detecting:
            return tr("Looking for a shared ecosystem model…", "正在检测零号生态共享大模型……", in: language)
        case .channelUnavailable:
            return tr("Local AI model sharing is unavailable on this install. The model stays inside this app.",
                      "本地 AI 模型共享通道不可用，模型仍保存在本应用内。", in: language)
        case .hostedOnThisIPhone(let name):
            return tr("Local AI model sharing: this model is on this iPhone and available to the other ecosystem apps (provided by \(name)).",
                      "本地 AI 模型共享状态：模型已在这台 iPhone 上，可供其他生态应用使用（由 \(name) 提供支持）。", in: language)
        case .greenChannel(let name):
            return tr("Local AI model sharing: mounted through the ecosystem green channel (provided by \(name)).",
                      "本地 AI 模型共享状态：已通过内部生态绿色通道挂载（由 \(name) 提供支持）", in: language)
        case .external(let name):
            return tr("Local AI model sharing: mounted from an external app (provided by \(name)).",
                      "本地 AI 模型共享状态：已挂载外部应用提供的模型（由 \(name) 提供支持）。", in: language)
        }
    }
}

/// Publishes, migrates, and scans on-device weights in the shared container.
///
/// Pass a temporary `containerRoot` in tests. Production uses `live`, which falls back to the
/// app sandbox and reports the channel unavailable when the App Group entitlement is missing.
struct EcosystemModelCenter: Sendable {
    let identity: EcosystemIdentity
    let containerRoot: URL
    let legacyModelsDirectory: URL
    let channelAvailable: Bool

    static func live(identity: EcosystemIdentity, legacyModelsDirectory: URL) -> EcosystemModelCenter {
        if let group = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: EcosystemCatalog.appGroupIdentifier) {
            return EcosystemModelCenter(identity: identity, containerRoot: group,
                                        legacyModelsDirectory: legacyModelsDirectory, channelAvailable: true)
        }
        return EcosystemModelCenter(identity: identity, containerRoot: legacyModelsDirectory,
                                    legacyModelsDirectory: legacyModelsDirectory, channelAvailable: false)
    }

    var modelsRoot: URL { containerRoot.appendingPathComponent("models", isDirectory: true) }
    var registryURL: URL { containerRoot.appendingPathComponent("registry.json") }
    var sharingSettingsURL: URL { containerRoot.appendingPathComponent("sharing-settings.json") }
    private var registryLockURL: URL { containerRoot.appendingPathComponent(".registry.lock") }

    func modelFolder(specID: String) -> URL {
        modelsRoot.appendingPathComponent(Self.safeSpecID(specID), isDirectory: true)
    }

    // MARK: Registry and settings

    func readRegistry() -> [EcosystemRegistryEntry] {
        readJSON(RegistryFile.self, from: registryURL)?.apps ?? []
    }

    func checkIn(now: Date = Date()) throws {
        guard channelAvailable else { return }
        try withRegistryLock {
            var apps = readRegistry()
            let keyword = identity.keyword.lowercased()
            apps.removeAll { $0.keyword.lowercased() == keyword }
            apps.append(EcosystemRegistryEntry(keyword: keyword, displayName: identity.displayName,
                                                bundleID: identity.bundleID, lastSeen: now))
            apps.sort { $0.keyword < $1.keyword }
            try writeJSON(RegistryFile(apps: apps), to: registryURL)
        }
    }

    func hasSharingSettings() -> Bool {
        FileManager.default.fileExists(atPath: sharingSettingsURL.path)
    }

    func allowExternalSharing() -> Bool {
        guard channelAvailable else { return false }
        return readJSON(SharingSettings.self, from: sharingSettingsURL)?.allowExternalSharing ?? false
    }

    func setAllowExternalSharing(_ value: Bool) throws {
        guard channelAvailable else { return }
        try writeJSON(SharingSettings(allowExternalSharing: value), to: sharingSettingsURL)
    }

    // MARK: Publish and migrate

    /// Moves a verified download into `models/<spec-id>/` and leaves a symlink at the legacy path.
    @discardableResult
    func publish(spec: LocalModelSpec, sourceURL: URL, now: Date = Date()) throws -> URL {
        guard channelAvailable else { return sourceURL }
        let folder = modelFolder(specID: spec.id)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        let destination = folder.appendingPathComponent(spec.fileName)
        try relocate(source: sourceURL, destination: destination, spec: spec, now: now)
        excludeFromBackup(folder)
        return destination
    }

    /// First launch after this change: an already-installed GGUF moves into the group.
    func migrateLegacy(specs: [LocalModelSpec], now: Date = Date()) {
        guard channelAvailable else { return }
        for spec in specs {
            let legacy = legacyModelsDirectory.appendingPathComponent(spec.fileName)
            guard FileManager.default.fileExists(atPath: legacy.path) else { continue }
            guard fileSize(legacy) == spec.sizeBytes else { continue }
            _ = try? publish(spec: spec, sourceURL: legacy, now: now)
        }
    }

    func removeOwnPublication(specID: String) {
        guard channelAvailable else { return }
        let folder = modelFolder(specID: specID)
        guard let publisher = readJSON(ModelPublisherRecord.self, from: folder.appendingPathComponent("publisher.json")) else { return }
        guard publisher.keyword.lowercased() == identity.keyword.lowercased() else { return }
        try? FileManager.default.removeItem(at: folder)
    }

    // MARK: Scan

    /// Disk scan. Does not probe URL schemes; the caller adds those on the main actor.
    func performScan(specs: [LocalModelSpec], mirroredAllowExternal: Bool, now: Date = Date()) -> EcosystemScan {
        guard channelAvailable else {
            return EcosystemScan(channelAvailable: false, scanCompleted: true, allowExternalSharing: mirroredAllowExternal,
                                 registry: [], installedKeywords: [], mounts: [])
        }
        if !hasSharingSettings() {
            try? setAllowExternalSharing(mirroredAllowExternal)
        }
        let allow = allowExternalSharing()
        migrateLegacy(specs: specs, now: now)
        try? checkIn(now: now)
        let mounts = discoverMounts(allowExternal: allow)
        return EcosystemScan(channelAvailable: true, scanCompleted: true, allowExternalSharing: allow,
                             registry: readRegistry(), installedKeywords: [], mounts: mounts)
    }

    /// Real scan: own weight, then a sibling among the 22, then an external publisher if allowed.
    /// Returns nil when nothing on this phone may be used. Replaces the stub that always returned null.
    func scanEcosystemModels(specs: [LocalModelSpec], mirroredAllowExternal: Bool = false) -> URL? {
        let scan = performScan(specs: specs, mirroredAllowExternal: mirroredAllowExternal)
        return scan.mounts.min { $0.decision.rank < $1.decision.rank }?.fileURL
    }

    /// Installed ecosystem apps, by URL scheme. The opener returns false when a scheme is absent.
    static func probeInstalledKeywords(open: (URL) -> Bool) -> [String] {
        keywordsOpening(open)
    }

    @MainActor
    static func probeInstalledKeywords() -> [String] {
        probeInstalledKeywords { url in
            UIApplication.shared.canOpenURL(url)
        }
    }

    // MARK: Private

    private static func keywordsOpening(_ open: (URL) -> Bool) -> [String] {
        EcosystemCatalog.keywords.compactMap { keyword in
            guard let url = URL(string: "\(keyword)://") else { return nil }
            return open(url) ? keyword : nil
        }
    }

    private func discoverMounts(allowExternal: Bool) -> [SharedModelMount] {
        let folders = (try? FileManager.default.contentsOfDirectory(at: modelsRoot, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles])) ?? []
        var best: [String: SharedModelMount] = [:]
        for folder in folders {
            guard (try? folder.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true else { continue }
            guard let publisher = readJSON(ModelPublisherRecord.self, from: folder.appendingPathComponent("publisher.json")) else { continue }
            let decision = EcosystemModelScheduler.decide(currentKeyword: identity.keyword, publisherKeyword: publisher.keyword, allowExternal: allowExternal)
            guard decision != .externalRefused else { continue }
            guard let file = weightFile(in: folder, byteSize: publisher.byteSize) else { continue }
            let mount = SharedModelMount(specID: publisher.specID, fileURL: file, publisher: publisher, decision: decision)
            if let existing = best[publisher.specID] {
                best[publisher.specID] = preferred(existing, mount)
            } else {
                best[publisher.specID] = mount
            }
        }
        return best.values.sorted { $0.specID < $1.specID }
    }

    private func preferred(_ a: SharedModelMount, _ b: SharedModelMount) -> SharedModelMount {
        if a.decision.rank != b.decision.rank { return a.decision.rank < b.decision.rank ? a : b }
        return a.publisher.publishedAt >= b.publisher.publishedAt ? a : b
    }

    private func weightFile(in folder: URL, byteSize: Int64) -> URL? {
        let files = (try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])) ?? []
        return files.first { $0.pathExtension.lowercased() == "gguf" && fileSize($0) == byteSize }
    }

    private func relocate(source: URL, destination: URL, spec: LocalModelSpec, now: Date) throws {
        let fm = FileManager.default
        let publisherURL = destination.deletingLastPathComponent().appendingPathComponent("publisher.json")
        let pointsAtDestination = isSymbolicLink(source)
            && source.resolvingSymlinksInPath().standardizedFileURL == destination.standardizedFileURL
        if pointsAtDestination {
            if let existing = readJSON(ModelPublisherRecord.self, from: publisherURL),
               existing.keyword.lowercased() != identity.keyword.lowercased() {
                return
            }
        } else if fm.fileExists(atPath: source.path) || isSymbolicLink(source) {
            let resolved = source.resolvingSymlinksInPath()
            guard fm.fileExists(atPath: resolved.path) else { throw CocoaError(.fileNoSuchFile) }
            if fm.fileExists(atPath: destination.path) { try fm.removeItem(at: destination) }
            if isSymbolicLink(source) {
                try fm.copyItem(at: resolved, to: destination)
            } else {
                do { try fm.moveItem(at: source, to: destination) }
                catch {
                    try fm.copyItem(at: resolved, to: destination)
                    try? fm.removeItem(at: source)
                }
            }
            excludeFromBackup(destination)
            if fm.fileExists(atPath: source.path) || isSymbolicLink(source) { try? fm.removeItem(at: source) }
            try fm.createDirectory(at: source.deletingLastPathComponent(), withIntermediateDirectories: true)
            do {
                try fm.createSymbolicLink(at: source, withDestinationURL: destination)
            } catch {
                if !fm.fileExists(atPath: source.path) { try? fm.copyItem(at: destination, to: source) }
            }
        } else if !fm.fileExists(atPath: destination.path) {
            throw CocoaError(.fileNoSuchFile)
        } else if let existing = readJSON(ModelPublisherRecord.self, from: publisherURL),
                  existing.keyword.lowercased() != identity.keyword.lowercased() {
            return
        }
        let record = ModelPublisherRecord(keyword: identity.keyword.lowercased(), displayName: identity.displayName,
                                          bundleID: identity.bundleID, specID: spec.id, sha256: spec.sha256.lowercased(),
                                          byteSize: spec.sizeBytes, publishedAt: now)
        try writeJSON(record, to: publisherURL)
    }

    private func withRegistryLock<T>(_ body: () throws -> T) throws -> T {
        let fm = FileManager.default
        try fm.createDirectory(at: containerRoot, withIntermediateDirectories: true)
        let fd = Darwin.open(registryLockURL.path, Darwin.O_CREAT | Darwin.O_RDWR, Darwin.S_IRUSR | Darwin.S_IWUSR | Darwin.S_IRGRP | Darwin.S_IROTH)
        if fd >= 0 { _ = ecosystemFlock(fd, 2) }
        defer {
            if fd >= 0 {
                _ = ecosystemFlock(fd, 8)
                _ = Darwin.close(fd)
            }
        }
        return try body()
    }

    private func writeJSON<T: Encodable>(_ value: T, to url: URL) throws {
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try EcosystemJSON.encoder().encode(value).write(to: url, options: .atomic)
    }

    private func readJSON<T: Decodable>(_ type: T.Type, from url: URL) -> T? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? EcosystemJSON.decoder().decode(type, from: data)
    }

    private func fileSize(_ url: URL) -> Int64 {
        ((try? FileManager.default.attributesOfItem(atPath: url.path))?[.size] as? NSNumber)?.int64Value ?? -1
    }

    private func isSymbolicLink(_ url: URL) -> Bool {
        (try? url.resourceValues(forKeys: [.isSymbolicLinkKey]).isSymbolicLink) == true
    }

    private func excludeFromBackup(_ url: URL) {
        var copy = url
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? copy.setResourceValues(values)
    }

    private static func safeSpecID(_ id: String) -> String {
        let cleaned = id.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "..", with: "_")
        return cleaned.isEmpty ? "model" : cleaned
    }
}

private struct RegistryFile: Codable, Equatable, Sendable {
    var apps: [EcosystemRegistryEntry]
}

private struct SharingSettings: Codable, Equatable, Sendable {
    var allowExternalSharing: Bool

    enum CodingKeys: String, CodingKey {
        case allowExternalSharing = "allow_external_sharing"
    }
}

/// ISO-8601 without fractional seconds, so encode and decode agree on every OS version.
private enum EcosystemJSON {
    static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(Self.string(from: date))
        }
        return encoder
    }

    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let raw = try decoder.singleValueContainer().decode(String.self)
            guard let date = Self.date(from: raw) else {
                throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: raw))
            }
            return date
        }
        return decoder
    }

    private static func string(from date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: date)
    }

    private static func date(from raw: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        if let date = formatter.date(from: raw) { return date }
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: raw)
    }
}
