import CoreData

extension NSManagedObjectModel {
    
    // MARK: Helps with testing (inMemory Core Data sometimes crashes without this)
    static let sharedModel: NSManagedObjectModel = {
        let url = Bundle(for: PersistentContainer.self).url(forResource: PersistentContainer.modelName, withExtension: "momd")!
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Managed object model could not be created.")
        }
        return managedObjectModel
    }()
    
}
