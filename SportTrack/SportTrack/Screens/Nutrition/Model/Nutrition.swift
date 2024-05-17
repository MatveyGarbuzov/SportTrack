//
//  Nutrition.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import Foundation
import SwiftData
import SwiftUI

struct NutritionModel {
    var nutritionGoal: NutritionData
    var eatenRecipes: [EatenRecipe]
}

struct NutritionData: Identifiable, Codable {
    var id = UUID()
    var calories: Int
    var proteins: Int
    var fats: Int
    var carbs: Int
}

struct EatenRecipe {
    var id: UUID
    var label: String
    var icon: String
    var source: String
    var grams: Int
    var nutrioionData: NutritionData
    let date: Date = .now
 }

extension NutritionData {

    func icon(for kind: Kind) -> Image {
        switch kind {
        case .carbs: Image(.carbs)
        case .fat: Image(.fat)
        case .protein: Image(.protein)
        }
    }

    enum Kind {
        case carbs
        case fat
        case protein
    }
}
