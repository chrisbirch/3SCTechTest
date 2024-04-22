import SwiftUI

struct ImageDownloaderView: View {
    let width: CGFloat
    let height: CGFloat
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                .aspectRatio(contentMode: .fit)
            case .failure(let error):
                let _ = print(error)
                Text("error: \(error.localizedDescription)")
            case .empty:
                ProgressView()
            @unknown default:
                fatalError()
            }
        }.frame(maxWidth: width, maxHeight: height)
        
    }
}
