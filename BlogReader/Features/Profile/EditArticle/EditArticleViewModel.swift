import Foundation
import SwiftUI

final class EditArticleViewModel: ObservableObject {
    
    @Published var article: Article
    @Published var selectedImage: UIImage?
    
    var image: UIImage {
        return selectedImage ?? UIImage(named: "placeholder")!
    }
    
    var titleValidated: Bool {
        article.title.count < 5
    }
    
    var validated: Bool {
        return titleValidated || article.content.isEmpty
    }
    
    init(
        article: Article
    ) {
        self.article = article
    }
    
    func saveDraft() {
        
    }
    
    func publishArticle() {
        
    }
    
}
