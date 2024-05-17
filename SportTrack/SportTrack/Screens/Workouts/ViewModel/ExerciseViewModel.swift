//
//  ExerciseViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import UIKit
import SwiftUI
import SwiftData

final class ExerciseViewModel {
    var context: ModelContext!

    func save(exercise: Exercise) {
        delete(by: exercise.id)
        Logger.log(kind: .swiftDataInfo, message: "Saving exercise with \(exercise)")
        print();print();print();print()
        let sdExercise = SDExercise(
            id: exercise.id,
            name: exercise.name,
            muscleGroup: exercise.muscleGroup.rawValue,
            setsAndWeights: exercise.setsAndWeights.map {
                SDSetAndWeight(id: $0.id, weight: $0.weight, reps: $0.reps)
            },
            isWeightsDoubled: exercise.isWeightsDoubled,
            isBodyweight: exercise.isBodyweight,
            previousSetsAndWeights: exercise.previousSetsAndWeights.map {
                SDPreviousSetsAndWeights(
                    id: $0.id,
                    date: $0.date,
                    setsAndWeights: $0.setsAndWeights.map { set in
                        SDSetAndWeight(id: set.id, weight: set.weight, reps: set.reps)
                    }
                )
            }
        )
        context.insert(sdExercise)
        do { try context.save() }
        catch {
            Logger.log(kind: .swiftDataError, message: "Error saving SDExercise. \(error.localizedDescription)")
        }
    }

    func delete(by id: UUID) {
        do {
            try context.delete(model: SDExercise.self, where: #Predicate { $0._id == id })
            Logger.log(kind: .swiftDataInfo, message: "Successfully delete exercise with \(id)")
        } catch {
            Logger.log(kind: .swiftDataError, message: "Error deleting SDExercise. \(error.localizedDescription)")
        }
    }

    func getExercise(by id: UUID) -> SDExercise? {
        let fetchDescriptor = FetchDescriptor<SDExercise>(predicate: #Predicate { $0._id == id})
        return try? context.fetch(fetchDescriptor).first
    }

    func read() -> [Exercise] {
        let fetchDescriptor = FetchDescriptor<SDExercise>()
        let sdExercises = (try? context.fetch(fetchDescriptor)) ?? []

        Logger.log(kind: .swiftDataInfo, message: "Reading \(sdExercises.count) exercises")

        return sdExercises.compactMap {
            guard let muscleGroup = MuscleGroup(rawValue: $0._muscleGroup) else { return nil }
            return Exercise(
                id: $0._id,
                name: $0._name,
                muscleGroup: muscleGroup,
                setsAndWeights: $0._setsAndWeights.map { set in
                    SetAndWeight(id: set._id, weight: set._weight, reps: set._reps)
                },
                isWeightsDoubled: $0._isWeightsDoubled,
                isBodyweight: $0._isBodyweight,
                datePerformed: $0._datePerformed,
                previousSetsAndWeights: $0._previousSetsAndWeights.map { pre in
                    PreviousSetsAndWeights(
                        id: pre._id,
                        date: pre._date,
                        setsAndWeights: pre._setsAndWeights.map { sett in
                            SetAndWeight(id: sett._id, weight: sett._weight, reps: sett._reps)
                        }
                    )
                }
            )
        }
    }
}
