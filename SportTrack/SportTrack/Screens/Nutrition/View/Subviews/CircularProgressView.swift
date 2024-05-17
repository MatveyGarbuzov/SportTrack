//
//  CircularProgressView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 23.04.2024.
//

import SwiftUI


struct CircularProgressView: View {

    /// Сколько съели
    var eaten: Int
    /// Сколько нужно съесть
    let goalToEat: Int
    /// Сколько съели в %
    var percentage: Double {
        Double(eaten) / Double(goalToEat)
    }

    var body: some View {
        ZStack {
            CircleBackground
            CircleProgress
            CaloriesInfo
        }
    }
}

// MARK: - UI Subviews

extension CircularProgressView {

    var CircleBackground: some View {
        Circle()
            .stroke(
                AngularGradient.init(
                    gradient: .init(colors: [.green, .blue, .green]),
                    center: .center
                ).opacity(0.5),
                lineWidth: .width
            )
            .rotationEffect(.degrees(-90))
    }

    var CircleProgress: some View {
        Circle()
            .trim(from: 0, to: percentage)
            .stroke(
                AngularGradient.init(
                    gradient: .init(colors: [.green, .blue, .green]),
                    center: .center
                ),
                style: StrokeStyle(
                    lineWidth: .width,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
            .animation(.snappy, value: percentage)
    }

    var CaloriesInfo: some View {
        VStack {
            Text("CALORIES")
                .footnote

            Text("\(eaten) eaten")
                .headline
                .foregroundStyle(.green)

            Text("\((goalToEat - eaten) > 0 ? goalToEat - eaten : 0) left")
                .headline
        }
    }
}

// MARK: - Constants

private extension CGFloat {

    static let width: CGFloat = 30
}

#Preview {
    CircularProgressView(eaten: 30, goalToEat: 100)
        .frame(edge: 200)
}
