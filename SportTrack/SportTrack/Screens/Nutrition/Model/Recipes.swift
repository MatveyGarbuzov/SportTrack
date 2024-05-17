//
//  Recipes.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 25.04.2024.
//

import Foundation
import SwiftUI // TODO: Убрать из API

struct Recipe: Identifiable {
    var id = UUID()

    let label: String
    let image: URL
    let source: String
    let url: String
    let shareAs: String
    let dietLabels: [DietLabel]
    let healthLabels: [HealthLabel]
    let cautions: [Caution]
    let ingredients: [String]
    let calories, totalWeight: Double
    let totalTime: Double
    let cuisineType: [CuisineType]
    let totalNutrients: [Total]
}

extension Recipe: Hashable {

    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension RecipeResponse {

    var mapper: Recipe {
        Recipe(
            label: label,
            image: image,
            source: source.absoluteString,
            url: url.absoluteString,
            shareAs: shareAs.absoluteString,
            dietLabels: dietLabels,
            healthLabels: healthLabels,
            cautions: cautions,
            ingredients: ingredients,
            calories: calories,
            totalWeight: totalWeight,
            totalTime: totalTime,
            cuisineType: cuisineType,
            totalNutrients: totalNutrients.map { $0.value }.filter { $0.label != .unknown }.sorted { $0.label.rawValue < $1.label.rawValue }
        )
    }
}

extension Total {

    var icon: Image {
        switch self.label {
        case .carbs: Image(.carbs)
        case .fat: Image(.fat)
        case .protein: Image(.protein)
        case .unknown: Image(systemName: "flame.fill")
        }
    }
}

extension Label {

    var color: Color {
        switch self {
        case .protein: Color.green
        case .fat: Color.red
        case .carbs: Color.blue
        case .unknown: Color.clear
        }
    }
}
