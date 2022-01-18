import SwiftUI

// MARK: Every view inside this container will open Image Picker when tapped
struct ImagePickerContainerView<Content: View>: View {
    
    @Binding var image: UIImage?
    @State private var isShowingImagePicker = false
    
    let content: Content
    
    init(
        image: Binding<UIImage?>,
        @ViewBuilder content: () -> Content
    ) {
        self._image = image
        self.content = content()
    }
    
    var body: some View {
        content
            .onTapGesture {
                isShowingImagePicker.toggle()
            }
            .sheet(
                isPresented: $isShowingImagePicker,
                content: {
                    ImagePicker(image: $image)
                })
    }
    
}
