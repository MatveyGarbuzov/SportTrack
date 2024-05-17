//
//  StartedExerciseView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 21.04.2024.
//

import SwiftUI

extension StartedProgramScreen {

    struct ExerciseScreen: View {

        @State private var isShowingStats: Bool = false
        @State private var setsAndWeights: [SetAndWeight] = []
        @FocusState private var focusedField: FocusableField?

        @State var exercise: Exercise
        var isLast: Bool
        var lastItemIndex: Int { setsAndWeights.count - 1 }
        var saveButtonPressed: ((Exercise) -> Void)?

        var body: some View {
            VStack(spacing: 0) {
                ExerciseHeader
                ListOfSetsAndWeights
                ActionButtons
            }
            .sheet(isPresented: $isShowingStats) {
                StatsView(exercise: exercise)
                    .presentationCornerRadius(.CRx8)
                    .presentationBackground(.thinMaterial)
                    .presentationDragIndicator(.visible)
            }
        }

        // MARK: - UI Subviews

        var ExerciseHeader: some View {
            HStack(spacing: 0) {
                Text(exercise.muscleGroup.startedExerciseWeightTitle)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text(exercise.muscleGroup.startedExerciseRepsTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .bold()
            .padding(.horizontal)
        }

        var ListOfSetsAndWeights: some View {
            List {
                ForEach(setsAndWeights.indices, id: \.self) { index in
                    HStack {
                        // TODO: Сделать обработку в реальном времени, чтобы нельзя было вводить "5,5,5"
                        TextField("0", value: $setsAndWeights[index].weight, format: .number)
                            .customizedTextField()
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: index == lastItemIndex ? .weights : .notFocused)

                        TextField("0", value: $setsAndWeights[index].reps, format: .number)
                            .customizedTextField()
                            .keyboardType(.numberPad)
                    }
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: removeRows)

                FillButton(title: "Add") {
                    addElement()
                }
                .listRowBackground(Color.clear)
            }
        }

        var ActionButtons: some View {
            HStack(spacing: 0) {
                StatsButton
                SaveButton
            }
        }

        var StatsButton: some View {
            BorderButton(title: "STATS") {
                isShowingStats.toggle()
            }
            .padding()
            .background(.clear)
        }

        var SaveButton: some View {
            BorderButton(title: isLast ? "SAVE" : "NEXT") {
                saveSets()

                exercise.setsAndWeights = setsAndWeights
                saveButtonPressed?(exercise)
            }
            .padding()
            .background(.clear)
        }

        // MARK: - Actions

        func removeRows(at offsets: IndexSet) {
            // Убираем фокус перед удалением элемента. Иначе можем делать фокус на элемент, которого нет, будет краш
            focusedField = .notFocused

            // Костыль, чтобы лист успел обновиться
            // Без него происходит краш
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation {
                    setsAndWeights.remove(atOffsets: offsets)
                    printInfo()
                }
            }
        }

        func addElement() {
            let newValue = SetAndWeight()
            setsAndWeights.append(newValue)
            printInfo()

            // Костыль, чтобы фокус переходил на новый ряд.
            // Без него не успевает обработать появление нового элемента и фокус ставится на прошлый
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                focusedField = .weights
            }
        }

        func saveSets() {
            printInfo()
        }

        func printInfo() {
            print("\n--- --- --- --- ---")
            setsAndWeights.forEach { setAndWeight in
                print(setAndWeight)
            }
        }
    }
}

#Preview {

    StartedProgramScreen(program: .init(name: "qwe", exercises: .mockArray))
}
