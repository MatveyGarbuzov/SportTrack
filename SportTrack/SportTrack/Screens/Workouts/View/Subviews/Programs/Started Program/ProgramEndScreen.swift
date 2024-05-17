//
//  ProgramEndScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 21.04.2024.
//

import SwiftUI

struct ProgramEndScreen: View {

    @Environment(\.modelContext) var context
    @State private var vm = ExerciseViewModel()

    var exercises: [Exercise]

    @EnvironmentObject private var nav: Navigation
    @State private var buttonOpacity: Double = 0

    var body: some View {
        VStack(spacing: .SPx6) {
            Text("Congratulations!")
                .title2

            Text("You did it! Another workout conquered.\nKeep pushing yourself!")
                .callout
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            ConfettisView()
        }
        .overlay(alignment: .bottom) {
            FillButton(title: "SAVE WORKOUT") {
                saveWorkoutButtonPressed()
            }
            .opacity(buttonOpacity)
            .padding()
        }
        .onAppear {
            vm.context = context

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    buttonOpacity = 1
                }
            }
        }
    }
}

// MARK: - Actions

extension ProgramEndScreen {

    func saveWorkoutButtonPressed() {
        exercises.forEach { exercise in
            exercise.previousSetsAndWeights.append(
                PreviousSetsAndWeights(
                    date: exercise.datePerformed,
                    setsAndWeights: exercise.setsAndWeights
                )
            )
            exercise.setsAndWeights = [] // TODO: Delete?

            vm.save(exercise: exercise)
        }

        // Move to main screen
        nav.removeAll()
    }
}
