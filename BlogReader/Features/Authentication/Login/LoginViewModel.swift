import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var user: User = User.empty()
    @Published var isUserLogged: Bool = false
    @Published var isShowingPassword: Bool = false
    
    var emailValidated: Bool {
        return user.email.isValidEmail()
    }
    
    var validated: Bool {
        return user.email.isEmpty || user.password.isEmpty
    }
    
    func login() {
        isUserLogged = true
    }
    
}
