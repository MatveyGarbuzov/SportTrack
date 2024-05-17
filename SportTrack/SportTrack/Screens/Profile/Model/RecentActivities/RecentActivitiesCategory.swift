//
//  RecentActivitiesCategory.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

// TODO: DELETE
enum RecentActivitiesCategory: Identifiable {
    var id: UUID { UUID() }

    case cardio(CardioType)
    case gym(GymType)
    case diet(DietType)
}

// TODO: DELETE
extension RecentActivitiesCategory {

    var iconName: String {
        switch self {
        case .cardio: "figure.run"
        case .gym: "dumbbell.fill"
        case .diet: "fork.knife"
        }
    }

    var color: Color {
        switch self {
        case .cardio: Color.green
        case .gym: Color.red
        case .diet: Color.blue
        }
    }

    var typeTitle: String {
        switch self {
        case .cardio(let type): type.title
        case .gym(let type): type.title
        case .diet(let type): type.title
        }
    }
}

// TODO: DELETE 
extension [RecentActivitiesCategory] {

    static let mock: [RecentActivitiesCategory] = [
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
        .cardio(.cycling), .diet(.food), .gym(.squats), .gym(.benchPress), .diet(.water), .cardio(.running),
    ]
}
