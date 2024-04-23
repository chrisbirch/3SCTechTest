import SwiftUI
import Kingfisher

struct ImageDownloaderView: View {
    let width: CGFloat
    let height: CGFloat
    let url: URL
    
    var body: some View {
        VStack {
            Spacer()
            KFImage(url)
                .placeholder {
                    ProgressView().frame(maxWidth: width, maxHeight: height)
                }
                .resizable()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: width, maxHeight: height)
            Spacer()
        }
        .frame(maxWidth: width, maxHeight: height)
    }
}
