//
//  ActivityCategory.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import SwiftUI

// MARK: - ActivityCategory

/// Категории акивностей
enum ActivityCategory {
    /// Для активностей вида: пробежка, растяжка и тд
    case cardio
    /// Для активностей в зале
    case gym
    /// Для активностей с едой
    case diet
}

extension ActivityCategory {

    var color: Color {
        switch self {
        case .cardio: .green
        case .gym: .red
        case .diet: .blue
        }
    }

    var iconName: String {
        switch self {
        case .cardio: "figure.run"
        case .gym: "dumbbell.fill"
        case .diet: "fork.knife"
        }
    }
}

extension ActivityCategory: Identifiable {
    var id: UUID { UUID() }
}
