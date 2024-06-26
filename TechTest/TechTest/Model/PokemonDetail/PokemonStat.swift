import Foundation
extension Pokemon {
    struct Stat: Identifiable, Decodable, Equatable {
        struct InnerStat: Decodable, Equatable {
            let name: String
            let url: URL
        }
        let baseStat: Int
        let effort: Int
        let stat: InnerStat
        var id: String {
            name
        }
        var name: String {
            stat.name.replacingOccurrences(of: "-", with: " ").capitalized
        }
        var url: URL {
            stat.url
        }
    }
}
