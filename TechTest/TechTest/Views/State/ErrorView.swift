import SwiftUI

struct ErrorView: View {
    let errorText: String
    let action: (() -> Void)
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Error occured")
                .font(.largeTitle)
            Text(errorText)
                .font(.body)

            Button("Try again") {
                action()
            }
        }.padding()
    }

    init(errorText: String, action: @escaping (() -> Void)) {
        self.errorText = errorText
        self.action = action
    }

    init(error: Error, action: @escaping (() -> Void)) {
        self.errorText = String(describing: error)
        self.action = action
    }
}
