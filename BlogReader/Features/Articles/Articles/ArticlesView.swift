import SwiftUI

// MARK:
struct ArticlesView: View {
    
    @StateObject private var viewModel: ArticlesViewModel = ArticlesViewModel()
    
    var body: some View {
        ArticlesListView(
            articles: viewModel.searchResults,
            searchedText: $viewModel.searchedText
        )
        .navigationTitle("Articles")
    }
    
}
