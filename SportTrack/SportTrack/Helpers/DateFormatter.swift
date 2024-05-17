//
//  DateFormatter.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 30.04.2024.
//

import Foundation

class CustomDateFormatter {

    // MARK: - Shared

    static let shared = CustomDateFormatter()

    // MARK: - Formatters

    let dateFormatterShort: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = .current

        return dateFormatter
    }()

    let dateFormatterMedium: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = .current

        return dateFormatter
    }()

    let dateFormatterLong: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .current

        return dateFormatter
    }()

    func getDataFrom(string: String, kind: Kind) -> Date? {
        switch kind {
        case .short:
            dateFormatterShort.date(from: string)
        case .medium:
            dateFormatterMedium.date(from: string)
        case .long:
            dateFormatterLong.date(from: string)
        }
    }

    func createNewDateInString() -> String {
        dateFormatterShort.string(from: Date())
    }

    func isToday(string: String) -> Bool {
        string == dateFormatterShort.string(from: Date())
    }

    func isToday(date: Date) -> Bool {
        dateFormatterShort.string(from: date) == dateFormatterShort.string(from: Date())
    }

    enum Kind {
        case short
        case medium
        case long
    }
}
