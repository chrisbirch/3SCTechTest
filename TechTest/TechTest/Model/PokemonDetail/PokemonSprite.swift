import Foundation

extension Pokemon {
    struct Sprites: Decodable, Equatable {
        let backDefault: URL?
        let backFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
        
        var all: [URL] {
            [
                backDefault,
                backFemale,
                backShiny,
                backShinyFemale,
                frontDefault,
                frontFemale,
                frontShiny,
                frontShinyFemale
                
            ].compactMap { $0 }
        }
    }
}
