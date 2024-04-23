import Foundation
@testable import TechTest

class MockPokemonStorageService : PokemonStorageService {
    enum RetrievePokemonStub {
        case notFound
        case pokemon(Pokemon)
        case returnFromStubbed
    }
    
    var invokedCachedPokemons = false
    var invokedClearCache = false
    var invokedAddPokemonWith: Pokemon?
    var invokedRetrievedPokemonWithName: String?
    
    var stubbedPokemons = [Pokemon]()
    var stubbedRetrievdPokemon = RetrievePokemonStub.returnFromStubbed
    
    var cachedPokemons: [Pokemon] {
        invokedCachedPokemons = true
        return stubbedPokemons
    }
    
    func add(pokemon: Pokemon) {
        invokedAddPokemonWith = pokemon
        stubbedPokemons.append(pokemon)
    }
    
    func clearCache() {
        invokedClearCache = true
        stubbedPokemons.removeAll()
    }
    
    func retrievePokemon(named name: String) -> Pokemon? {
        invokedRetrievedPokemonWithName = name
        switch stubbedRetrievdPokemon {
        case .notFound:
            return nil
        case .returnFromStubbed:
            return stubbedPokemons.first { pokemon in
                pokemon.name == name
            }
        case .pokemon(let pokemon):
            return pokemon
        }
    }
}
