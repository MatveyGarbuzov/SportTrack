//
//  ProgramModel+Mock.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import Foundation

extension [SetAndWeight] {

    static func getMock() -> [SetAndWeight] {
        [
            .init(weight: Float.random(in: 10...100), reps: Int.random(in: 5...10)),
            .init(weight: 6, reps: 6),
            .init(weight: 15, reps: 7),
        ]
    }
}

extension [PreviousSetsAndWeights] {

    static func mockPreviousSetsAndWeights() -> [PreviousSetsAndWeights] {
        var result: [PreviousSetsAndWeights] = []


        for _ in 1...Int.random(in: 2...5) {
            result.append(.init(
                date: .now,
                setsAndWeights: .getMock()
            ))
        }

        return result
    }

    static var mockPreviousSetsAndWeightsPrepared: [PreviousSetsAndWeights] {
        [
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 10))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 10))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 10))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 10))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 11))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 9, day: 12))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 10, day: 10))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 10, day: 11))!, setsAndWeights: .getMock()),
            .init(date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2023, month: 11, day: 12))!, setsAndWeights: .getMock()),
        ]
    }
}

extension [Exercise] {

    static func getMockExercises() -> [Exercise] {
        var result: [Exercise] = []

        for _ in 1...Int.random(in: 3...7) {
            result.append(.getMock())
        }

        return result
    }
}

extension Exercise {

    static func getMock() -> Exercise {
        Exercise(
            name: "Random exercise #\(Int.random(in: 0...1000))",
            muscleGroup: MuscleGroup.allCases.randomElement() ?? .abs,
            setsAndWeights: [],//.getMock(),
            isWeightsDoubled: Bool.random(),
            isBodyweight: Bool.random(),
            datePerformed: .now,
            previousSetsAndWeights: []//.mockPreviousSetsAndWeights()
        )
    }
}

extension [Program] {

    static let mockArrayOfPrograms: [Program] = [
        Program(name: "Моя программа №1", exercises: .getMockExercises()),
        Program(name: "Моя программа №2", exercises: .getMockExercises()),
        Program(name: "Моя программа №3", exercises: .getMockExercises()),
        Program(name: "Моя программа №4", exercises: .getMockExercises()),
        Program(name: "Моя программа №5", exercises: .getMockExercises()),
        Program(name: "Моя программа №6", exercises: .getMockExercises()),
        Program(name: "Моя программа №7", exercises: .getMockExercises()),
        Program(name: "Моя программа №8", exercises: .getMockExercises()),
        Program(name: "Моя программа №9", exercises: .getMockExercises()),
        Program(name: "Моя программа №10", exercises: .getMockExercises()),
    ]
}
