import SwiftUI
import FLAnimatedImage
struct GifView: UIViewRepresentable {
    @Binding var gifData : Data
    func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIView {
        let view = UIView()
        let flImageView = FLAnimatedImageView()
        flImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flImageView)
        NSLayoutConstraint.activate([
            flImageView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            flImageView.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            flImageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9),
            flImageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.9)
        ])
        
        update(imageView: flImageView)
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
