import Foundation

// MARK: Protocol defining all components needed to build proper network request
protocol NetworkRequestProtocol {
    
    associatedtype Response
    
    var baseURL: String { get }
    
    var url: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String : String] { get }
    
    var queryItems: [String : String] { get }
    
    
    func decode(_ data: Data) throws -> Response
}
