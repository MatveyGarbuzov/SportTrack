//
//  CreateNewExerciseScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 23.04.2024.
//

import SwiftUI

struct CreateNewExerciseScreen: View {

    @Environment(\.dismiss) var dismiss
    @State private var exerciseName: String = .clear
    @State private var muscleGroup: MuscleGroup = .abs
    @State private var isWeightsDoubled: Bool = false
    @State private var isBodyweight: Bool = false

    @State private var isShowingDoubledInfo = false
    @State private var isShowingBodyweight = false

    let muscleGroups = MuscleGroup.allCases

    var createdExercise: (Exercise) -> Void

    var body: some View {
        MainBlock
            .onChange(of: isBodyweight) {
                if isBodyweight {
                    isWeightsDoubled = false
                }
            }
            .onChange(of: isWeightsDoubled) {
                if isWeightsDoubled {
                    isBodyweight = false
                }
            }
    }
}

// MARK: - UI Subviews

extension CreateNewExerciseScreen {

    var MainBlock: some View {
        List {
            NameField
            MuscleGroupPicker
            IsDoubledSwitch
                .alert(isPresented: $isShowingDoubledInfo) {
                    Alert(
                        title: Text("Double weights"),
                        message: Text("For exercises with double weights (e.g. two dumbbells) specify the weight of just one, while tonnage statistics will be doubled."),
                        dismissButton: .default(
                            Text("Got it!")
                        )
                    )
                }
            IsBodyweightSwitch
                .alert(isPresented: $isShowingBodyweight) {
                    Alert(
                        title: Text("Bodyweight"),
                        message: Text("For bodyweight exercises (e.g. pull-ups) repetition statistics will be displayed instead of tonnage.\nIf necessary, you can log any additional weight or leave the field blank."),
                        dismissButton: .default(Text("Got it!"))
                    )
                }

        }
        .safeAreaPadding(.bottom, 100)
        .scrollContentBackground(.hidden)
        .padding(.top)
        .overlay(alignment: .bottom) {
            FillButton(title: "Create") {
                let exercise = Exercise(
                    name: exerciseName,
                    muscleGroup: muscleGroup,
                    isWeightsDoubled: isWeightsDoubled,
                    isBodyweight: isBodyweight
                )

                createdExercise(exercise)
                dismiss()
            }
            .padding()
        }
    }

    var NameField: some View {
        VStack(alignment: .leading) {
            if !exerciseName.isEmpty {
                Text("Exercise name")
                    .headline
                    .padding(.horizontal)
            }

            TextField("Exercise name", text: $exerciseName, axis: .vertical)
                .lineLimit(1...2)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: .CRx3)
                        .fill(.thickMaterial)
                }
        }
        .animation(.default, value: exerciseName)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }

    var MuscleGroupPicker: some View {
        Picker("Muscle group", selection: $muscleGroup) {
            ForEach(muscleGroups, id: \.self) {
                Text(LocalizedStringKey($0.rawValue))
            }
        }
        .pickerStyle(.inline)
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
        .listRowBackground (
            Rectangle()
                .fill(.thickMaterial)
        )
    }

    var IsDoubledSwitch: some View {
        HStack {
            Text("Is weight doubled")
            Image(systemName: "info.circle.fill")
                .onTapGesture {
                    isShowingDoubledInfo.toggle()
                    print("isShowingDoubledInfo: \(isShowingDoubledInfo)")
                    print("isShowingBodyweight: \(isShowingBodyweight)")
                }
            Toggle("", isOn: $isWeightsDoubled)
        }
    }

    var IsBodyweightSwitch: some View {
        HStack {
            Text("Is bodyweight")
            Image(systemName: "info.circle.fill")
                .onTapGesture {
                    isShowingBodyweight.toggle()
                    print("isShowingDoubledInfo: \(isShowingDoubledInfo)")
                    print("isShowingBodyweight: \(isShowingBodyweight)")
                }
            Toggle("", isOn: $isBodyweight)
        }
    }
}

//#Preview {
//    CreateNewExerciseScreen() { _ in
//
//    }
//}
