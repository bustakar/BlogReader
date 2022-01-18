import SwiftUI

struct ArticleDetailView: View {
    
    @StateObject private var viewModel: ArticleDetailViewModel
    
    init(article: Article) {
        self._viewModel = StateObject(wrappedValue: ArticleDetailViewModel(article: article))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(viewModel.article.imageUrl ?? "placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 320)
                
                HStack {
                    Text(viewModel.article.title)
                    Spacer()
                    Text(viewModel.article.createdAt.pretty())
                }
                .font(.headline)
                
                Text(viewModel.article.content)
            }
            .padding()
        }
        .navigationTitle("Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.handleFavorites()
                }, label: {
                    Image(systemName: viewModel.article.isFavorite ? "heart.fill" : "heart")
                })
            }
        }
    }
    
}
