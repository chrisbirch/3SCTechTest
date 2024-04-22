import Foundation

enum Urls {

    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    case pokemonList(offset: Int, count: Int)
    case pokemonDetail(name: String)

    var url: URL {
        var url = Self.baseURL.absoluteString
        switch self {
        case let .pokemonList(offset, count):
            url += "/?offset=\(offset)&limit=\(count)"
        case let .pokemonDetail(name):
            url += name
        }
        return URL(string: url)!
    }
}
