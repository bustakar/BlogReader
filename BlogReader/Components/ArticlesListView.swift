import SwiftUI

// MARK: 
struct ArticlesListView: View {
    
    let articles: [Article]
    @Binding var searchedText: String
    
    var body: some View {
        List {
            ForEach(articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleCardView(article: article)
                        .padding(.vertical)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(PlainListStyle())
        .searchable(text: $searchedText, prompt: "Search...")
    }
    
}
