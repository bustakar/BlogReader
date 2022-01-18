import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()
    
    // MARK: Shows different views depending on user activity
    var body: some View {
        if viewModel.isUserLogged {
            content
        } else {
            loginMessage
        }
    }
    
    var content: some View {
        VStack(alignment: .center, spacing: 48) {
            VStack {
                // TODO: Probably fetch image from some source through AsyncImage API
                Image("user-image")
                    .frame(width: 200, height: 200)
                Text("betterwriter@email.com")
                    .font(.headline)
            }
            
            VStack {
                NavigationLink(
                    destination: YourArticlesView()
                ) {
                    BigButtonView(imageName: "books.vertical", text: "Your Articles")
                }
                
                NavigationLink(
                    destination: EditArticleView(article: Article.empty())
                        .navigationTitle("Create Article")
                ) {
                    BigButtonView(imageName: "plus.square", text: "Create Article")
                }
            }
            .tint(Color("Primary"))
        }
        .padding()
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(
                placement: .navigationBarTrailing,
                content: {
                    Button(
                        action: {
                            viewModel.logout()
                        },
                        label: {
                            Text("Log Out")
                        })
                })
        }
    }
    
    var loginMessage: some View {
        Text("Please Log In by clicking button in top right corner.")
            .multilineTextAlignment(.center)
            .padding()
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing,
                    content: {
                        Button(
                            action: {
                                viewModel.isShowingLoginSheet.toggle()
                            },
                            label: {
                                Text("Log In")
                            })
                    })
            }
            .sheet(
                isPresented: $viewModel.isShowingLoginSheet,
                content: {
                    NavigationView {
                        LoginView(isUserLogged: $viewModel.isUserLogged)
                    }
                })
    }
        
    
}
