import XCTest
@testable import TechTest

class BaseTestCase: XCTestCase {
    enum Errors: Error {
        case noItem
    }
    
    var mockNetworkService: MockNetworkService!
    var mockDateFormatterService: MockDateFormatterService!
    var mockDateService: MockDateService!

    override func setUpWithError() throws {
        let resolver = DependencyResolver.shared
        resolver.reset()

        mockNetworkService = .init()
        mockDateFormatterService = .init()
        mockDateService = .init()

        resolver.add(mockNetworkService as NetworkService)
        resolver.add(mockDateFormatterService as DateFormatterService)
        resolver.add(mockDateService as DateService)
    }
}
