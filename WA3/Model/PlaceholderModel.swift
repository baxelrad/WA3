import Foundation


struct PlaceholderResponse: Decodable{
    let placeholders: [Placeholder]
    enum CodingKeys: String, CodingKey{
        case placeholders = "JSON"
    }
}

struct Placeholder: Decodable{
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey{
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
