import CoreData
import Foundation
import XCTest

@testable import BlogReader

class BaseRepositoryTests: XCTestCase {
    
    let repository: CoreDataProtocol = BaseRepository()
    var mainContext: NSManagedObjectContext!
    var bgContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        let stack = TestContainer(
            name: TestContainer.modelName,
            managedObjectModel: .sharedModel)
        stack.setup()
        mainContext = stack.viewContext
        bgContext = stack.newBackgroundContext()
    }
    
    override func tearDown() {
        super.tearDown()
        mainContext = nil
        bgContext = nil
    }
    
    func test_BlogReader_BaseRepository_Create_ShouldCreate() throws {
        var article: CDArticle? = nil
        
        article = repository.create(type: CDArticle.self, context: mainContext)
        
        XCTAssertNotNil(article)
    }
    
    func test_BlogReader_BaseRepository_Fetch_ShouldReturnNil() {
        let randomId = UUID().uuidString
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: randomId, context: mainContext)
        
        XCTAssertNil(fetchedArticle)
    }
    
    func test_BlogReader_BaseRepository_Fetch_ShouldReturnEntity() {
        let id = UUID().uuidString
        let expectation = expectation(description: "fetch")
        Task {
            let article = repository.create(type: CDArticle.self, context: bgContext)
            article.id = id
            try await repository.add(object: article, context: bgContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Fetch object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)

        XCTAssert(id == fetchedArticle?.id)
    }
    
    func test_BlogReader_BaseRepository_FetchAll_ShouldReturnEmpty() {
        let fetchedArticles = repository.fetchAll(type: CDArticle.self, context: mainContext)

        XCTAssert(fetchedArticles.isEmpty)
    }
    
    func test_BlogReader_BaseRepository_FetchAll_ShouldReturnAll() {
        var ids = Set<String>()
        for _ in 0..<5 {
            ids.insert(UUID().uuidString)
        }
        for id in ids {
            let expectation = expectation(description: id)
            Task {
                let article = repository.create(type: CDArticle.self, context: mainContext)
                article.id = id
                try await repository.add(object: article, context: mainContext)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Fetch all object failed.")
        }
        
        let fetchedArticlesIds = Set(repository.fetchAll(type: CDArticle.self, context: mainContext).map { $0.id })
        
        XCTAssert(fetchedArticlesIds.isSubset(of: ids))
        
    }
    
    func test_BlogReader_BaseRepository_Add_ShouldAdd_MainThread() {
        let id = UUID().uuidString
        let expectation = expectation(description: "add_main")
        Task {
            let article = repository.create(type: CDArticle.self, context: mainContext)
            article.id = id
            try await repository.add(object: article, context: mainContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Add object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)

        XCTAssert(id == fetchedArticle?.id)
    }
    
    func test_BlogReader_BaseRepository_Add_ShouldAdd_BgThread() {
        let id = UUID().uuidString
        let expectation = expectation(description: "add_bg")
        Task {
            let article = repository.create(type: CDArticle.self, context: bgContext)
            article.id = id
            try await repository.add(object: article, context: bgContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Add object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)

        XCTAssert(id == fetchedArticle?.id)
    }
    
    func test_BlogReader_BaseRepository_Add_ShouldAddMultiple_BgThread() {
        var ids = Set<String>()
        for _ in 0..<500 {
            ids.insert(UUID().uuidString)
        }
        for id in ids {
            let expectation = expectation(description: id)
            Task {
                let article = repository.create(type: CDArticle.self, context: mainContext)
                article.id = id
                try await repository.add(object: article, context: mainContext)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20.0) { error in
            XCTAssertNil(error, "Add all object failed.")
        }
        
        let fetchedArticles = Set(repository.fetchAll(type: CDArticle.self, context: mainContext).map { $0.id })

        XCTAssert(fetchedArticles.isSubset(of: ids))
    }
    
    func test_BlogReader_BaseRepository_Update_ShouldUpdate() {
        let expectation = expectation(description: "update_success")
        let title = "Title", updatedTitle = "Updated title"
        let id = UUID().uuidString
        Task {
            let article = repository.create(type: CDArticle.self, context: mainContext)
            article.id = id
            article.title = title
            try await repository.add(object: article, context: mainContext)
            article.title = updatedTitle
            try await repository.update(object: article, context: mainContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Update object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)
        
        XCTAssert(fetchedArticle?.title == updatedTitle)
    }
    
    func test_BlogReader_BaseRepository_Delete_ShouldNotDelete() {
        let expectation = expectation(description: "delete_fail")
        let id = UUID().uuidString
        Task {
            let article = repository.create(type: CDArticle.self, context: mainContext)
            article.id = id
            try await repository.add(object: article, context: mainContext)
            try await repository.delete(type: CDArticle.self, id: UUID().uuidString, context: mainContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Delete object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)
        
        XCTAssertNotNil(fetchedArticle)
    }
    
    func test_BlogReader_BaseRepository_Delete_ShouldDelete() {
        let expectation = expectation(description: "delete_success")
        let id = UUID().uuidString
        Task {
            let article = repository.create(type: CDArticle.self, context: mainContext)
            article.id = id
            try await repository.add(object: article, context: mainContext)
            try await repository.delete(type: CDArticle.self, id: id, context: mainContext)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Delete object failed.")
        }
        
        let fetchedArticle = repository.fetch(type: CDArticle.self, id: id, context: mainContext)
        
        XCTAssertNil(fetchedArticle)
    }
    
}
