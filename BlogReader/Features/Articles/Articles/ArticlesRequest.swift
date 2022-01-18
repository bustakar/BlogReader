import Foundation

// MARK: Request for fetching articles from API
struct ArticlesRequest: NetworkRequestProtocol {
    
    var url: String {
        let path = "/articles.json"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    struct ArticlesResponse: Codable {
        var articles: [Article]
        var page: Int
    }
    
    func decode(_ data: Data) throws -> ArticlesResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(ArticlesResponse.self, from: data)
    }
    
}



