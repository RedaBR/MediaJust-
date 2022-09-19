
import Foundation

// MARK: - Media
struct MediaInfos:Codable {
    let pagination: Pagination?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum :Codable{
    let author: String?
    let title, datumDescription: String?
    let url: String?
    let source: String?
    let category, language, country, publishedAt: String?
}

// MARK: - Pagination
struct Pagination:Codable {
    let limit, offset, count, total: Int?
}
