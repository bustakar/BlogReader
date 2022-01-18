import Foundation

struct User: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var email: String
    var password: String
    
}

extension User {
    static func empty() -> User {
        return User(
            name: "",
            email: "",
            password: ""
        )
    }
}
