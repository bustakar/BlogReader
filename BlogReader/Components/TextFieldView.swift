import SwiftUI

struct TextFieldView<Validation: View>: View {
    
    let title: String
    @Binding var text: String
    
    let validation: Validation
    
    init(
        title: String,
        text: Binding<String>,
        @ViewBuilder validation: () -> Validation)
    {
        self.title = title
        self._text = text
        self.validation = validation()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(title)
                Spacer()
                validation
            }
            TextField("", text: $text)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
        }
    }
    
}
