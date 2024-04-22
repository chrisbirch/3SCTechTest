import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
}
