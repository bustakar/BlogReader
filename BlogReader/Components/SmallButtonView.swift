import SwiftUI

struct SmallButtonView: View {
    
    let text: String
    let accentColor: Bool
    
    var body: some View {
        Text(text)
            .fontWeight(accentColor ? .semibold : .regular)
            .foregroundColor(accentColor ? Color("Secondary") : .accentColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(accentColor ? Color.accentColor : Color("Shade10"))
            .cornerRadius(8)
    }
    
}
