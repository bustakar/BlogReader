import Foundation

final class ArticlesViewModel: ObservableObject {
    
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
    
    // TODO: Replace loading Dummy Data with fetching from API
    func fetchArticles() {
//        Task {
//            let response = try await networkService.request(ArticlesRequest())
//            articles.append(contentsOf: response.articles)
//        }
        
        
        articles = [
            Article(id: "1", title: "Downloading with Combine", content: "Combine is truly awesome framework and in this article we will go through every possible way of downloading data with it. We will use all kinds of publishers. We will filter data and handle errors in Combine way.", imageUrl: "1", isFavorite: false, createdAt: Date(), updatedAt: Date()),
            Article(id: "2", title: "Downloading with Combine", content: "Combine is truly awesome framework and in this article we will go through every possible way of downloading data with it. We will use all kinds of publishers. We will filter data and handle errors in Combine way.", imageUrl: "2", isFavorite: true, createdAt: Date(), updatedAt: Date()),
            Article(id: "3", title: "Downloading with Combine", content: "Combine is truly awesome framework and in this article we will go through every possible way of downloading data with it. We will use all kinds of publishers. We will filter data and handle errors in Combine way.", imageUrl: "3", isFavorite: false, createdAt: Date(), updatedAt: Date()),

        ]
    }
    
}
