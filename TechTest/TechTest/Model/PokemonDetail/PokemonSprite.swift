import Foundation

extension Pokemon {
    struct Sprites: Decodable, Equatable, Hashable {
        let backDefault: URL?
        let backFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
        
        let other: [String: Sprites]?
        
        struct Sprite: Identifiable, Hashable, Equatable {
            let name: String
            let url: URL?
            var id: String {
                name
            }
            
            func prepending(name: String) -> Sprite {
                .init(name: "\(name)\n\(self.name)", url: self.url)
            }
        }
        var allOtherSprites: [Sprite] {
            other?.flatMap { name, sprites in
                let theseSprites = sprites.all
                return theseSprites.map { sprite in
                    sprite.prepending(name: name)
                }
                
            } ?? []
        }
        var all: [Sprite] {
            let thisSpritesValues: [Sprite] = [
                .init(name: "Back", url: backDefault),
                .init(name: "Back Female", url: backFemale),
                .init(name: "Back Shiny", url: backShiny),
                .init(name: "Back Shiny Female", url: backShinyFemale),
                .init(name: "Front", url: frontDefault),
                .init(name: "Front Female", url: frontFemale),
                .init(name: "Front Shiny", url: frontShiny),
                .init(name: "Front Shiny Female", url: frontShinyFemale)
                
            ]
            let otherSpriteValues = allOtherSprites
                
            return (thisSpritesValues + otherSpriteValues).filter { $0.url != nil }
        }
    }
}
