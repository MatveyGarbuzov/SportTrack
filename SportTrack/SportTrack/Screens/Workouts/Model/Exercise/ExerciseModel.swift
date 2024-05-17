//
//  ExerciseModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import SwiftUI

// MARK: - Exercise

/// Структура Упражнения. Хранит в себе данные об упражнении: его название, группу мышц и подходы
class Exercise: Identifiable, ObservableObject {
    var id: UUID = UUID()
    /// Название упражнения
    var name: String
    /// Группа мышц (категория) упражнения
    var muscleGroup: MuscleGroup
    /// Массив с данными о каждом подходе (вес и кол-во повторов)
    var setsAndWeights: [SetAndWeight] = []
    /// Флаг, показывающий нужно ли удваивать значения весов (нужно для работы с гантелями)
    var isWeightsDoubled: Bool = false
    /// Флаг, показывающий работа идёт с собственным весом (отжимания, подтягивания и тд)
    var isBodyweight: Bool = false
    // Дата и время выполнения упражнения
    var datePerformed: Date = .now
    /// Прошлые данные по упражнению
    var previousSetsAndWeights: [PreviousSetsAndWeights] = []

    init(
        id: UUID = UUID(),
        name: String,
        muscleGroup: MuscleGroup,
        setsAndWeights: [SetAndWeight] = [],
        isWeightsDoubled: Bool = false,
        isBodyweight: Bool = false,
        datePerformed: Date = .now,
        previousSetsAndWeights: [PreviousSetsAndWeights] = []
    ) {
        self.id = id
        self.name = name
        self.muscleGroup = muscleGroup
        self.setsAndWeights = setsAndWeights
        self.isWeightsDoubled = isWeightsDoubled
        self.isBodyweight = isBodyweight
        self.datePerformed = datePerformed
        self.previousSetsAndWeights = previousSetsAndWeights
    }
}

extension Exercise: Hashable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SetAndWeight

/// Структура, хранящая вес и кол-во повторов в одном подходе
struct SetAndWeight: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    // MARK: weight является не только весом, но может быть и временем. Для кардио тренировок это считается как время
    /// Вес в подходе
    var weight: Float? = nil
    /// Кол-во повторов
    var reps: Int? = nil
}

// MARK: - PreviousSetsAndWeights

/// Структура, хранящая прошлые данные о подходе
struct PreviousSetsAndWeights: Identifiable {
    var id: UUID = UUID()
    /// Дата выполнения прошлых подходов
    var date: Date // TODO: Возможно стоит убрать, так как не используется
    /// Массив с данными о каждом подходе (вес и кол-во повторов)
    var setsAndWeights: [SetAndWeight] = []
}

// MARK: - MuscleGroup

/// Группа мышц, на которую идёт упражнение
enum MuscleGroup: String, CaseIterable {
    case arms = "Arms"
    case stretching = "Stretching"
    case legs = "Legs"
    case shoulders = "Shoulders"
    case back = "Back"
    case abs = "Abs"
    case chest = "Chest"
    case cardio = "Cardio"
}

extension MuscleGroup: Identifiable {
    var id: UUID { UUID() }
}

extension MuscleGroup {

    var activityCategory: ActivityCategory {
        switch self {
        case .arms: .gym
        case .legs: .gym
        case .shoulders: .gym
        case .back: .gym
        case .abs: .gym
        case .chest: .gym
        case .stretching: .cardio
        case .cardio: .cardio
        }
    }
}

// Названия для таблицы с выполнением упражнения

extension MuscleGroup {

    var startedExerciseWeightTitle: String {
        switch self {
        case .arms: "Вес"
        case .legs: "Вес"
        case .shoulders: "Вес"
        case .back: "Вес"
        case .abs: "Вес"
        case .chest: "Вес"
        case .stretching: "Дистанция"
        case .cardio: "Дистанция"
        }
    }

    var startedExerciseRepsTitle: String {
        switch self {
        case .arms: "Повторов"
        case .legs: "Повторов"
        case .shoulders: "Повторов"
        case .back: "Повторов"
        case .abs: "Повторов"
        case .chest: "Повторов"
        case .stretching: "Время"
        case .cardio: "Время"
        }
    }
}
