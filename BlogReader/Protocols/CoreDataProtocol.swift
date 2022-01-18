import Combine
import CoreData
import Foundation

// MARK: Core Data Protocol defining all necessary functions
protocol CoreDataProtocol {
    
    func create<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> T
    
    func fetch<T: NSManagedObject>(type: T.Type, id: String, context: NSManagedObjectContext) -> T?
    
    func fetchAll<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> [T]
    
    func fetchAll<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor],
                  predicate: NSPredicate?) -> [T]
    
    func subscribe<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> AnyPublisher<[T], Error>
    
    func subscribe<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> AnyPublisher<[T], Error>
    
    func add<T: NSManagedObject>(object: T, context: NSManagedObjectContext) async throws
    
    @discardableResult
    func update<T: NSManagedObject>(object: T, context: NSManagedObjectContext) async throws -> T
    
    @discardableResult
    func delete<T: NSManagedObject>(type: T.Type, id: String, context: NSManagedObjectContext) async throws -> Bool
    
}
