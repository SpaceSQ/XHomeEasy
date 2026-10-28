import CryptoKit
import Foundation

enum ModelInstallError: LocalizedError, Equatable {
    case checksumMismatch(expected: String, actual: String)
    case sizeMismatch(expected: Int64, actual: Int64)
    case noMirror
    case http(Int)

    var errorDescription: String? {
        switch self {
        case .checksumMismatch:
            return tr("The downloaded file didn't pass its integrity check and was removed. Please try again or pick another mirror.",
                      "下载的文件未通过完整性校验，已删除。请重试或换一个下载源。")
        case .sizeMismatch:
            return tr("The download was incomplete. Please try again.", "下载不完整，请重试。")
        case .noMirror:
            return tr("No download source is configured.", "没有可用的下载源。")
        case .http(let code):
            return tr("The download server answered \(code). Trying another mirror may help.", "下载服务器返回 \(code)，可尝试更换下载源。")
        }
    }

    var code: String {
        switch self {
        case .checksumMismatch: return "checksum"
        case .sizeMismatch: return "incomplete"
        case .noMirror: return "no_mirror"
        case .http: return "http"
        }
    }
}

/// File-level model storage: verification, installation and resume data. Pure and unit-tested.
struct LocalModelStore: Sendable {
    let directory: URL

    var stagingDirectory: URL { directory.appendingPathComponent(".staging", isDirectory: true) }

    func installedURL(_ spec: LocalModelSpec) -> URL { directory.appendingPathComponent(spec.fileName) }
    func stagedURL(_ spec: LocalModelSpec) -> URL { stagingDirectory.appendingPathComponent(spec.fileName + ".part") }
    func resumeDataURL(_ spec: LocalModelSpec) -> URL { stagingDirectory.appendingPathComponent(spec.id + ".resume") }

    func isInstalled(_ spec: LocalModelSpec) -> Bool {
        let attributes = try? FileManager.default.attributesOfItem(atPath: installedURL(spec).path)
        return (attributes?[.size] as? NSNumber)?.int64Value == spec.sizeBytes
    }

    func prepare() throws {
        try FileManager.default.createDirectory(at: stagingDirectory, withIntermediateDirectories: true)
        var url = directory
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? url.setResourceValues(values)
    }

    /// Streams the file through SHA-256 in 4 MB chunks (constant memory for 1+ GB files).
    static func sha256(of url: URL) throws -> String {
        let handle = try FileHandle(forReadingFrom: url)
        defer { try? handle.close() }
        var hasher = SHA256()
        while let chunk = try handle.read(upToCount: 4 << 20), !chunk.isEmpty {
            hasher.update(data: chunk)
        }
        return hasher.finalize().map { String(format: "%02x", $0) }.joined()
    }

    /// Verifies a staged download and moves it into place. A bad file is deleted.
    @discardableResult
    func install(staged: URL, spec: LocalModelSpec) throws -> URL {
        let size = ((try? FileManager.default.attributesOfItem(atPath: staged.path))?[.size] as? NSNumber)?.int64Value ?? -1
        guard size == spec.sizeBytes else {
            try? FileManager.default.removeItem(at: staged)
            throw ModelInstallError.sizeMismatch(expected: spec.sizeBytes, actual: size)
        }
        let digest = try Self.sha256(of: staged)
        guard digest == spec.sha256.lowercased() else {
            try? FileManager.default.removeItem(at: staged)
            throw ModelInstallError.checksumMismatch(expected: spec.sha256, actual: digest)
        }
        try prepare()
        let destination = installedURL(spec)
        try? FileManager.default.removeItem(at: destination)
        try FileManager.default.moveItem(at: staged, to: destination)
        var target = destination
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? target.setResourceValues(values)
        try? FileManager.default.removeItem(at: resumeDataURL(spec))
        return destination
    }

    func saveResumeData(_ data: Data, for spec: LocalModelSpec) {
        try? prepare()
        try? data.write(to: resumeDataURL(spec), options: .atomic)
    }

    func resumeData(for spec: LocalModelSpec) -> Data? { try? Data(contentsOf: resumeDataURL(spec)) }

    func clearResumeData(for spec: LocalModelSpec) { try? FileManager.default.removeItem(at: resumeDataURL(spec)) }

    func delete(_ spec: LocalModelSpec) {
        try? FileManager.default.removeItem(at: installedURL(spec))
        try? FileManager.default.removeItem(at: stagedURL(spec))
        clearResumeData(for: spec)
    }
}

/// How the next download attempt starts: resume a partial transfer or fetch from a mirror URL.
enum DownloadPlan: Equatable {
    case resume(Data)
    case fresh(URL)
    case exhausted

