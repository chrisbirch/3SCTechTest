import Foundation
enum NetworkError: Error, CustomStringConvertible {
    case otherError(String)

    var description: String {
        switch self {
        case .otherError(let txt):
            return txt
        }
    }
}


protocol NetworkService {
    func request(_ request: URLRequest) async throws -> Data
}
actor NetworkServiceImplementation: NetworkService {

    func request(_ request: URLRequest) async throws -> Data {
        let task = Task<Data, Error> {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.otherError("Invalid response")
            }

            if (200...299).contains(response.statusCode) {
                return data
            }
//            else if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
//                let errorMessage = errorResponse.status.errorMessage
//                throw NetworkError.otherError(errorMessage)
//            }
            else {
                throw NetworkError.otherError("Invalid response")
            }
        }

        let data = try await task.value
        return data
    }
}

