import Combine
import CoreData

// MARK: Generic Repository with all necessary operations for Core Data
class BaseRepository: CoreDataProtocol {
    
    private func findById<T: NSManagedObject>(id: String, context: NSManagedObjectContext) throws -> T? {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        return try context.fetch(request).first as? T
    }
    
    func create<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> T {
        return type.init(context: context)
    }
    
    func fetch<T: NSManagedObject>(type: T.Type, id: String, context: NSManagedObjectContext) -> T? {
        do {
            return try self.findById(id: id, context: context)
        } catch {
            print("Error fetching object. Error: \(error)")
            return nil
        }
        
    }
    
    func fetchAll<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> [T] {
        do {
            let request = T.fetchRequest()
            return try context.fetch(request) as! [T]
        } catch {
            print("Error fetching objects. Error: \(error)")
            return []
        }
    }
    
    func fetchAll<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?)  -> [T] {
        do {
            let request = T.fetchRequest()
            request.sortDescriptors = sortDescriptors
            request.predicate = predicate
            return try context.fetch(request) as! [T]
        } catch {
            print("Error fetching objects. Error: \(error)")
            return []
        }
    }
    
    func subscribe<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext) -> AnyPublisher<[T], Error> {
        let request = T.fetchRequest() as! NSFetchRequest<T>
        return CDPublisher<T>(
            request: request,
            context: PersistentContainer.shared.viewContext
        )
            .tryMap( { $0 } )
            .eraseToAnyPublisher()
    }
    
    func subscribe<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> AnyPublisher<[T], Error> {
        let request = T.fetchRequest() as! NSFetchRequest<T>
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        return CDPublisher<T>(
            request: request,
            context: PersistentContainer.shared.viewContext
        )
            .tryMap( { $0 } )
            .eraseToAnyPublisher()
    }
    
    func add<T: NSManagedObject>(object: T, context: NSManagedObjectContext) async throws {
        try await context.perform {
            context.insert(object)
            try context.saveIfNeeded()
        }
    }
    
    @discardableResult
    func update<T: NSManagedObject>(object: T, context: NSManagedObjectContext) async throws -> T {
        try await context.perform {
            try context.saveIfNeeded()
            return object
        }
    }
    
    @discardableResult
    func delete<T: NSManagedObject>(type: T.Type, id: String, context: NSManagedObjectContext) async throws -> Bool {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        guard let object = try context.fetch(request).first as? T else {
            return false
        }
        try await context.perform {
            context.delete(object)
            try context.saveIfNeeded()
        }
        return true
    }
    
}
