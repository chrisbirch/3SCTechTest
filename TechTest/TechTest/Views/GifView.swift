import SwiftUI
import FLAnimatedImage
struct GifView: UIViewRepresentable {
    @Binding var gifData : Data
    func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIView {
        let view = FLAnimatedImageView()
        view.contentMode = .scaleAspectFit
        update(imageView: view)
        return view
    }
    private func update(imageView: FLAnimatedImageView) {
        let gif = FLAnimatedImage (animatedGIFData: gifData)
        imageView.animatedImage = gif
    }
 
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let view = uiView as? FLAnimatedImageView else { return }
        update(imageView: view)
    }
}
