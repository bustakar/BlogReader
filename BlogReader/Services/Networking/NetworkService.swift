import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: Building request from components
    private func buildRequest<Request: NetworkRequestProtocol>(request: Request) throws -> URLRequest {
        
        guard var components = URLComponents(string: request.url) else {
            throw NSError(
                domain: NetworkServiceError.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NSError(
                domain: NetworkServiceError.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        return urlRequest
    }
    
    // MARK: Async request
    func request<Request: NetworkRequestProtocol>(_ request: Request) async throws -> Request.Response {
        
        let (data, _) = try await URLSession.shared.data(for: buildRequest(request: request))
        
        let decodedData = try request.decode(data)
        return decodedData
    }
    
    // MARK: Publisher for request
    func request<Request: NetworkRequestProtocol>(_ request: Request) -> AnyPublisher<Request.Response, NetworkServiceError> {
        do {
            return try URLSession.shared.dataTaskPublisher(for: buildRequest(request: request))
                .tryMap { response in
                    try request.decode(response.data)
                }
                .mapError { error -> NetworkServiceError in
                    NetworkServiceError.invalidEndpoint
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail<Request.Response, NetworkServiceError>(error: NetworkServiceError.invalidEndpoint)
                .eraseToAnyPublisher()
        }
        
    }
    
}
