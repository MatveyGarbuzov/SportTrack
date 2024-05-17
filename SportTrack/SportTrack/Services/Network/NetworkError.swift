//
//  NetworkError.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 25.04.2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
