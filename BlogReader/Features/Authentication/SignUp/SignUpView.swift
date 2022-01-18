import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: SignUpViewModel = SignUpViewModel()
    @Binding var isUserLogged: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            
            TextFieldView(title: "Name", text: $viewModel.user.email, validation: {})
            
            TextFieldView(title: "Email", text: $viewModel.user.email, validation: {
                Text("Must be in correct form")
                    .opacity(viewModel.emailValidated ? 0 : 0.75)
            })
            
            SecureFieldView(title: "Password", text: $viewModel.user.password, isShowingPassword: $viewModel.isShowingPassword)
            SecureFieldView(title: "Confirm Password", text: $viewModel.confirmPassword, isShowingPassword: $viewModel.isShowingPassword)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    SmallButtonView(text: "Cancel", accentColor: false)
                })
                Button(action: {
                    viewModel.login()
                }, label: {
                    SmallButtonView(text: "Sign Up", accentColor: true)
                })
                    .disabled(viewModel.validated)
            }
            
            
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
