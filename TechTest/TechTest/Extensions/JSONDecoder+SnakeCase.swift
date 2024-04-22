import Foundation

extension JSONDecoder {
    static var snakeCaseDecoder: JSONDecoder {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
