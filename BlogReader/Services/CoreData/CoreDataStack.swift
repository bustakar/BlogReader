import CoreData

final class PersistentContainer: NSPersistentContainer {
    
    static let modelName = "Blog"
    
    static let shared = PersistentContainer(name: modelName, managedObjectModel: .sharedModel)
    
    private override init(name: String, managedObjectModel: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: managedObjectModel)
        self.setup()
    }
    
    func setup() {
        loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print("Error loading persistent store. Error: \(error)")
            }
        })
        
        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.name = "background_context"
        context.transactionAuthor = "main_app_background_context"
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
}
