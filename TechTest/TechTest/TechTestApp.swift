import SwiftUI

@main
struct TechTestApp: App {
    init() {
        let resolver = DependencyResolver.shared
        resolver.add(NetworkServiceImplementation() as NetworkService)
        resolver.add(PokemonStorageServiceImplementation() as PokemonStorageService)
        resolver.add(PokemonServiceImplementation() as PokemonService)
    }
    @StateObject private var applicationViewModel = ApplicationViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(applicationViewModel)
        }
    }
}
