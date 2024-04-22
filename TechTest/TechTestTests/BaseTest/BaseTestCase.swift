import XCTest
@testable import TechTest

class BaseTestCase: XCTestCase {
    enum Errors: Error {
        case noItem
    }
    
    var mockNetworkService: MockNetworkService!
    var mockPokemonService: MockPokemonService!
    var mockDateService: MockDateService!

    override func setUpWithError() throws {
        let resolver = DependencyResolver.shared
        resolver.reset()

        mockNetworkService = .init()
        mockPokemonService = .init()
        mockDateService = .init()

        resolver.add(mockNetworkService as NetworkService)
        resolver.add(mockPokemonService as PokemonService)
        resolver.add(mockDateService as DateService)
    }
}
