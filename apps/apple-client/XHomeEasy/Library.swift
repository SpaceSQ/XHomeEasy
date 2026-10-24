import Foundation
import XHomeEasyEngines

struct BrandEntry: Codable, Identifiable, Hashable {
    var id: String
    var brand: String
    var category: String
    var title: String
    var summary: String
    var tier: String
    var url: String
    var fetchedOn: String
}

struct CaseEntry: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var category: String
    var brands: [String]
    var geography: String
    var practiceLabel: String?
    var tier: String
    var url: String
    var note: String
    var fetchedOn: String
}

struct FusionEntry: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var category: String
    var brands: [String]
    var tier: String
    var region: String
    var practiceLabel: String?
    var pattern: String
    var summary: String
    var takeaway: String
    var url: String
    var sourceName: String
    var fetchedOn: String
}

struct SubsystemEntry: Codable, Identifiable, Hashable {
    var id: String
    var category: String
    var brand: String
    var subsystem: String
    var title: String
    var tier: String
    var region: String
    var practiceLabel: String?
    var mentionsLegacy: Bool
    var legacyBrands: [String]
    var fit: String
    var takeaway: String
    var summary: String
    var url: String
    var fetchedOn: String
}

struct PartnerEntry: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var brands: [String]
    var city: String
    var state: String
    var country: String
    var phone: String
    var email: String
    var website: String
    var tier: String
    var url: String
    var certs: [String]
    var fetchedOn: String
    var sponsored: Bool
}

struct LibraryManifest: Codable {
    var verifiedOn: String
    var counts: [String: Int]
    var states: [String]
}

struct Library {
    var manifest: LibraryManifest
    var brands: [BrandEntry]
    var cases: [CaseEntry]
    var fusion: [FusionEntry]
    var subsystems: [SubsystemEntry]
    var partners: [PartnerEntry]
    var radarRecords: [RadarRecord]
    var radarIndex: KeywordRadarIndex
}

enum LibraryLoader {
    static func load() throws -> Library {
        let manifest = try decode(LibraryManifest.self, "manifest")
        return Library(
            manifest: manifest,
            brands: try decode([BrandEntry].self, "brands"),
            cases: try decode([CaseEntry].self, "cases"),
            fusion: try decode([FusionEntry].self, "fusion"),
            subsystems: try decode([SubsystemEntry].self, "subsystems"),
            partners: try decode([PartnerEntry].self, "partners"),
            radarRecords: try decode([RadarRecord].self, "radar-records"),
            radarIndex: try decode(KeywordRadarIndex.self, "keyword_radar_index")
        )
    }

    private static func decode<T: Decodable>(_ type: T.Type, _ name: String) throws -> T {
        guard let url = resource(name) else { throw CocoaError(.fileNoSuchFile) }
        return try JSONDecoder().decode(T.self, from: Data(contentsOf: url))
    }

    private static func resource(_ name: String) -> URL? {
        let subdirectories = ["Resources/OfflineKnowledgeBundle", "OfflineKnowledgeBundle", nil as String?]
        for subdirectory in subdirectories {
            if let url = Bundle.main.url(forResource: name, withExtension: "json", subdirectory: subdirectory) {
                return url
            }
        }
        return nil
    }
}

enum EvidenceRank {
    static func sortKey(_ tier: String) -> Int {
        switch tier {
        case "E1": return 0
        case "E2": return 1
        case "E3": return 2
        default: return 3
        }
    }
}
