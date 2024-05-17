//
//  SDNutritionData.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import Foundation
import SwiftData

@Model
final class SDNutritionData {
    @Attribute(.unique)
    var _id       : UUID
    var _calories : Int
    var _proteins : Int
    var _fats     : Int
    var _carbs    : Int

    init(
        id: UUID,
        calories: Int,
        proteins: Int,
        fats: Int,
        carbs: Int
    ) {
        self._id = id
        self._calories = calories
        self._proteins = proteins
        self._fats = fats
        self._carbs = carbs
    }
}

@Model
final class SDEatenRecipe {
    @Attribute(.unique)
    var _id: UUID
    var _label: String
    var _icon: String
    var _source: String
    var _grams: Int
    var _nutrioionData: SDNutritionData
    let _date: Date

    init(
        id: UUID,
        label: String,
        icon: String,
        source: String,
        grams: Int,
        nutrioionData: SDNutritionData,
        date: Date = .now
    ) {
        self._id = id
        self._label = label
        self._icon = icon
        self._source = source
        self._grams = grams
        self._nutrioionData = nutrioionData
        self._date = date
    }
}

