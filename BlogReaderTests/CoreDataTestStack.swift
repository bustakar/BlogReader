import BlogReader
import CoreData

final class TestContainer: NSPersistentContainer {
    
    static let modelName = "Blog"
    
    convenience init() {
        self.init()
        self.setup()
    }
    
    func setup() {
        
        persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        
        loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print("Error loading test store. Error: \(error)")
            }
        })
        
        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.name = "background_context"
        context.transactionAuthor = "test_background_context"
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
}
