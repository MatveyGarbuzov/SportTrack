//
//  WorkoutSubviews.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 14.04.2024.
//

import SwiftUI

extension WorkoutScreen {

    var MainView: some View {
        ScrollView {
            SegmentedControlBlock
                .frame(height: 50)
                .fixedSize(horizontal: false, vertical: true)

            if activeTab == .program {
                ListOfPrograms
            } else {
                ListOfExercises
            }
        }
        .safeAreaPadding(.bottom, 100)
        .scrollIndicators(.hidden)
    }

    var ListOfPrograms: some View {
        VStack {
            if programs.isEmpty {
                ContentUnavailableView(
                    LocalizedStringKey("No program has been created yet"),
                    systemImage: "figure.run",
                    description: Text(LocalizedStringKey("You can create a new one by clicking plus icon"))
                )
                .padding(.top, .SPx6)
            } else {
                ScrollView {
                    // TODO: Лейзи ломает анимацию segmentControl
                    VStack(spacing: .SPx5) {
                        ForEach(programs) { program in
                            ProgramCell(program: program)
                                .onTapGesture {
                                    open(.detailedProgram(program: program))
                                }
                        }
                    }
                    .padding([.horizontal, .top], .SPx6)
                }
            }
        }
    }

    var ListOfExercises: some View {
        VStack {
            FillButton(title: "Pick exercise") {
                isShowingListOfExercices.toggle()
            }
            BorderButton(title: "Create new") {
                isShowingCreateNewExercise.toggle()
            }
        }
        .padding([.horizontal, .top], .SPx6)
    }
}

#Preview {
    NavigationStack {
        WorkoutScreen(viewModel: WorkoutsViewModel(), size: .mockScreenSize)
            .navigationTitle("Workouts")
    }
}
