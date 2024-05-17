//
//  ProgramViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 03.05.2024.
//

import SwiftData
import SwiftUI

final class ProgramViewModel {
    var context: ModelContext!

    func read() -> [Program] {
        let fetchDescriptor = FetchDescriptor<SDProgram>()
        let sdPrograms = (try? context.fetch(fetchDescriptor)) ?? []

        Logger.log(kind: .swiftDataInfo, message: "Reading \(sdPrograms.count) programs")

        return sdPrograms.map {
            return Program(
                id: $0._id,
                name: $0._name,
                color: Color(red: $0._color._red, green: $0._color._green, blue: $0._color._blue, opacity: $0._color._alpha),
                subColor: Color(red: $0._subColor._red, green: $0._subColor._green, blue: $0._subColor._blue, opacity: $0._subColor._alpha),
                exercises: $0._exercisesID.compactMap { id in
                    let vm = ExerciseViewModel()
                    vm.context = context
                    guard let sdModel = vm.getExercise(by: id) else { return nil }
                    guard let muscle = MuscleGroup(rawValue: sdModel._muscleGroup) else { return nil }

                    return Exercise(
                        id: id,
                        name: sdModel._name,
                        muscleGroup: muscle,
                        setsAndWeights: sdModel._setsAndWeights.map {
                            set in
                            SetAndWeight(id: set._id, weight: set._weight, reps: set._reps)
                        },
                        isWeightsDoubled: sdModel._isWeightsDoubled,
                        isBodyweight: sdModel._isBodyweight,
                        datePerformed: sdModel._datePerformed,
                        previousSetsAndWeights: sdModel._previousSetsAndWeights.map { pre in
                            PreviousSetsAndWeights(
                                id: pre._id,
                                date: pre._date,
                                setsAndWeights: pre._setsAndWeights.map { set in
                                    SetAndWeight(id: set._id, weight: set._weight, reps: set._reps)
                                }
                            )
                        }
                    )
                }
            )
        }
    }

    func addNewProgram(_ program: Program) {
        let colorComponents = program.color.components
        let sdProgram = SDProgram(
            id: program.id,
            name: program.name,
            color: SDColor(
                red: colorComponents.r,
                green: colorComponents.g,
                blue: colorComponents.b,
                alpha: colorComponents.a
            ),
            subColor: SDColor(
                red: colorComponents.r,
                green: colorComponents.g,
                blue: colorComponents.b,
                alpha: colorComponents.a
            ),
            exercisesID: program.exercises.map { $0.id }
        )
        context.insert(sdProgram)
        do {
            try context.save()
            Logger.log(kind: .swiftDataInfo, message: "Successfully saved program: \(program.name) \(program.id) with \(program.exercises.count) exercises")
        } catch {
            Logger.log(kind: .swiftDataError, message: error.localizedDescription)
        }
    }

    func deleteProgram(by id: UUID) {
        do {
            try context.delete(model: SDProgram.self, where: #Predicate { $0._id == id })
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Color

extension Color {

    var components: (r: Double, g: Double, b: Double, a: Double) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return (0,0,0,0) }

        return (Double(r), Double(g), Double(b), Double(a))
    }
}