    static func next(spec: LocalModelSpec, store: LocalModelStore, mirror: ModelMirror, customBase: String,
                     failedURLs: Set<URL>) -> DownloadPlan {
        if let data = store.resumeData(for: spec), !data.isEmpty { return .resume(data) }
        let candidates = ModelMirror.candidates(for: spec, mirror: mirror, customBase: customBase)
        guard let url = candidates.first(where: { !failedURLs.contains($0) }) else { return .exhausted }
        return .fresh(url)
    }
}

/// Explicit, opt-in model download (never a launch gate). Background `URLSession` so it keeps
/// going when the app is suspended; resumable; verified by SHA-256 before use.
@MainActor
final class ModelDownloadManager {
    enum Phase: Equatable {
        case idle
        case downloading
        case paused
        case verifying
        case installed
        case failed(String)
    }

    static let sessionIdentifier = "com.scrlab.xhomeeasy.model-download"

    let store: LocalModelStore
    private(set) var phase: Phase = .idle
    private(set) var receivedBytes: Int64 = 0
    private(set) var expectedBytes: Int64 = 0
    private(set) var activeSpecID: String?
    private(set) var sourceHost: String?
    /// Bumped when a model is installed or deleted so dependants refresh.
    private(set) var revision = 0
    /// Verified install finished. The app publishes the file into the shared container.
    var onInstalled: (@MainActor (LocalModelSpec) -> Void)?
    /// `checksum`, `incomplete`, `no_mirror`, `http`, `interrupted`, or `other` while `phase` is `.failed`.
    private(set) var failureCode: String?

    var progress: Double { expectedBytes > 0 ? min(1, Double(receivedBytes) / Double(expectedBytes)) : 0 }

    private var session: URLSession?
    private var task: URLSessionDownloadTask?
    private var failedURLs: Set<URL> = []
    private var currentURL: URL?
    private var mirror: ModelMirror = .automatic
    private var customBase = ""
    private var allowsCellular = false

    init(store: LocalModelStore) {
        self.store = store
    }

    func isInstalled(_ spec: LocalModelSpec) -> Bool { store.isInstalled(spec) }

    func phase(for spec: LocalModelSpec) -> Phase {
        if activeSpecID == spec.id { return phase }
        if store.isInstalled(spec) { return .installed }
        return store.resumeData(for: spec) != nil ? .paused : .idle
    }

    // MARK: Control

    func start(_ spec: LocalModelSpec, mirror: ModelMirror, customBase: String, allowsCellular: Bool) {
        guard phase != .downloading && phase != .verifying || activeSpecID != spec.id else { return }
        if activeSpecID != spec.id { task?.cancel(); failedURLs = [] }
        self.mirror = mirror
        self.customBase = customBase
        self.allowsCellular = allowsCellular
        failureCode = nil
        activeSpecID = spec.id
        expectedBytes = spec.sizeBytes
        try? store.prepare()
        launchNextAttempt(spec)
    }

    func pause() {
        guard let task, phase == .downloading, let spec = activeSpec else { return }
        let store = self.store
        task.cancel(byProducingResumeData: { data in
            if let data { store.saveResumeData(data, for: spec) }
        })
        self.task = nil
        phase = .paused
    }

    func cancel() {
        task?.cancel()
        task = nil
        if let spec = activeSpec { store.clearResumeData(for: spec); try? FileManager.default.removeItem(at: store.stagedURL(spec)) }
        phase = .idle
        receivedBytes = 0
        activeSpecID = nil
    }

    func delete(_ spec: LocalModelSpec) {
        if activeSpecID == spec.id { cancel() }
        store.delete(spec)
        revision += 1
    }

    /// Cancels an in-flight download after the sandbox (including `Models/`) has been wiped.
    func resetAfterStorageWipe() {
        cancel()
        failedURLs = []
        currentURL = nil
        revision += 1
    }

    /// Reattaches to a background session after relaunch so progress and completion arrive.
    func reconnect() {
        _ = backgroundSession()
    }

    private var activeSpec: LocalModelSpec? { activeSpecID.flatMap(LocalModelCatalog.spec(id:)) }

    private func launchNextAttempt(_ spec: LocalModelSpec) {
        let session = backgroundSession()
        switch DownloadPlan.next(spec: spec, store: store, mirror: mirror, customBase: customBase, failedURLs: failedURLs) {
        case .resume(let data):
            store.clearResumeData(for: spec)
            task = session.downloadTask(withResumeData: data)
        case .fresh(let url):
            currentURL = url
            receivedBytes = 0
            var request = URLRequest(url: url)
            request.allowsCellularAccess = allowsCellular
            task = session.downloadTask(with: request)
        case .exhausted:
            failureCode = ModelInstallError.noMirror.code
            phase = .failed(ModelInstallError.noMirror.localizedDescription)
            return
        }
        sourceHost = currentURL?.host
        task?.taskDescription = spec.id
        phase = .downloading
        task?.resume()
    }

