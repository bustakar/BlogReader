import SwiftUI

struct ArticleCardView: View {
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(article.imageUrl ?? "placeholder")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 320)
            HStack {
                Text(article.title)
                Spacer()
                Text(article.createdAt.pretty())
            }
            .font(.headline)
            Text(article.content)
                .foregroundColor(Color("Shade75"))
                .lineLimit(3)
        }
    }
    
}
