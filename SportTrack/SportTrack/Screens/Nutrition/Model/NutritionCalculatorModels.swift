//
//  NutritionCalculatorModels.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 31.04.2024.
//

import Foundation

extension NutritionCalculator {

    enum Sex: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case male = "Male"
        case female = "Female"
    }

    enum Activity: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case low = "Sedentary lifestyle"
        case light = "Lightly active (light physical activity or exercises 1-3 times a week)"
        case normal = "Moderately active (exercise 3-5 times a week)"
        case active = "Very active (intense workouts, exercises 6-7 times a week)"
        case veryActive = "Athletes and those with similar activity levels (6-7 times a week)"
    }
}

extension NutritionCalculator.Sex {

    var totalCoefficient: Double {
        switch self {
        case .male:
            88.362
        case .female:
            447.593
        }
    }

    var weightCoefficient: Double {
        switch self {
        case .male:
            13.397
        case .female:
            9.247
        }
    }

    var heightCoefficient: Double {
        switch self {
        case .male:
            4.799
        case .female:
            3.098
        }
    }

    var ageCoefficient: Double {
        switch self {
        case .male:
            5.677
        case .female:
            4.33
        }
    }
}

extension NutritionCalculator.Activity {

    var coefficient: Double {
        switch self {
        case .low:
            1.2
        case .light:
            1.375
        case .normal:
            1.55
        case .active:
            1.725
        case .veryActive:
            1.9
        }
    }
}
