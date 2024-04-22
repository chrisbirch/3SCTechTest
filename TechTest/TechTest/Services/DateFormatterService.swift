import Foundation

enum DateFormatStyle: String {
    case short = "d MMM y"

}
protocol DateFormatterService {
    func format(_ date: Date, style: DateFormatStyle) -> String
}

class DateFormatterServiceImplementation: DateFormatterService {
    let dateFormatter = DateFormatter()

    func format(_ date: Date, style: DateFormatStyle) -> String {
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.string(from: date)
    }
}

