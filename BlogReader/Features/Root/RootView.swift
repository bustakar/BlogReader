import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel: RootViewModel = RootViewModel()
    
    var body: some View {
        /*
            Reason for adding each subview into NavigationView right in Tab View is to keep subview reusable 
         */
        TabView(selection: $viewModel.selectedTab) {
            NavigationView {
                ArticlesView()
            }
            .navigationViewStyle(.stack)
            .tag(Tab.articles)
            .tabItem {
                Label(Tab.articles.rawValue, systemImage: Tab.articles.imageName)
            }
            
            NavigationView {
                FavoritesView()
            }
            .navigationViewStyle(.stack)
            .tag(Tab.favorites)
            .tabItem {
                Label(Tab.favorites.rawValue, systemImage: Tab.favorites.imageName)
            }
            
            NavigationView {
                ProfileView()
            }
            .navigationViewStyle(.stack)
            .tag(Tab.profile)
            .tabItem {
                Label(Tab.profile.rawValue, systemImage: Tab.profile.imageName)
            }
        }
        .tint(.accentColor)
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
