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
            var cateogryName: String
            let name: String
            let url: URL?
            var id: String {
                name
            }
            
        }
        var allOtherSprites: [Sprite] {
            other?.flatMap { name, sprites in
                let theseSprites = sprites.all
                return theseSprites.map { sprite in
                    var sprite = sprite
                    sprite.cateogryName = name
                    return sprite
                }
                
            } ?? []
        }
        private static let standardCategoryName = "Standard"
        var all: [Sprite] {
            let standardCategoryName = Self.standardCategoryName
            let thisSpritesValues: [Sprite] = [
                .init(cateogryName: standardCategoryName, name: "Back", url: backDefault),
                .init(cateogryName: standardCategoryName,name: "Back Female", url: backFemale),
                .init(cateogryName: standardCategoryName,name: "Back Shiny", url: backShiny),
                .init(cateogryName: standardCategoryName,name: "Back Shiny Female", url: backShinyFemale),
                .init(cateogryName: standardCategoryName,name: "Front", url: frontDefault),
                .init(cateogryName: standardCategoryName,name: "Front Female", url: frontFemale),
                .init(cateogryName: standardCategoryName,name: "Front Shiny", url: frontShiny),
                .init(cateogryName: standardCategoryName,name: "Front Shiny Female", url: frontShinyFemale)
                
            ]
            let otherSpriteValues = allOtherSprites
                
            return (thisSpritesValues + otherSpriteValues).filter { $0.url != nil }
        }
    }
}