    private func backgroundSession() -> URLSession {
        if let session { return session }
        let configuration = URLSessionConfiguration.background(withIdentifier: Self.sessionIdentifier)
        configuration.isDiscretionary = false
        configuration.sessionSendsLaunchEvents = true
        configuration.allowsCellularAccess = true
        let delegate = DownloadDelegate(store: store, owner: self)
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        self.session = session
        return session
    }

    // MARK: Delegate callbacks (main actor)

    fileprivate func didWrite(specID: String?, received: Int64, expected: Int64) {
        if let specID, activeSpecID == nil { activeSpecID = specID }
        receivedBytes = received
        if expected > 0 { expectedBytes = expected }
        if phase != .downloading { phase = .downloading }
    }

    fileprivate func didStage(specID: String?, httpStatus: Int) {
        guard let spec = (specID ?? activeSpecID).flatMap(LocalModelCatalog.spec(id:)) else { return }
        activeSpecID = spec.id
        task = nil
        if !(200..<300).contains(httpStatus) {
            try? FileManager.default.removeItem(at: store.stagedURL(spec))
            if let currentURL { failedURLs.insert(currentURL) }
            if case .exhausted = DownloadPlan.next(spec: spec, store: store, mirror: mirror, customBase: customBase, failedURLs: failedURLs) {
                failureCode = ModelInstallError.http(httpStatus).code
                phase = .failed(ModelInstallError.http(httpStatus).localizedDescription)
            } else {
                launchNextAttempt(spec)
            }
            return
        }
        phase = .verifying
        let store = self.store
        Task.detached(priority: .utility) {
            let result = Result { try store.install(staged: store.stagedURL(spec), spec: spec) }
            await MainActor.run {
                switch result {
                case .success:
                    self.failureCode = nil
                    self.phase = .installed
                    self.revision += 1
                    self.onInstalled?(spec)
                case .failure(let error):
                    self.failureCode = (error as? ModelInstallError)?.code ?? "other"
                    self.phase = .failed(error.localizedDescription)
                }
            }
        }
    }

    fileprivate func didFail(specID: String?, error: Error, resumeData: Data?) {
        guard let spec = (specID ?? activeSpecID).flatMap(LocalModelCatalog.spec(id:)) else { return }
        task = nil
        if (error as NSError).code == NSURLErrorCancelled, phase == .paused || phase == .idle { return }
        if let resumeData {
            store.saveResumeData(resumeData, for: spec)
            failureCode = "interrupted"
            phase = .failed(tr("The download was interrupted. Tap Resume to continue where it stopped.",
                               "下载中断了，点“继续”可从中断处接着下载。"))
            return
        }
        if let currentURL { failedURLs.insert(currentURL) }
        if case .exhausted = DownloadPlan.next(spec: spec, store: store, mirror: mirror, customBase: customBase, failedURLs: failedURLs) {
            failureCode = "other"
            phase = .failed(error.localizedDescription)
        } else {
            launchNextAttempt(spec)
        }
    }

    fileprivate func sessionFinishedEvents() {
        BackgroundDownloadEvents.pending?()
        BackgroundDownloadEvents.pending = nil
    }
}

/// Completion handler iOS hands the app delegate when it relaunches the app for background download events.
@MainActor
enum BackgroundDownloadEvents {
    static var pending: (() -> Void)?
}

/// URLSession delegate. The finished file must be moved before the callback returns, so that part
/// runs synchronously on the delegate queue; everything else hops to the main actor.
private final class DownloadDelegate: NSObject, URLSessionDownloadDelegate, @unchecked Sendable {
    let store: LocalModelStore
    weak var owner: ModelDownloadManager?

    init(store: LocalModelStore, owner: ModelDownloadManager) {
        self.store = store
        self.owner = owner
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let id = downloadTask.taskDescription
        Task { @MainActor [weak owner] in owner?.didWrite(specID: id, received: totalBytesWritten, expected: totalBytesExpectedToWrite) }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let id = downloadTask.taskDescription
        let status = (downloadTask.response as? HTTPURLResponse)?.statusCode ?? 200
        if let spec = id.flatMap(LocalModelCatalog.spec(id:)) {
            let staged = store.stagedURL(spec)
            try? store.prepare()
            try? FileManager.default.removeItem(at: staged)
            try? FileManager.default.moveItem(at: location, to: staged)
        }
        Task { @MainActor [weak owner] in owner?.didStage(specID: id, httpStatus: status) }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error else { return }
        let id = task.taskDescription
        let resume = (error as NSError).userInfo[NSURLSessionDownloadTaskResumeData] as? Data
        Task { @MainActor [weak owner] in owner?.didFail(specID: id, error: error, resumeData: resume) }
    }

    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        Task { @MainActor [weak owner] in owner?.sessionFinishedEvents() }
    }
}
