import Combine
import Foundation

final class FavoritesViewModel: ObservableObject {
    
    private let repository: CoreDataProtocol
    
    @Published var favorites: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchedText: String = ""
    
    // MARK: Computed variable for filtering searched text
    var searchResults: [Article] {
        if searchedText.isEmpty {
            return favorites
        } else {
            return favorites.filter { $0.title.localizedCaseInsensitiveContains(searchedText) }
        }
    }
    
    // MARK: Passing service as constructor parameter
    init(repository: CoreDataProtocol = BaseRepository()) {
        self.repository = repository
        self.loadFavorites()
        
//        self.subscribeToFavorites()
    }
    
    // MARK: Loads Favorites from Core Data DB
    func loadFavorites() {
        self.favorites = repository.fetchAll(
            type: CDArticle.self,
            context: PersistentContainer.shared.viewContext
        )
            .map {  $0.toModel() }
    }
    
    // MARK: Subscribing to Favorites publisher
    // FIXME: Still not 100% functional
    func subscribeToFavorites() {
        repository.subscribe(
            type: CDArticle.self,
            context: PersistentContainer.shared.viewContext
        )
            .map { $0.map { $0.toModel() } }
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Failed to subscribe to favorites. Error: \(error)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] receivedFavorites in
                    print("Getting values: \(receivedFavorites)")
                    self?.favorites = receivedFavorites
                })
            .store(in: &cancellables)
    }
}
