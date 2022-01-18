import SwiftUI

struct SecureFieldView: View {
    
    let title: String
    @Binding var text: String
    @Binding var isShowingPassword: Bool
    
    init(
        title: String,
        text: Binding<String>,
        isShowingPassword: Binding<Bool>)
    {
        self.title = title
        self._text = text
        self._isShowingPassword = isShowingPassword
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                Spacer()
                Button(action: {
                    isShowingPassword.toggle()
                }, label: {
                    Image(systemName: isShowingPassword ? "lock.open.fill" : "lock.fill")
                })
            }
            Group {
                if isShowingPassword {
                    TextField("", text: $text)
                } else {
                    SecureField("", text: $text)
                }
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
    }
    
}















