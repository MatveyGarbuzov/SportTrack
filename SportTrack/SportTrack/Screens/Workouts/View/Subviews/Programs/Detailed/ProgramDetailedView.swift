//
//  ProgramDetailedView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 17.04.2024.
//

import SwiftUI

struct ProgramDetailedView: View {

    @EnvironmentObject private var nav: Navigation
    @Environment(\.modelContext) var context

    @State var programViewModel = ProgramViewModel()

    var program: Program
    var size: CGSize

    var body: some View {
        MainViewBlock
            .backNavBarButton {
                goBack()
            }
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .startProgram:
                    StartedProgramScreen(program: program)
                        .customNavBar(title: program.name)
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .backNavBarButton {
                            goBack()
                        }

                case .editProgram:
                    EditProgramScreen(program: program) { newProgram in
                        programViewModel.deleteProgram(by: newProgram.id)
                        programViewModel.addNewProgram(newProgram)
                    }
                }
            }
            .onAppear {
                programViewModel.context = context
            }
    }
}

// MARK: - Actions

extension ProgramDetailedView {

    func startProgram(exercises: [Exercise]) {
        nav.addScreen(screen: Screens.startProgram(exercises: exercises))
    }

    func editProgram() {
        nav.addScreen(screen: Screens.editProgram)
    }

    func goBack() {
        nav.openPreviousScreen()
    }
}

extension ProgramDetailedView {

    var MainViewBlock: some View {
        ScrollView {
            VStack(spacing: 0) {
                BackgroundHeader(color: program.color, subColor: program.subColor)

                VStack {
                    ProgramHeader(program: program)
                    ButtonsStack(program: program)
                    ListOfExercies(exercises: program.exercises)
                        .padding(.top, .SPx3)
                }
                .padding(.bottom, .SPx20)
                .background(.background)
                .clipShape(.rect(cornerRadius: .CRx4))
                .offset(y: -.SPx5)
            }
        }
        .scrollIndicators(.never)
        .ignoresSafeArea()
        .onAppear {
            print("activityCategories: \(program.activityCategories)")
            print("exercises: \(program.exercises.map { $0.name })")
            print("muscleGroup: \(program.exercises.uniqueMuscleGroups.map { $0.rawValue })")

            print()
        }
    }

    func BackgroundHeader(color: Color, subColor: Color) -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let percent = minY / 1.2 / 100
            let opacity = max(0, min(-percent, 0.5))

            ZStack {
                Circle()
                    .fill(color)
                    .frame(edge: 210)
                    .position(x: geometry.size.width / 4, y: geometry.size.height / 2)
                    .rotationEffect(Angle(degrees: 180 * percent))
                    .rotationEffect(.radians(100))
                    .scaleEffect(percent + 1)

                Circle()
                    .fill(subColor)
                    .frame(edge: 140)
                    .position(x: geometry.size.width * 3 / 4, y: geometry.size.height / 2 - percent * 100)
                    .rotationEffect(Angle(degrees: -25 * percent))

                Rectangle()
                    .fill(.ultraThinMaterial)

                Rectangle()
                    .fill(.background.opacity(opacity))
            }
            .clipShape(.rect(cornerRadius: .CRx4))
            .offset(y: -minY)
        }
        .frame(height: max(0, Constants.backgroundHeaderHeight(size.height) - 20))
    }

    func ProgramHeader(program: Program) -> some View {
        HStack(alignment: .center) {
            Text(program.name)
                .title2
                .lineLimit(3)

            Spacer()
            CategoryIconsStack(activityCategories: program.activityCategories)
        }
        .padding()
    }

    func CategoryIconsStack(activityCategories: [ActivityCategory]) -> some View {
        // TODO: Сделать одинаковый отрицательный spacing тут и на главном (чтобы был эффект наложения)
        HStack(spacing: 0) {
            ForEach(activityCategories) { activity in
                AcitvityCircleView(activity: activity)
                    .frame(edge: 30)
            }
        }
    }

    func ButtonsStack(program: Program) -> some View {
        HStack(spacing: .SPx4) {
            FillButton(title: "Start") {
                guard !program.exercises.isEmpty else { return }
                print("Start button tapped")
                startProgram(exercises: program.exercises)
            }
            IconButton(iconName: "pencil", size: CGSize(width: 52, height: 52)) {
                print("Edit button tapped")
                editProgram()
            }
            .frame(edge: 52)
        }
        .padding(.horizontal)
        .frame(width: size.width, height: Constants.buttonsStackHeight)
    }

    func ListOfExercies(exercises: [Exercise]) -> some View {
        VStack(spacing: .SPx3) {
            ForEach(exercises) { exercise in
                ExerciseCell(exercise: exercise)
            }
        }
    }

    func ExerciseCell(exercise: Exercise) -> some View {
        let borderedGradient = LinearGradient(
            colors: [
                .primary,
                .primary.opacity(0.5),
                .primary.opacity(0.4),
                .primary.opacity(0.5),
                .primary
            ],
            startPoint: .leading,
            endPoint: .trailing
        )

        return HStack(spacing: .SPx5) {
            AcitvityCircleView(activity: exercise.muscleGroup.activityCategory)

            Text(exercise.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, .SPx2)

            Text(LocalizedStringKey(exercise.muscleGroup.rawValue))
                .padding(.horizontal, .SPx3)
                .padding(.vertical, .SPx2)
                .background(
                    Capsule()
                        .fill(.tertiary)
                )
        }
        .padding(.horizontal, .SPx5)
        .frame(maxWidth: .infinity)
        .frame(height: Constants.exerciseCellHeight)
        .overlay {
            RoundedRectangle(cornerRadius: .CRx4)
                .stroke()
                .foregroundStyle(borderedGradient)
        }
        .padding(.horizontal)
    }
}

private extension ProgramDetailedView {

    enum Constants {
        static let buttonsStackHeight: CGFloat = 60
        static let exerciseCellHeight: CGFloat = 70

        static func backgroundHeaderHeight(_ screenHeight: CGFloat) -> CGFloat { screenHeight * 0.55 }
    }
}

#Preview {
    NavigationStack {
        ProgramDetailedView(program: .init(name: "Program 123", exercises: .mockArray), size: .mockScreenSize)
    }
}
