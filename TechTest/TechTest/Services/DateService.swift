import Foundation

public protocol DateService {
    var date: Date { get }
}

class DateServiceImplementation: DateService {
    var date: Date {
        .init()
    }
}
