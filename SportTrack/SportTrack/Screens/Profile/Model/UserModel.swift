//
//  UserModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import Foundation

struct UserModel: Hashable {
    var person: Person = Person()
    var stats: Stats = Stats()
}

// MARK: - Person

struct Person: Hashable {
    var image: Data? = .empty
    var name: String = .clear
    var surname: String = .clear
    var mail: String = .clear
}

// MARK: - Stats

struct Stats: Hashable {
    var experience: Experience = .beginner
    var level: Int = 0
    var percentage: CGFloat = 0
}

enum Experience {
    case beginner
    case intermediate
    case advanced
}

extension Experience {

    var title: String {
        switch self {
        case .beginner:
            "Beginner"
        case .intermediate:
            "Intermediate"
        case .advanced:
            "Advanced"
        }
    }
}
