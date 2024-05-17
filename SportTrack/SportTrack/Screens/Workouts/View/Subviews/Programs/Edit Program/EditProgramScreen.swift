//
//  EditProgramScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.04.2024.
//

import SwiftUI

struct EditProgramScreen: View {

    @EnvironmentObject private var nav: Navigation

    @State var program: Program
    @State private var programName: String = .clear
    @State private var selectedColor: Color = .clear
    @State private var selectedSubColor: Color = .clear
    @State private var exercises: [Exercise] = []
    @State private var draggingItem: String?
    @State private var showingAllExercices: Bool = false

    var newProgram: (Program) -> Void

    var body: some View {
        MainBlock
            .customNavBar(title: programName)
            .toolbarBackground(.hidden, for: .navigationBar)
            .backNavBarButton {
                goBack()
            }
            .checkmarkNavBarButton {
                Logger.log(kind: .swiftDataInfo, message: "Update or create program")

                program.name = programName
                program.exercises = exercises
                program.color = selectedColor
                program.subColor = selectedSubColor

                newProgram(program)
                goBack()
            }
            .sheet(isPresented: $showingAllExercices) {
                ListOfAllExercises(isSheetPresented: true) { newExercise in
                    let isAlreadyAdded = exercises.map { $0.id }.contains { $0 == newExercise.id }
                    guard !isAlreadyAdded else { return }

                    exercises.append(newExercise)
                }
                .presentationCornerRadius(.CRx8)
                .presentationBackground(.ultraThinMaterial)
                .presentationDragIndicator(.visible)
            }
    }
}

// MARK: - Actions

extension EditProgramScreen {

    func goBack() {
        nav.openPreviousScreen()
    }
}

// MARK: - UI Subviews

extension EditProgramScreen {

    var MainBlock: some View {
        VStack {
            ProgramNameField
            ColorPicker(selectedColor: $selectedColor)
            ColorPicker(selectedColor: $selectedSubColor)
            FillButton(title: "Add exercise") {
                showingAllExercices.toggle()
            }
            ListOfExercises
        }
        .onAppear {
            selectedColor = program.color
            selectedSubColor = program.subColor
            programName = program.name
            exercises = program.exercises
        }
        .padding(.horizontal)
        .padding(.top, .SPx5)
    }

    var ProgramNameField: some View {
        TextField("", text: $programName)
            .multilineTextAlignment(.center)
            .padding()
            .background(.thinMaterial)
            .cornerRadius(.CRx5)
    }

    struct ColorPicker: View {
        @Binding var selectedColor: Color
        private let colors: [Color] = [.red, .yellow, .orange, .purple, .blue, .indigo, .green, .mint]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .foregroundColor(color)
                            .frame(edge: 40)
                            .opacity(color == selectedColor ? 1 : 0.85)
                            .scaleEffect(color == selectedColor ? 1.2 : 1.0)
                            .onTapGesture {
                                withAnimation {
                                    selectedColor = color
                                }
                            }
                    }
                }
                .padding()
            }
            .background(.thinMaterial)
            .cornerRadius(.CRx5)
        }
    }

    var ListOfExercises: some View {
        ScrollView {
            LazyVStack(spacing: .SPx3) {
                ForEach(exercises, id: \.self) { exercise in
                    HStack {
                        RoundedRectangle(cornerRadius: .CRx4)
                            .fill(selectedColor)
                            .overlay {
                                Text(exercise.name)
                            }
                        Image(systemName: "trash.fill")
                            .onTapGesture {
                                withAnimation {
                                    exercises.removeAll(where:  { $0.id == exercise.id})
                                }
                            }
                    }

                    // Drag
                    .draggable(exercise.name) {
                        RoundedRectangle(cornerRadius: .CRx4)
                            .fill(.ultraThinMaterial)
                            .frame(edge: 1)
                            .onAppear {
                                draggingItem = exercise.name
                            }
                    }
                    // Drop
                    .dropDestination(for: String.self) { items, location in
                        draggingItem = nil
                        return false
                    } isTargeted: { status in
                        if let draggingItem, status, draggingItem != exercise.name {
                            if
                                let sourceIndex = exercises.map({ $0.name }).firstIndex(of: draggingItem),
                                let destinationIndex = exercises.firstIndex(of: exercise)
                            {
                                withAnimation(.bouncy) {
                                    let sourceItem = exercises.remove(at: sourceIndex)
                                    exercises.insert(sourceItem, at: destinationIndex)
                                }
                            }
                        }
                    }
                    .frame(height: 120)
                }
            }
            .padding(.vertical, .SPx4)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    EditProgramScreen(program: [Program].mockArrayOfPrograms.first!) { _ in }
}
