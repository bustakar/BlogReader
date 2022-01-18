import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        ArticlesListView(
            articles: viewModel.searchResults,
            searchedText: $viewModel.searchedText
        )
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.loadFavorites()
        }
    }
    
}
