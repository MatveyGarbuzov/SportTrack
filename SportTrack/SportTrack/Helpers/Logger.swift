//
//  Logger.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 29.04.2024.
//

import Foundation

final class Logger {

    private init() { }

    static func log(kind: Kind = .info, message: String, fileName: String = #file, function: String = #function, line: Int = #line) {
        let fileName = fileName.split(separator: String.slash).last ?? "file not found"
        print("[\(kind.rawValue.uppercased())]: [\(Date())]: [\(fileName)] [\(function)]: [#\(line)]")
        print("\(message)\n")
    }

    enum Kind: String {
        case info = "ℹ️ info"
        case swiftDataError = "📀 SwiftData error"
        case swiftDataInfo = "📀 SwiftData info"
    }
}
