import SwiftUI

struct ContentView: View {
    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            iPadContentView()
        case .phone:
            iPhoneContentView()
        default:
            Text("Sorry but the current platform isnt yet supported")
        }
    }
}
