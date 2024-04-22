import XCTest
@testable import TechTest

extension BaseTestCase {

    enum LoadJSONErrors: Error {
        case doesntExist(filename: String)
    }

    func loadJSONData(filename: String) throws -> Data {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
            throw LoadJSONErrors.doesntExist(filename: "\(filename).json")
        }

        return try Data(contentsOf: URL(filePath: pathString), options: [])
    }
}
