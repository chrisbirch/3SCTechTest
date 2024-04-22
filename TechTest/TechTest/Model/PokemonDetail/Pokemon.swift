import Foundation

struct Pokemon: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    
    var thumbnailImageURL: URL? {
        sprites.all.first
    }
}
