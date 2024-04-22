import Foundation

struct PokemonListResponse: Decodable {
    struct PokemonListItem: Identifiable, Decodable {
        var id: String { name }
        let name: String
        let url: URL
    }
    
    let count: Int
    let next: URL?
    let results: [PokemonListItem]
    
    var stillMoreItemsToDownload: Bool {
        next != nil
    }
}
