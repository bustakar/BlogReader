import SwiftUI

struct BigButtonView: View {
    
    let imageName: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 24, height: 24)
            Text(text)
                .font(.headline)
            Spacer()
        }
        .padding()
        .background(Color("Shade10"))
        .cornerRadius(8)
    }
    
}
