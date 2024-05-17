//
//  SDProgram.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 03.05.2024.
//

import UIKit
import SwiftData

@Model
final class SDProgram {
    @Attribute(.unique)
    var _id: UUID
    var _name: String
    @Relationship(deleteRule: .cascade)
    var _color: SDColor
    @Relationship(deleteRule: .cascade)
    var _subColor: SDColor
    @Relationship(deleteRule: .cascade)
    var _exercisesID: [UUID]

    init(
        id: UUID,
        name: String,
        color: SDColor,
        subColor: SDColor,
        exercisesID: [UUID] = []
    ) {
        self._id = id
        self._name = name
        self._color = color
        self._subColor = subColor
        self._exercisesID = exercisesID
    }
}

@Model
final class SDColor {
    @Attribute(.unique)
    let _id: UUID = UUID()
    var _red: CGFloat
    var _green: CGFloat
    var _blue: CGFloat
    var _alpha: CGFloat

    init(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat
    ) {
        self._red = red
        self._green = green
        self._blue = blue
        self._alpha = alpha
    }
}

