import Foundation
@testable import TechTest

class MockDateService : DateService {
    ///Default date: Tuesday, 2 July 2019 10:17:08
    var date = Date(timeIntervalSince1970: 1562062628)
}
