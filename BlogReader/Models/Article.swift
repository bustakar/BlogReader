import CoreData
import Foundation

// MARK: Domain Model used for interaction with user
struct Article: Identifiable, Codable {
    
    // MARK: Using UUID so model is independent of Core Data
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var imageUrl: String?
    var isFavorite: Bool
    var createdAt: Date
    var updatedAt: Date
    
}

extension Article {
    static func empty() -> Article {
        return Article(
            title: "",
            content: "",
            imageUrl: "placeholder",
            isFavorite: false,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}

// MARK: Function to transform Domain Model to Core Data Model
extension Article {
    func toObject(context: NSManagedObjectContext) -> CDArticle {
        let cdArticle = CDArticle(context: context)
        cdArticle.id = id
        cdArticle.title = title
        cdArticle.content = content
        cdArticle.imageUrl = imageUrl
        cdArticle.isFavorite = isFavorite
        cdArticle.createdAt = createdAt
        cdArticle.updatedAt = updatedAt
        return cdArticle
    }
}

// MARK: Function to transform Core Data Model to Domain Model
extension CDArticle {
    func toModel() -> Article {
        return Article(
            id: id,
            title: title,
            content: content,
            imageUrl: self.imageUrl,
            isFavorite: self.isFavorite,
            createdAt: createdAt,
            updatedAt: updatedAt)
    }
}

