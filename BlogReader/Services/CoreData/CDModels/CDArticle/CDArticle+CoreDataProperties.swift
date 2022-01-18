import CoreData
import Foundation

extension CDArticle {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }
    
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var imageUrl: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    
}

extension CDArticle: Identifiable {
    
}



