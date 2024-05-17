//
//  StartedProgramScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 20.04.2024.
//

import SwiftUI

struct StartedProgramScreen: View {

    @EnvironmentObject private var nav: Navigation

    var program: Program
    @State var exercises: [Exercise] = []
    @State var activeExercise: Exercise.ID?
    @State var mainScrollState: Exercise.ID?
    @State var tabScrollState: Exercise.ID?

    var body: some View {
        MainViewBlock
            .navigationDestination(for: ProgramEnd.self) { model in
                ProgramEndScreen(exercises: exercises)
                    .customNavBar(title: "Results")
                    .backNavBarButton {
                        nav.openPreviousScreen()
                    }
            }
            .onAppear {
                exercises = program.exercises
                guard let exercise = program.exercises.first else { return }
                updateActiveExercise(with: exercise)
            }
    }
}

// MARK: - Actions

extension StartedProgramScreen {

    func nextExerciseTapped(exercise newExerciseData: Exercise) {
        guard
            let index = exercises.firstIndex(of: newExerciseData),
            let exercise = exercises[safe: index + 1]
        else {
            endProgram()
            return
        }

        withAnimation(.snappy) {
            updateActiveExercise(with: exercise)
        }
    }

    func endProgram() {
        nav.addScreen(screen: ProgramEnd())
    }

    func updateActiveExercise(with exercise: Exercise) {
        activeExercise = exercise.id
        tabScrollState = exercise.id
        mainScrollState = exercise.id
    }
}
