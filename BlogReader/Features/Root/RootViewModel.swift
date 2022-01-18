import Foundation

enum Tab: String {
    
    case articles = "Articles"
    case favorites = "Favorites"
    case profile = "Profile"
    
    var imageName: String {
        switch self {
        case .articles:
            return "book"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
}

final class RootViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .articles
    
}
