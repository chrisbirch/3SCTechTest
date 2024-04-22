import Foundation

extension Pokemon {
    struct Sprites: Decodable {
        let backDefault: URL?
        let backFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
    }
}
