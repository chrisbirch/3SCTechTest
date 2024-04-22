import SwiftUI

struct DownloadingView: View {

    var body: some View {
        VStack(alignment: .center) {
            ProgressView()
            Text("Please wait")
                .font(.largeTitle)
            Text("Downloading")
                .font(.body)

        }
    }
}
