//
//  ProgramModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import SwiftUI

// MARK: - Program

/// Хранит в себе программу из упражнений
class Program: Identifiable, ObservableObject {
    var id: UUID = UUID()
    /// Название программы
    var name: String
    /// Цвет бг программы
    var color: Color = [.red, .blue, .green].randomElement()! // TODO: Сделать .clear по дефолту
    /// Дополнительный цвет бг программы
    var subColor: Color = [.red, .blue, .green].randomElement()!
    /// Массив упражнений
    var exercises: [Exercise]

    init(
        id: UUID = UUID(),
        name: String = "My program",
        color: Color = .red,
        subColor: Color = .blue,
        exercises: [Exercise] = []
    ) {
        self.id = id
        self.name = name
        self.color = color
        self.subColor = subColor
        self.exercises = exercises
    }
}

extension Array where Element == Exercise {

    var uniqueMuscleGroups: [MuscleGroup] {
        Swift.Array(Set(self.map { $0.muscleGroup })).sorted { $0.rawValue < $1.rawValue }
    }
}

extension Program {

    var activityCategories: [ActivityCategory] {
        Array(Set(exercises.map { $0.muscleGroup.activityCategory }))
    }
}

// MARK: - Hashable

extension Program: Hashable {

    static func == (lhs: Program, rhs: Program) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
