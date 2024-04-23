import SwiftUI

struct iPadContentView: View {
    @EnvironmentObject private var applicationViewModel: ApplicationViewModel
    
    var body: some View {
        NavigationSplitView {
            PokemonListView()
        } detail: {
            
            if let pokemonUIItem = applicationViewModel.selectedPokemon {
                
                PokemonDetailView(pokemonUIItem: .constant(pokemonUIItem))
            } else {
                Text("Nothing selected")
            }
            
        }
        
    }
}