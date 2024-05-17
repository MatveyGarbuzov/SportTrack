//
//  ListOfAllExercises.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 19.04.2024.
//

import SwiftUI

private enum Screens: Hashable {
    case muscleGroup
    case exercises(exercises: [Exercise])
}

struct ListOfAllExercises: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @StateObject var nav = Navigation()

    @State private var vm = ExerciseViewModel()
    @State private var exercises: [Exercise] = []

    var muscleGroups: [MuscleGroup] {
        Array(Set(exercises.map { $0.muscleGroup })).sorted { $0.rawValue < $1.rawValue }
    }

    var isSheetPresented: Bool = false // TODO: Refactoring (либо избавиться, либо переименовать в isSheetPresentation)
    var exerciseSelected: (Exercise) -> Void

    var body: some View {
        NavigationStack(path: $nav.path) {
            MainBlock
                .toolbar {
                    if isSheetPresented {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Muscle group")
                                .headline
                                .padding(.leading)
                        }
                    }
                }
                .toolbar {
                    if isSheetPresented {
                        ToolbarItem(placement: .topBarTrailing) {
                            IconButton(iconName: "xmark.circle.fill", withOverlay: false, size: CGSize(width: 52, height: 52)) {
                                dismiss()
                            }
                        }
                    }
                }
                .navigationDestination(for: Screens.self) { screen in
                    switch screen {
                    case .muscleGroup:
                        MainBlock
                    case let .exercises(exercises):
                        FilteredExercises(exercises)
                            .scrollContentBackground(.hidden)
                            .background(.thinMaterial)
                    }
                }
                .onAppear {
                    vm.context = context
                    exercises = vm.read()
                }
        }
    }
}

// MARK: - UI Subviews

extension ListOfAllExercises {
    
    var MainBlock: some View {
        VStack {
            MuscleGroupsList
        }
    }

    var MuscleGroupsList: some View {
        ScrollView {
            ForEach(muscleGroups) { muscleGroup in
                MuscleGroupCell(muscleGroup)
                    .buttonStyle(.plain)
                    .onTapGesture {
                        nav.path.append(Screens.exercises(exercises: exercises.filter { $0.muscleGroup == muscleGroup }))
                    }
            }
        }
    }

    func MuscleGroupCell(_ muscleGroup: MuscleGroup) -> some View {
        let numberOfExercises = String(exercises.reduce(0) { $1.muscleGroup == muscleGroup ? $0 + 1 : $0 })

        let view = ZStack {
            RoundedRectangle(cornerRadius: .CRx3)
                .fill(.thickMaterial)
                .frame(maxHeight: .infinity)

            HStack {
                // TODO: Тут добавить иконку для категории мышц

                Text(LocalizedStringKey(muscleGroup.rawValue))
                    .subheadline
                Spacer()
                Text(numberOfExercises)
                AcitvityCircleView(activity: muscleGroup.activityCategory)
                Image(systemName: "chevron.right")
            }
            .padding(.vertical)
            .padding(.horizontal, .SPx6)
        }

        return view
            .padding(.horizontal)
    }

    func FilteredExercises(_ exercises: [Exercise]) -> some View {
        ScrollView {
            ForEach(exercises) { exercise in
                ExerciseCell(exercise)
                    .onTapGesture {
                        exerciseSelected(exercise)
                        dismiss()
                    }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "chevron.backward").tint(.primary)
                    Text("Exercises")
                        .headline
                }
                .padding(.leading)
                .onTapGesture {
                    nav.openPreviousScreen()
                }
            }
        }
        .toolbar {
            if isSheetPresented {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(iconName: "xmark.circle.fill", withOverlay: false, size: CGSize(width: 52, height: 52)) {
                        dismiss()
                    }
                }
            }
        }
        .presentationBackground(.ultraThinMaterial)
        .navigationBarBackButtonHidden(true)
    }

    func ExerciseCell(_ exercise: Exercise) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: .CRx3)
                .fill(.thickMaterial)
                .frame(maxHeight: .infinity)

            HStack {
                Text(exercise.name)
                    .subheadline
                Spacer()
                AcitvityCircleView(activity: exercise.muscleGroup.activityCategory)
            }
            .padding(.vertical)
            .padding(.horizontal, .SPx6)
        }
        .padding(.horizontal)
    }
}
