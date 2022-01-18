import Foundation

final class YourArticlesViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    
    @Published var articles: [Article] = []
    
    @Published var searchedText: String = ""
    
    // MARK: Computed variable for filtering searched text
    var searchResults: [Article] {
        if searchedText.isEmpty {
            return articles
        } else {
            return articles.filter { $0.title.localizedCaseInsensitiveContains(searchedText) }
        }
    }
    
    // MARK: Passing service as constructor parameter
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        self.fetchArticles()
    }
    
    // TODO: Func to fetch your articles from API
    func fetchArticles() {
        
    }
    
}
