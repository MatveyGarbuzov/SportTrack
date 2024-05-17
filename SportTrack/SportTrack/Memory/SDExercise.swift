//
//  SDExercise.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI
import SwiftData
import Foundation

@Model
final class SDExercise {
    @Attribute(.unique)
    var _id                     : UUID
    var _name                   : String
    var _muscleGroup            : String
    @Relationship(deleteRule: .cascade)
    var _setsAndWeights         : [SDSetAndWeight]
    var _isWeightsDoubled       : Bool = false
    var _isBodyweight           : Bool = false
    var _datePerformed          : Date = Date()
    @Relationship(deleteRule: .cascade)
    var _previousSetsAndWeights : [SDPreviousSetsAndWeights]

    init(
        id: UUID,
        name: String,
        muscleGroup: String,
        setsAndWeights: [SDSetAndWeight],
        isWeightsDoubled: Bool,
        isBodyweight: Bool,
        previousSetsAndWeights: [SDPreviousSetsAndWeights]
    ) {
        self._id = id
        self._name = name
        self._muscleGroup = muscleGroup
        self._setsAndWeights = setsAndWeights
        self._isWeightsDoubled = isWeightsDoubled
        self._isBodyweight = isBodyweight
        self._previousSetsAndWeights = previousSetsAndWeights
    }
}

@Model
final class SDSetAndWeight {
    @Attribute(.unique)
    let _id     : UUID
    var _weight : Float?
    var _reps   : Int?

    init(
        id: UUID,
        weight: Float? = nil,
        reps: Int? = nil
    ) {
        self._id = id
        self._weight = weight
        self._reps = reps
    }
}

@Model
final class SDPreviousSetsAndWeights {
    @Attribute(.unique)
    var _id: UUID
    var _date: Date
    @Relationship(deleteRule: .cascade)
    var _setsAndWeights: [SDSetAndWeight]

    init(
        id: UUID,
        date: Date,
        setsAndWeights: [SDSetAndWeight]
    ) {
        self._id = id
        self._date = date
        self._setsAndWeights = setsAndWeights
    }
}
