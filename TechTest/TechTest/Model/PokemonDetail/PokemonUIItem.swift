import SwiftUI

struct PokemonUIItem: Identifiable, Hashable {
    
    private var pokemonService: PokemonService {
        DependencyResolver.shared.resolve()
    }
    
    let name: String
    var id: String { name }

    init(name: String) {
        self.name = name
    }
    
    func downloadPokemon() async throws -> Pokemon {
        try await pokemonService.pokemon(named: name)
    }
}
