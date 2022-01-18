import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    @Binding var isUserLogged: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            
            TextFieldView(title: "Email", text: $viewModel.user.email, validation: {
                Text("Must be in correct form")
                    .opacity(viewModel.emailValidated ? 0 : 0.75)
            })
            
            SecureFieldView(title: "Password", text: $viewModel.user.password, isShowingPassword: $viewModel.isShowingPassword)
            
            HStack {
                Button(
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        SmallButtonView(text: "Cancel", accentColor: false)
                    })
                NavigationLink(
                    destination: SignUpView(isUserLogged: $viewModel.isUserLogged),
                    label: {
                        SmallButtonView(text: "Sign Up", accentColor: false)
                    })
            }
            
            
            Button(
                action: {
                viewModel.login()
            }, label: {
                SmallButtonView(text: "Login", accentColor: true)
            })
                .disabled(viewModel.validated)
        }
        .padding()
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(
            of: viewModel.isUserLogged,
            perform: { newValue in
                isUserLogged = newValue
            })
    }
    
}
