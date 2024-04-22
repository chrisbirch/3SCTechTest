import XCTest
@testable import TechTest

class MockNetworkService: NetworkService {

    enum Errors: Error {
        case notSetup
    }
    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (request: URLRequest, Void)?
    var invokedRequestParametersList = [(request: URLRequest, Void)]()

    var returnResult: Result<Data, Error> = .failure(Errors.notSetup)

    func request(_ request: URLRequest) async throws -> Data {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (request, ())
        invokedRequestParametersList.append((request, ()))
        switch returnResult {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
