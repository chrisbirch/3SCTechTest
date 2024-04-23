import Foundation

class Pokemon: ObservableObject, Decodable, Identifiable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.name == rhs.name
    }
    
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    
    var thumbnailImageURL: URL? {
        sprites.all.first?.url
    }
}
