import Foundation

protocol PokemonService {
    func pokemonList() async throws -> [PokemonListResponse.PokemonListItem]
    func pokemon(named name: String) async throws -> Pokemon
}

class PokemonServiceImplementation: PokemonService {
    @Inject private var networkService: NetworkService
    private let maxNumberOfItemsPerRequest = 2000
    
    func pokemonList() async throws -> [PokemonListResponse.PokemonListItem] {
        var currentOffset = 0
        var hasMoreItems = true
        var pokemonListItems = [PokemonListResponse.PokemonListItem]()
        while hasMoreItems {
            let list = try await pokemonList(offset: currentOffset, count: maxNumberOfItemsPerRequest)
            pokemonListItems += list.results
            currentOffset += maxNumberOfItemsPerRequest
            hasMoreItems = list.stillMoreItemsToDownload
        }
        return pokemonListItems
    }
    
    func pokemon(named name: String) async throws -> Pokemon {
        let requestURL = Urls.pokemonDetail(name: name).url
        print("Downloading pokemon at url: \(requestURL)")
        let data = try await networkService.request(.init(url: requestURL))
        return try JSONDecoder.snakeCaseDecoder.decode(Pokemon.self, from: data)
    }
}

extension PokemonServiceImplementation {
    private func pokemonList(offset: Int, count: Int) async throws -> PokemonListResponse {
        let requestURL = Urls.pokemonList(offset: offset, count: count).url
        print("Downloading items at offset: \(offset), count: \(count)")
        let data = try await networkService.request(.init(url: requestURL))
        return try JSONDecoder.snakeCaseDecoder.decode(PokemonListResponse.self, from: data)
    }
}

