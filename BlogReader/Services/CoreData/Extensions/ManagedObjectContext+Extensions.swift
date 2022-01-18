import CoreData

extension NSManagedObjectContext {
    
    // MARK: Checks if context has unsaved changes and saves them
    @discardableResult
    public func saveIfNeeded() throws -> Bool {
        guard hasChanges else {
            return false
        }
        try save()
        return true
    }
    
}
