import Foundation


final class ArticleDetailViewModel: ObservableObject {
    
    private let repository: CoreDataProtocol
    
    @Published var article: Article
    
    // MARK: Passing service as construtor parameter
    init(
        repository: CoreDataProtocol = BaseRepository(),
        article: Article
    ) {
        self.repository = repository
        self.article = article
        
        self.checkIfFavorite()
    }
    
    // MARK: Tries to find article in Core Data saved articles
    private func checkIfFavorite() {
        guard let fetchedArticle = repository.fetch(
            type: CDArticle.self,
            id: article.id,
            context: PersistentContainer.shared.viewContext
        ) else {
            article.isFavorite = false
            return
        }
        article.isFavorite = fetchedArticle.isFavorite
    }
    
    // MARK: Add/remove article to/from favorites
    func handleFavorites() {
        if article.isFavorite {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
        article.isFavorite.toggle()
    }
    
    // MARK: Async function to add article to Favorites
    private func addToFavorites() {
        Task {
            let context = PersistentContainer.shared.newBackgroundContext()
            try await repository.add(
                object: article.toObject(context: context),
                context: context
            )
        }
    }
    
    // MARK: Async function to remove article to Favorites
    private func removeFromFavorites() {
        Task {
            try await repository.delete(
                type: CDArticle.self,
                id: article.id,
                context: PersistentContainer.shared.newBackgroundContext()
            )
        }
    }
}
