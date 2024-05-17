//
//  ActivityType.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

enum GymType {
   case benchPress
   case squats
   case deadlift
}

enum CardioType {
   case running
   case cycling
   case swimming
}

enum DietType {
    case water
    case food
}

// MARK: - Extensions

extension GymType {

    var title: String {
        switch self {
        case .benchPress:
            "Bench press"
        case .squats:
            "Squats"
        case .deadlift:
            "Deadlift"
        }
    }
}

extension CardioType {

    var title: String {
        switch self {
        case .running:
            "Running"
        case .cycling:
            "Cycling"
        case .swimming:
            "Swimming"
        }
    }
}

extension DietType {

    var title: String {
        switch self {
        case .water:
            "Water"
        case .food:
            "Food"
        }
    }
}
