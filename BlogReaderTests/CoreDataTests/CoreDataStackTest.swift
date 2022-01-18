import CoreData
import XCTest

@testable import BlogReader

class CDStackTest: XCTestCase {
    
    func test_blogReader_CDStack_GetMainThreadContext_ShouldSuccess() {
        let mainContext = PersistentContainer.shared.viewContext
        let expectation = expectation(description: "mainThread")
        
        mainContext.perform {
            XCTAssert(Thread.isMainThread)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Is not on main thread.")
        }
    }
    
    func test_blogReader_CDStack_GetBackgroundThreadContext_ShouldSuccess() {
        let bgContext = PersistentContainer.shared.newBackgroundContext()
        let expectation = expectation(description: "bgThread")
        
        bgContext.perform {
            XCTAssertFalse(Thread.isMainThread)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Is on main thread.")
        }
    }
    
    func test_BlogReader_CDStack_GetMultipleMemoryContexts_ShouldSuccess() {
        let memoryContext1 = TestContainer(name: "test", managedObjectModel: .sharedModel).viewContext
        let memoryContext2 = TestContainer(name: "test", managedObjectModel: .sharedModel).viewContext
        
        XCTAssertFalse(memoryContext1 === memoryContext2)
    }
    
}
