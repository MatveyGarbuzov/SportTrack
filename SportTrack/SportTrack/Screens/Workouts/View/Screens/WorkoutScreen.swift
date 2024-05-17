//
//  WorkoutScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

// TODO: Подумать, как можно по-другому передать
struct ProgramEnd: Hashable {}

struct WorkoutScreen: View {

    @Environment(\.modelContext) var context
    @State private var exerciseViewModel = ExerciseViewModel()
    @State private var exercises: [Exercise] = []

    @State var programViewModel = ProgramViewModel()
    @State var programs: [Program] = []


    // TODO: Старая viewModel, удалится позже
    typealias ViewModel = WorkoutsViewModel

    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var nav: Navigation
    @State var activeTab: SegmentedControlTab = .program
    @State var isShowingListOfExercices: Bool = false
    @State var isShowingCreateNewExercise: Bool = false
    var size: CGSize

    var body: some View {
        MainView
            .customNavBar(title: "Workouts")
            .customTabBarItem(placement: .topBarTrailing, iconName: "plus") {
                open(.newProgram)
            }
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case let .detailedProgram(program):
                    ProgramDetailedView(program: program, size: size)
                        .customNavBar(title: program.name)
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .environmentObject(viewModel)

                case let .startedProgram(program):
                    StartedProgramScreen(program: program)
                        .customNavBar(title: program.name)
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .backNavBarButton {
                            goBack()
                        }
                        .environmentObject(viewModel)

                case .newProgram:
                    EditProgramScreen(program: Program()) { newProgram in
                        programViewModel.addNewProgram(newProgram)
                    }
                }
            }
            .sheet(isPresented: $isShowingListOfExercices) {
                ListOfAllExercises(isSheetPresented: true) { selectedExercise in
                    let program = Program(name: selectedExercise.name, exercises: [selectedExercise])
                    open(.startedProgram(program: program))
                }
                .presentationCornerRadius(.CRx8)
                .presentationBackground(.ultraThinMaterial)
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $isShowingCreateNewExercise) {
                CreateNewExerciseScreen() { newExercise in
                    exerciseViewModel.save(exercise: newExercise)
                }
                .presentationCornerRadius(.CRx8)
                .presentationBackground(.ultraThinMaterial)
                .presentationDragIndicator(.visible)
            }
            .onAppear {
                programViewModel.context = context
                exerciseViewModel.context = context

                programs = programViewModel.read()
                exercises = exerciseViewModel.read()
            }
    }
}

// MARK: - Actions

extension WorkoutScreen {

    func goBack() {
        nav.openPreviousScreen()
    }

    func open(_ screen: Screens) {
        nav.addScreen(screen: screen)
    }
}

extension WorkoutScreen {

    enum Screens: Hashable {
        case detailedProgram(program: Program)
        case startedProgram(program: Program)
        case newProgram
    }
}
