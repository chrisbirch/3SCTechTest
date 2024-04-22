import Foundation
@testable import TechTest

class MockDateFormatterService : DateFormatterService {

    var invokedFormat = false
    var invokedFormatCount = 0
    var invokedFormatParameters: (date: Date, style: DateFormatStyle)?
    var invokedFormatParametersList = [(date: Date, style: DateFormatStyle)]()
    var stubbedFormatResult: String = ""

    func format(_ date: Date, style: DateFormatStyle) -> String {
        invokedFormat = true
        invokedFormatCount += 1
        invokedFormatParameters = (date, style)
        invokedFormatParametersList.append((date, style))
        return stubbedFormatResult
    }
}
