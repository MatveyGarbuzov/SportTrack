//
//  MainViewBlock.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 21.04.2024.
//

import SwiftUI

extension StartedProgramScreen {

    var MainViewBlock: some View {
        VStack {
            TabBar
            HorizontalScrollScreens
        }
    }

    var TabBar: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(exercises) { exercise in
                    BorderButton(title: exercise.name) {
                        withAnimation(.snappy) {
                            updateActiveExercise(with: exercise)
                        }
                    }
                    .background(activeExercise == exercise.id ? Color.secondary.opacity(0.3) : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: .CRx4))
                    .padding(.vertical)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $tabScrollState, anchor: .center)
        .safeAreaPadding(.horizontal)
        .scrollIndicators(.hidden)
    }

    var HorizontalScrollScreens: some View {
        GeometryReader {
            let size = $0.size

            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(exercises) { exercise in
                        ExerciseScreen(exercise: exercise, isLast: exercises.last == exercise, saveButtonPressed: { updateExercise in
                            if let index = exercises.firstIndex(where: { $0.id == updateExercise.id }) {
                                exercises[index].setsAndWeights = updateExercise.setsAndWeights
                            }

                            nextExerciseTapped(exercise: exercise)
                        })
                        .frame(size: size)
                        .contentShape(.rect)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $mainScrollState)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .onChange(of: mainScrollState) { oldValue, newValue in
            if let newValue {
                withAnimation(.snappy) {
                    tabScrollState = newValue
                    activeExercise = newValue
                }
            }
        }
        // TODO: Подумать что делать со скролом в стороны
        //  .scrollDisabled(true)
    }
}
