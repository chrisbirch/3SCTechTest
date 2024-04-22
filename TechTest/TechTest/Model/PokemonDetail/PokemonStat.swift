import Foundation
extension Pokemon {
    struct Stat: Decodable, Equatable {
        struct InnerStat: Decodable, Equatable {
            let name: String
            let url: URL
        }
        let baseStat: Int
        let effort: Int
        let stat: InnerStat
        
        var name: String {
            stat.name
        }
        
        var url: URL {
            stat.url
        }
    }
}
