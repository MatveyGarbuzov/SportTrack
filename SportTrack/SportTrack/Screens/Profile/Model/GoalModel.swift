//
//  GoalModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import Foundation

struct GoalModel: Hashable {
    var pointsToAchieve: Int
    var chartModel: [GoalChartModel]
}

struct GoalChartModel: Hashable, Identifiable, Equatable {
    var id: Int {
        day
    }

    var day: Int
    var points: Int
}

extension GoalModel {

    static let mock = GoalModel(pointsToAchieve: 160, chartModel: .mock)
}

extension [GoalChartModel] {

    static var mock: [GoalChartModel] {
        var array: [GoalChartModel] = []
        for i in 1...30 {
            let model = GoalChartModel(day: i, points: Int.random(in: 1...10))
            array.append(model)
        }
        return array
    }
}
