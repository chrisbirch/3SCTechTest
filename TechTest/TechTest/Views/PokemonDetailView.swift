import SwiftUI

struct PokemonDetailView: View {
    let pokemonUIItem: PokemonUIItem
    
    var body: some View {
        Text("Detail for: \(pokemonUIItem.name)")
    }
}
