import XCTest
@testable import TechTest

class JSONModelDecodingTests: BaseTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    func testDecodePokemonList() throws {
        let data = try loadJSONData(filename: JSONDummyDataFiles.pokemonList)
        let listResponse = try JSONDecoder.snakeCaseDecoder.decode(PokemonListResponse.self, from: data)
        XCTAssertEqual(listResponse.count, 1302)
        let results = listResponse.results
        XCTAssertEqual(results.count, 20)
        guard let firstResult = results.first else { return XCTFail("Failed to get first item") }
        XCTAssertEqual(firstResult.name, "bulbasaur")
        XCTAssertEqual(firstResult.url, URL(string: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
    
    func testDecodePokemon() throws {
        let data = try loadJSONData(filename: JSONDummyDataFiles.pokemonDetail)
        let pokemon = try JSONDecoder.snakeCaseDecoder.decode(Pokemon.self, from: data)
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "bulbasaur")
        guard let firstStat = pokemon.stats.first else { return XCTFail("Failed to get first stat") }
        XCTAssertEqual(firstStat.baseStat, 45)
        XCTAssertEqual(firstStat.name, "hp")
        XCTAssertEqual(firstStat.effort, 0)
        XCTAssertEqual(firstStat.url, URL(string: "https://pokeapi.co/api/v2/stat/1/"))
        
        let sprites = pokemon.sprites
        XCTAssertEqual(sprites.backDefault, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png"))
        XCTAssertNil(sprites.backFemale)
        XCTAssertEqual(sprites.backShiny, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png"))
        XCTAssertNil(sprites.backShinyFemale)
        XCTAssertEqual(sprites.frontDefault, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
        XCTAssertNil(sprites.frontFemale)
        XCTAssertEqual(sprites.frontShiny, URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"))
        XCTAssertNil(sprites.frontShinyFemale)
    }
}



