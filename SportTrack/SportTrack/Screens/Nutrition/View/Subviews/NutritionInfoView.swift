//
//  NutritionInfoView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 23.04.2024.
//

import SwiftUI

/// Отображает статистику для протеинов/жиров/углеводов
struct NutritionInfoView: View {

    /// Тип протеинов/жиров/углеводов
    let titleKind: TitleKind
    /// Сколько съели
    var eaten: Int
    /// Сколько нужно съесть
    var goalToEat: Int
    /// Сколько съели в %
    var percentage: Double {
        Double(eaten) / Double(goalToEat)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Title
            ProgressBar
            LeftToEat
        }
        .padding(.SPx2)
    }
}

// MARK: - UI Subviews

extension NutritionInfoView {

    var Title: some View {
        Text(LocalizedStringKey(titleKind.rawValue))
            .bold()
            .textCase(.uppercase)
    }

    var ProgressBar: some View {
        GeometryReader {
            let size = $0.size
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(titleKind.color.opacity(0.5))

                Capsule()
                    .fill(titleKind.color)
                    .frame(width: min(0 + percentage * size.width, size.width))
                    .animation(.bouncy, value: percentage)
            }
            .clipShape(Capsule())
        }
        .frame(height: 20)
    }

    var LeftToEat: some View {
        HStack(alignment: .lastTextBaseline, spacing: 2) {
            Text("\(eaten)")
                .headline
            Text("/")
                .headline
            Text("\(goalToEat)")
                .headline
            Text("g")
                .subheadline
        }
        .lineLimit(1)
        .minimumScaleFactor(0.01)
    }
}

extension NutritionInfoView {

    enum TitleKind: String {
        case protein = "Protein"
        case fat = "Fat"
        case carbs = "Carbs"
    }
}

extension NutritionInfoView.TitleKind {

    var color: Color {
        switch self {
        case .protein: Color.green
        case .fat: Color.red
        case .carbs: Color.blue
        }
    }
}

#Preview {
    NutritionInfoView(titleKind: .protein, eaten: 30, goalToEat: 50)
        .frame(edge: 120)
}
