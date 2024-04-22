import XCTest
@testable import TechTest

class DependancyInjectionTests: XCTestCase {
    var sut: DependencyResolver!
    var mockDateService: MockDateService!
    @Inject var injectedService: DateService

    @InjectOptional
    var injectedOptionalService: PokemonService?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = .shared
        sut.clear()
        mockDateService = .init()
        sut.add(mockDateService as DateService)
    }

    func testPropertyWrapperInjectedNonOptionalServiceThenServiceIsReturned() throws {
        let now = Date()
        mockDateService.date = now
        XCTAssertEqual(injectedService.date, now)
    }

    func testPropertyWrapperOptionalServiceNotInjectedThenNoServiceIsReturned() throws {
        XCTAssertNil(injectedOptionalService)
    }

    func testPropertyWrapperOptionalServiceWasInjectedThenServiceIsReturned() throws {
        let mockService = MockPokemonService()
        sut.add(mockService as PokemonService)
        XCTAssertNotNil(injectedOptionalService)
    }

    func testPropertyWrapperInjectedNonOptionalServiceWhenServiceIsOverwrittenThenNewServiceIsReturned() throws {
        let oldServiceDate = Date(timeIntervalSince1970: 0)
        mockDateService.date = oldServiceDate
        XCTAssertEqual(injectedService.date, oldServiceDate)

        let newlyCreatedService = MockDateService()
        let now = Date()
        newlyCreatedService.date = now
        sut.add(newlyCreatedService as DateService)

        XCTAssertEqual(injectedService.date, now)
    }

    func testPropertyWrapperOptionalServiceIsInjectedWhenClearCalledThenNoServiceIsReturned() throws {
        let mockService = MockPokemonService()
        sut.add(mockService as PokemonService)
        XCTAssertNotNil(injectedOptionalService)

        sut.clear()

        XCTAssertNil(injectedOptionalService)
    }
}
