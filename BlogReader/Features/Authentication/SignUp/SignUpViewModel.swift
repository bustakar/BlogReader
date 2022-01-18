import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var user: User = User.empty()
    @Published var confirmPassword: String = ""
    @Published var isUserLogged: Bool = false
    @Published var isShowingPassword: Bool = false
    
    var emailValidated: Bool {
        return user.email.isValidEmail()
    }

    var passwordValidated: Bool {
        return user.password.count > 7 && user.password == confirmPassword
    }

    var validated: Bool {
        return user.email.isEmpty || passwordValidated
    }

    func login() {
        isUserLogged = true
    }
    
}
