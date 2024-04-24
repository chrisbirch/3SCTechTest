import XCTest
@testable import TechTest

class PokemonServiceTests: BaseTestCase {
    var sut: PokemonService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PokemonServiceImplementation()
    }

    func test() async throws {
        //ran out of time to test this service :(
    }
}
