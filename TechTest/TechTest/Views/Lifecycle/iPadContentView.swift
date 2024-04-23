import SwiftUI

struct iPadContentView: View {
    @EnvironmentObject private var applicationViewModel: ApplicationViewModel
    
    var body: some View {
        NavigationSplitView {
            PokemonListView()
        } detail: {
            
            if let pokemonName = applicationViewModel.selectedPokemonName {
                
                PokemonDetailView(pokemonName: pokemonName)
            } else {
                Text("Please select a pokemon from the list")
            }
        }
    }
}
