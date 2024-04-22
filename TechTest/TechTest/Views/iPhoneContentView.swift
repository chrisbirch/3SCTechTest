import SwiftUI

struct iPhoneContentView: View {
    @EnvironmentObject private var applicationViewModel: ApplicationViewModel
    
    var body: some View {
        NavigationStack(path: $applicationViewModel.naviagtionPath) {
            PokemonListView()
                .navigationDestination(for: PokemonUIItem.self) { path in
                    PokemonDetailView(pokemonUIItem: path)
                }
            
        }
    }
}
