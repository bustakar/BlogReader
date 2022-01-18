import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published var isUserLogged: Bool = true
    @Published var isShowingLoginSheet: Bool = false
    
    func logout() {
        isUserLogged = false
    }
    
}
