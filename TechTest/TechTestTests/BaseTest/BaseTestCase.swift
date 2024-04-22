import XCTest
@testable import TechTest

class BaseTestCase: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var mockPokemonService: MockPokemonService!
    var mockDateService: MockDateService!
    var mockPokemonStorageService: MockPokemonStorageService!

    override func setUpWithError() throws {
        let resolver = DependencyResolver.shared
        resolver.reset()

        mockNetworkService = .init()
        mockPokemonService = .init()
        mockDateService = .init()
        mockPokemonStorageService = .init()

        resolver.add(mockNetworkService as NetworkService)
        resolver.add(mockPokemonStorageService as PokemonStorageService)
        resolver.add(mockPokemonService as PokemonService)
        resolver.add(mockDateService as DateService)
    }
}
