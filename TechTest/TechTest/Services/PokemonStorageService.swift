import Foundation

protocol PokemonStorageService {
    var cachedPokemons: [Pokemon] { get }
    func add(pokemon: Pokemon)
    func clearCache()
    func retrievePokemon(named name: String) -> Pokemon?
}

class PokemonStorageServiceImplementation: PokemonStorageService {
    private(set)var cachedPokemons: [Pokemon] = []
    
    func add(pokemon: Pokemon) {
        guard cachedPokemons.firstIndex(of: pokemon) == nil else { return }
        cachedPokemons.append(pokemon)
    }
    
    func clearCache() {
        cachedPokemons.removeAll()
    }
    
    func retrievePokemon(named name: String) -> Pokemon? {
        cachedPokemons.first { pokemon in
            pokemon.name == name
        }
    }
}
