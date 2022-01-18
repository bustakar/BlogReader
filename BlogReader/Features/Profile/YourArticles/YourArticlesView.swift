import SwiftUI

struct YourArticlesView: View {
    
    @StateObject private var viewModel: YourArticlesViewModel = YourArticlesViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.searchResults) { article in
                NavigationLink(
                    destination: EditArticleView(article: article)
                        .navigationTitle("Edit Article")
                ) {
                    ArticleCardView(article: article)
                        .padding(.vertical)
                }
            }
        }
        .listStyle(PlainListStyle())
        .searchable(text: $viewModel.searchedText, prompt: "Search...")
        .navigationTitle("Your Articles")
    }
    
}
