import Foundation
@testable import TechTest

class MockPokemonService : PokemonService {
    enum DummyData {
        enum Pokemons {
            static func createDummyURL(name: String) -> URL {
                URL(string: "https://www.dummysite.com/stat1")!
            }
            enum Stats {
                static let stat1 = Pokemon.Stat(
                    baseStat: 1,
                    effort: 2,
                    stat: .init(
                        name: "DummyStat",
                        url: Pokemons.createDummyURL(name: "Stat1")
                    )
                )
            }
            enum Sprites {
                static let sprite1 = Pokemon.Sprites(
                    backDefault: Pokemons.createDummyURL(name: "backDefault.png"),
                    backFemale: Pokemons.createDummyURL(name: "backFemale.png"),
                    backShiny: Pokemons.createDummyURL(name: "backShiny.png"),
                    backShinyFemale: Pokemons.createDummyURL(name: "backShinyFemale.png"),
                    frontDefault: Pokemons.createDummyURL(name: "frontDefault.png"),
                    frontFemale: Pokemons.createDummyURL(name: "frontFemale.png"),
                    frontShiny: Pokemons.createDummyURL(name: "frontShiny.png"),
                    frontShinyFemale: Pokemons.createDummyURL(name: "frontShinyFemale.png")
                )
            }
            static let pokemon1 = Pokemon(
                id: 1,
                name: "DummyPokemon",
                sprites: Sprites.sprite1,
                stats: [
                    Stats.stat1
                ]
            )
        }
    }
    var invokedPokemonList = false
    var invokedPokemonDetailWithName: String?
    
    var stubbedList: Result<[PokemonListResponse.PokemonListItem], Error> = .success([
        .init(name: "DummyPokemonName", url: URL(string: "https://dummysite.com/aPokemon")!)
    ])
    
    var stubbedPokemon: Result<Pokemon, Error> = .success(DummyData.Pokemons.pokemon1)
    
    func pokemonList() async throws -> [PokemonListResponse.PokemonListItem] {
        invokedPokemonList = true
        switch stubbedList {
        case .success(let list):
            return list
        case .failure(let error):
            throw error
        }
    }
    
    func pokemon(named name: String) async throws -> Pokemon {
        invokedPokemonDetailWithName = name
        switch stubbedPokemon {
        case .success(let pokemon):
            return pokemon
        case .failure(let error):
            throw error
        }
    }
}
