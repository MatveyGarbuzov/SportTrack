//
//  ProgramCellView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 16.04.2024.
//

import SwiftUI

struct ProgramCell: View {

    var program: Program

    var body: some View {
        ZStack(alignment: .leading) {
            Background
            Main
        }
        .frame(height: Constants.cellHeight)
    }
}

extension ProgramCell {

    var Main: some View {
        GeometryReader {
            let size = $0.size

            HStack(alignment: .top, spacing: 0) {
                LeftBlock
                    .frame(width: size.width * 4/5)

                CategoryIconsStack(activityCategories: program.activityCategories)
            }
            .frame(width: size.width, alignment: .leading)
        }
    }

    func CategoryIconsStack(activityCategories: [ActivityCategory]) -> some View {
        GeometryReader {
            let size = $0.size

            HStack(spacing: 0) {
                ForEach(activityCategories) { activity in
                    AcitvityCircleView(activity: activity)
                }
            }
            .frame(edge: size.width)
        }
    }

    var LeftBlock: some View {
        GeometryReader {
            VStack(alignment: .leading, spacing: 0) {
                Title
                Spacer()
                MuscleGroupsScroll
            }
            .padding()
            .frame(size: $0.size, alignment: .topLeading)
        }
    }

    var Title: some View {
        Text(program.name)
            .title2
    }

    var MuscleGroupsScroll: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(program.exercises.uniqueMuscleGroups) { category in
                    Text(LocalizedStringKey(category.rawValue))
                        .padding(.vertical, .SPx1)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.thickMaterial)
                        )
                }
            }
        }
    }

    var Background: some View {
        GeometryReader {
            let size = $0.size

            ZStack(alignment: .bottomLeading) {
                Circle()
                    .fill(program.subColor)
                    .frame(edge: size.width / 3)

                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(program.color)
                        .frame(edge: size.width / 3)

                    Circle()
                        .fill(program.subColor)
                        .frame(edge: size.width / 5)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .frame(height: size.height)
                }
            }
        }
    }
}

// MARK: - Constants

extension ProgramCell {

    enum Constants {
        static let cellHeight: CGFloat = 170
    }
}

#Preview {
    NavigationStack {
        WorkoutScreen(viewModel: WorkoutsViewModel(), size: .mockScreenSize)
            .navigationTitle("Workouts")
    }
}
