//
//  Exercise+Mock.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 21.04.2024.
//

import Foundation

extension [Exercise] {

    static let mockArray: [Exercise] = [
        .init(name: "Скручивания на пресс PREPARED", muscleGroup: .abs, previousSetsAndWeights: .mockPreviousSetsAndWeightsPrepared),
        .init(name: "Скручивания на пресс", muscleGroup: .abs, previousSetsAndWeights: .mockPreviousSetsAndWeights()),
        .init(name: "Трицепс", muscleGroup: .arms),
        .init(name: "Бицепс", muscleGroup: .arms),
        .init(name: "Жим лёжа", muscleGroup: .chest),
        .init(name: "Бег", muscleGroup: .cardio),
        .init(name: "Плавание", muscleGroup: .cardio),
    ]
}
