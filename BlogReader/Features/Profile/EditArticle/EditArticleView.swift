import SwiftUI

struct EditArticleView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: EditArticleViewModel
    
    init(
        article: Article
    ) {
        self._viewModel = StateObject(wrappedValue: EditArticleViewModel(article: article))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            ImagePickerContainerView(image: $viewModel.selectedImage) {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFill()
            }
            .frame(maxWidth: .infinity, maxHeight: 280)
            
            TextFieldView(title: "Title", text: $viewModel.article.title, validation: {
                Text("Must be atleast 5 characters")
                    .opacity(viewModel.titleValidated ? 0 : 0.75)
            })
            
            VStack(alignment: .leading) {
                Text("Content")
                TextEditor(text: $viewModel.article.content)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
            }
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    SmallButtonView(text: "Cancel", accentColor: false)
                })
                Button(action: {
                    viewModel.saveDraft()
                }, label: {
                    SmallButtonView(text: "Save Draft", accentColor: false)
                })
            }
            
            Button(action: {
                viewModel.publishArticle()
            }, label: {
                SmallButtonView(text: "Publish", accentColor: true)
            })
                .disabled(viewModel.validated)
        }
        .tint(.accentColor)
        .padding()
        .padding(.bottom, 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: ArticleDetailView(
                        article: viewModel.article),
                    label: {
                        Text("Preview")
                    })
            }
        }
    }
    
}
