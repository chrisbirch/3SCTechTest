import SwiftUI
import Kingfisher
import FLAnimatedImage

///Downloads images for gif, png, jpg, jpeg
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
    let url: URL
  
    private var gifDownloaderTask: Task<(), Never>? = nil
    @State private var viewState: ViewState = .idle
    @Inject private var networkService: NetworkService
    
    init(width: CGFloat, height: CGFloat, url: URL) {
        self.width = width
        self.height = height
        self.url = url
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
                        .frame(width: width * 0.5, height: height * 0.5)
                
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
                    .frame(width: width, height: height)
            case .unsupportedImage(let typeName):
                HStack{
                    Spacer()
                    Text("Soon support\n.\(typeName) files")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .lineLimit(4)
                        
                        
                    Spacer()
                }
                .background {
                    Color.detailSectionBackgroundColour
                }.cornerRadius(.spacer8)
                    .padding(.spacer2)
            }
                
                Spacer()
            }
        .frame(width: width, height: height)
        .task {
            let imageExension = url.pathExtension.lowercased()
            if imageExension == "gif" {
                viewState = .downloadingGif
                let request = URLRequest(url: url)
                do {
                    let gifData = try await networkService.request(request)
                    withAnimation {
                        viewState = .downloadedGif(gifData)
                    }
                } catch {
                    withAnimation {
                        viewState = .errorDownloadingGif
                    }
                }
            } else if supportedMativeImageTypes.contains(imageExension)  {
                withAnimation {
                    viewState = .normalImage
                }
            } else {
                withAnimation {
                    viewState = .unsupportedImage(typeName: imageExension)
                }
            }
        }
    }
}
