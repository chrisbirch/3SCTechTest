import SwiftUI
import Kingfisher
import FLAnimatedImage

struct ImageDownloaderView: View {
    private enum ViewState {
        case idle
        case errorDownloadingGif
        case downloadingGif
        case downloadedGif(Data)
        case normalImage
        case unsupportedImage(typeName: String)
    }
    private let supportedMativeImageTypes = [
        "png",
        "jpeg",
        "jpg"
    ]
    let width: CGFloat
    let height: CGFloat
    @Binding var url: URL
  
    private var gifDownloaderTask: Task<(), Never>? = nil
    @State private var viewState: ViewState = .idle
    @Inject private var networkService: NetworkService
    
   
    
    init(width: CGFloat, height: CGFloat, url: Binding<URL>) {
        self.width = width
        self.height = height
        self._url = url
    }
    
    private var progressView: some View {
        ProgressView().frame(maxWidth: width, maxHeight: height)
    }
    
    var body: some View {
        VStack {
            Spacer()
            switch viewState {
            case .errorDownloadingGif, .idle:
                Image.noIcon
                    .frame(maxWidth: width, maxHeight: height)
            case .downloadingGif:
                progressView
            case .downloadedGif(let gifData):
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        GifView(gifData: .constant(gifData))
                        Spacer()
                    }
                    Spacer()
                }.frame(width: width, height: height)
                    
            case .normalImage:
                KFImage(url)
                    .placeholder {
                        progressView
                    }
                    .resizable()
                    .fade(duration: 0.25)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: width, maxHeight: height)
            case .unsupportedImage(let typeName):
                HStack{
                    Spacer()
                    Text("Coming soon\nSupport for .\(typeName) files")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
                
                Spacer()
            }
        .frame(maxWidth: width, maxHeight: height)
        .task {
            let imageExension = url.pathExtension.lowercased()
            if imageExension == "gif" {
                viewState = .downloadingGif
                print("\(Date.now) Downloading \(url)")
                let request = URLRequest(url: url)
                do {
                    let gifData = try await networkService.request(request)
                    viewState = .downloadedGif(gifData)
                } catch {
                    viewState = .errorDownloadingGif
                }
            } else if supportedMativeImageTypes.contains(imageExension)  {
                viewState = .normalImage
            } else {
                viewState = .unsupportedImage(typeName: imageExension)
            }
        }
    }
}
