//
//  NetworkResponseModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 29.04.2024.
//

import Foundation

// MARK: - QueryAPI

struct QueryAPI: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Codable, Identifiable {
    var id = UUID()
    let recipe: RecipeResponse

    enum CodingKeys: String, CodingKey {
        case recipe
    }
}

// MARK: - RecipeResponse

struct RecipeResponse: Codable, Hashable {
    let label: String
    let image: URL
    let source: URL
    let url: URL
    let shareAs: URL
    let dietLabels: [DietLabel]
    let healthLabels: [HealthLabel]
    let cautions: [Caution]
    let ingredients: [String]
    let calories: Double
    let totalWeight: Double
    let totalTime: Double
    let cuisineType: [CuisineType]
    let totalNutrients: [String: Total]

    enum CodingKeys: String, CodingKey {
        case label
        case image
        case source
        case url
        case shareAs
        case dietLabels
        case healthLabels
        case cautions
        case cuisineType
        case ingredients = "ingredientLines"
        case calories
        case totalWeight
        case totalTime
        case totalNutrients
    }
}

// MARK: - DietLabel

enum DietLabel: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
    case unknown = "Any"

    enum CodingKeys: String, CodingKey {
        case balanced, highFiber, lowCarb, lowFat, lowSodium
    }
}

extension DietLabel {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - HealthLabel

enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case immuneSupportive = "Immune-Supportive"
    case celeryFree = "Celery-Free"
    case crustaceanFree = "Crustacean-Free"
    case dairyFree = "Dairy-Free"
    case eggFree = "Egg-Free"
    case fishFree = "Fish-Free"
    case fodmapFree = "FODMAP-Free"
    case glutenFree = "Gluten-Free"
    case ketoFriendly = "Keto-Friendly"
    case kidneyFriendly = "Kidney-Friendly"
    case kosher = "Kosher"
    case lowPotassium = "Low-Potassium"
    case lupineFree = "Lupine-Free"
    case mustardFree = "Mustard-Free"
    case lowFatAbs = "Low-Fat-Abs"
    case noOilAdded = "No-Oil-Added"
    case lowSugar = "Low-Sugar"
    case paleo = "Paleo"
    case peanutFree = "Peanut-Free"
    case pescatarian = "Pescatarian"
    case porkFree = "Pork-Free"
    case redMeatFree = "Red-Meat-Free"
    case sesameFree = "Sesame-Free"
    case shellfishFree = "Shellfish-Free"
    case soyFree = "Soy-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case wheatFree = "Wheat-Free"
    case mulluskFree = "Mollusk-Free"
    case unknown
}

extension HealthLabel {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - Caution

enum Caution: String, Codable {
    case eggs = "Eggs"
    case fodmap = "FODMAP"
    case gluten = "Gluten"
    case milk = "Milk"
    case soy = "Soy"
    case sulfites = "Sulfites"
    case treeNuts = "Tree-Nuts"
    case wheat = "Wheat"
    case unknown
}

extension Caution {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - CuisineType

enum CuisineType: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case american = "american"
    case asian = "asian"
    case british = "british"
    case caribbean = "caribbean"
    case centralEurope = "Central Europe"
    case chinese = "chinese"
    case easternEurope = "Eastern Europe"
    case french = "french"
    case greek = "greek"
    case indian = "indian"
    case italian = "italian"
    case japanese = "japanese"
    case korean = "korean"
    case kosher = "kosher"
    case mediterranean = "mediterranean"
    case mexican = "mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "nordic"
    case southAmerican = "South American"
    case southEastAsian = "South East Asian"
    case world = "world"
    case unknown = "Any"
}

extension CuisineType {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - Total

struct Total: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()

    let label: Label
    let quantity: Double
    let unit: Unit

    enum CodingKeys: String, CodingKey {
        case label, quantity, unit
    }
}

// MARK: - Label

enum Label: String, Codable {
    case carbs = "Carbs"
    case fat = "Fat"
    case protein = "Protein"
    case unknown
}

extension Label {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - Unit

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
    case unknown
}

extension Unit {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}
