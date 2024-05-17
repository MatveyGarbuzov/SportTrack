//
//  ProfileViewModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    // TODO: Сделать везде private(set)
    @Published var user: UserModel
    @Published private(set) var goal: GoalModel
    @Published private(set) var recentActivities: RecentActivitiesModel

    init(user: UserModel = .init(), goal: GoalModel, recentActivities: RecentActivitiesModel) {
        self.user = user
        self.goal = goal
        self.recentActivities = recentActivities
    }
}

extension ProfileViewModel {

    func setNewName(_ name: String) {
        user.person.name = name
    }

    func setNewPhoto(_ photo: Data?) {
        user.person.image = photo
    }
}

// MARK: - Get

extension ProfileViewModel {


    // MARK: PersonBlock

    var getUserLevel: Int {
        user.stats.level
    }

    var getUserName: String {
        user.person.name
    }

    var getUserExperience: String {
        user.stats.experience.title
    }

    func getLevelString() -> String {
        .space + "\(getUserLevel)"
    }

    // MARK: GoalBlock

    var getCurrentAmountOfPoints: Int {
        goal.chartModel.map { $0.points }.reduce(.zero, +)
    }

    var getPointsToAchieve: Int {
        goal.pointsToAchieve
    }

    var getTotalString: String {
        .space + "\(getCurrentAmountOfPoints >= getPointsToAchieve ? "🎉" : .clear)"
    }

    var getPointsToAchieveString: String {
        "/" + String(getPointsToAchieve) + .space
    }

    var getCurrentAmountOfPointsString: String {
        String(getCurrentAmountOfPoints)
    }

    var getGoalChartData: [GoalChartModel] {
        goal.chartModel
    }

    // MARK: RecentActivitiesBlock

    var getRecentActivitiesCategory: [RecentActivitiesCategory] {
        recentActivities.category
    }
}

// MARK: - Set

extension ProfileViewModel {

    func increasePercentage(by value: CGFloat = .random(in: 0.1...0.3)) {
        user.stats.percentage = min(user.stats.percentage + value, Constants.maxPercentage)

        if user.stats.percentage == Constants.maxPercentage {
            increaseLevel()
            user.stats.percentage = 0
        }

        print("user.stats.percentage: \(user.stats.percentage)")
    }

    func increaseLevel(by value: Int = 1) {
        user.stats.level += value
    }
}

fileprivate extension ProfileViewModel {

    func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        let output = items.map { "\($0)" }.joined(separator: separator)

        Swift.print("[ProfileVM] " + output, terminator: terminator)
    }
}

// MARK: - Constants

fileprivate extension ProfileViewModel {

    enum Constants {
        static let maxPercentage: CGFloat = 1
    }
}

// MARK: - Mock

extension ProfileViewModel {

    static let mockData: ProfileViewModel = ProfileViewModel(user: .mock, goal: .mock, recentActivities: .mock)
}
