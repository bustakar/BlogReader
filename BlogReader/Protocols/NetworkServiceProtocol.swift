import Combine
import Foundation

enum NetworkServiceError: String, Error {
    case invalidEndpoint = "Invalid Endpoint"
}

// MARK: Protocol defining all necessary function to make network requests
protocol NetworkServiceProtocol {
    
    func request<Request: NetworkRequestProtocol>(_ request: Request) async throws -> Request.Response
    
    func request<Request: NetworkRequestProtocol>(_ request: Request) -> AnyPublisher<Request.Response, NetworkServiceError>
    
}
