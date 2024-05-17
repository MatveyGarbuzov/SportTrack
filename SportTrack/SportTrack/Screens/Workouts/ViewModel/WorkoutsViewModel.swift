//
//  WorkoutsViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import SwiftUI
import Observation

@Observable
final class WorkoutsViewModel: ObservableObject {
    private(set) var programs: [Program]
    private(set) var exercises: [Exercise]

    init(programs: [Program] = .mockArrayOfPrograms, exercises: [Exercise] = []) {
        self.programs = programs
        self.exercises = exercises

        print("\(programs.count) programs loaded")
    }
}

// MARK: - Actions

extension WorkoutsViewModel {

    func updateProgramExercises(program: Program, exercises: [Exercise]) {
        if let index = programs.firstIndex(where: { $0.id == program.id }) {
            programs[index].exercises = exercises

            print("@-@ UPDATED!")
            exercises.forEach { exercise in
                print("@-@ name: \(exercise.name)")


            }
        }
    }

    func addProgram(_ program: Program) {
        programs.append(program)
    }

    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
}
