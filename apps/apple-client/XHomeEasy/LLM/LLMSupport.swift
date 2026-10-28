import Foundation

/// Language tag for the copied Dear Earth strings. This app shows Chinese and English.
enum ContentLanguage: String, Codable, Sendable {
    case en
    case zh
    case de
}

enum AppLanguage {
    /// Set from the main actor before a download or a chat turn. Read by `tr` on that same actor.
    nonisolated(unsafe) static var resolved: ContentLanguage = .en
}

func tr(_ en: String, _ zh: String) -> String {
    AppLanguage.resolved == .zh ? zh : en
}

func tr(_ en: String, _ zh: String, in language: ContentLanguage) -> String {
    language == .zh ? zh : en
}

struct ChatTurn: Sendable, Equatable {
    enum Role: String, Sendable { case user, assistant }
    let role: Role
    let content: String
    var id: UUID? = nil
}
