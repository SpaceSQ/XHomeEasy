import Foundation

/// Older Dear Earth / Dear Sage weights live in `group.com.s2.dearuniverse/SharedModels`.
/// The current channel is `group.com.robotzero.shared.ai`. This reader only mounts a file whose
/// size matches the shared Qwen catalog, and only deletes a copy this app published.
enum LegacyDearUniverseChannel {
    static let appGroupIdentifier = "group.com.s2.dearuniverse"
    static let directoryName = "SharedModels"

    static func containerURL() -> URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)
    }

    static func modelsDirectory() -> URL? {
        containerURL()?.appendingPathComponent(directoryName, isDirectory: true)
    }

    static func publish(spec: LocalModelSpec, source: URL) {
        guard let directory = modelsDirectory() else { return }
        let fm = FileManager.default
        guard fm.fileExists(atPath: source.path) else { return }
        try? fm.createDirectory(at: directory, withIntermediateDirectories: true)
        let destination = directory.appendingPathComponent(spec.fileName)
        if source.standardizedFileURL != destination.standardizedFileURL {
            if fm.fileExists(atPath: destination.path) { try? fm.removeItem(at: destination) }
            try? fm.copyItem(at: source, to: destination)
        }
        var target = destination
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? target.setResourceValues(values)
        let record = ModelPublisherRecord(keyword: EcosystemIdentity.current.keyword,
                                          displayName: EcosystemIdentity.current.displayName,
                                          bundleID: EcosystemIdentity.current.bundleID,
                                          specID: spec.id,
                                          sha256: spec.sha256.lowercased(),
                                          byteSize: spec.sizeBytes,
                                          publishedAt: Date())
        if let data = try? JSONEncoder().encode(record) {
            try? data.write(to: sidecarURL(for: destination), options: .atomic)
        }
    }

    static func removeOwn(spec: LocalModelSpec) {
        guard let directory = modelsDirectory() else { return }
        let destination = directory.appendingPathComponent(spec.fileName)
        guard let record = readRecord(sidecarURL(for: destination)) else { return }
        guard record.keyword.lowercased() == EcosystemIdentity.current.keyword.lowercased() else { return }
        try? FileManager.default.removeItem(at: destination)
        try? FileManager.default.removeItem(at: sidecarURL(for: destination))
    }

    /// Catalog weights found in the legacy folder. Caller skips specs already mounted on the new channel.
    static func mounts(matching specs: [LocalModelSpec]) -> [SharedModelMount] {
        guard let directory = modelsDirectory() else { return [] }
        let files = (try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])) ?? []
        var found: [SharedModelMount] = []
        for spec in specs {
            guard let file = files.first(where: { $0.lastPathComponent == spec.fileName && fileSize($0) == spec.sizeBytes }) else { continue }
            let record = readRecord(sidecarURL(for: file))
            let own = record?.keyword.lowercased() == EcosystemIdentity.current.keyword.lowercased()
            let publisher = record ?? ModelPublisherRecord(keyword: "dearearth",
                                                           displayName: "Dear universe",
                                                           bundleID: "group.com.s2.dearuniverse",
                                                           specID: spec.id,
                                                           sha256: spec.sha256.lowercased(),
                                                           byteSize: spec.sizeBytes,
                                                           publishedAt: .distantPast)
            let decision: ModelShareDecision = own ? .ownImmediate : .greenChannel
            found.append(SharedModelMount(specID: spec.id, fileURL: file, publisher: publisher, decision: decision))
        }
        return found
    }

    private static func sidecarURL(for file: URL) -> URL {
        file.deletingLastPathComponent().appendingPathComponent(file.lastPathComponent + ".publisher.json")
    }

    private static func readRecord(_ url: URL) -> ModelPublisherRecord? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(ModelPublisherRecord.self, from: data)
    }

    private static func fileSize(_ url: URL) -> Int64 {
        ((try? FileManager.default.attributesOfItem(atPath: url.path))?[.size] as? NSNumber)?.int64Value ?? -1
    }
}
