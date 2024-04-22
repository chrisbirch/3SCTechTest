import XCTest
@testable import TechTest

extension BaseTestCase {
    func stubHTTPResponse(with result: Result<Data, Error>) {
        mockNetworkService.returnResult = result
    }

    func stubHTTPResponse(jsonFilename: String) throws {
        let jsonData = try loadJSONData(filename: jsonFilename)
        mockNetworkService.returnResult = .success(jsonData)
    }
}
