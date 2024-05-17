//
//  TabBarItemModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI

enum TabBarItem: String, CaseIterable {
    case nutrition
    case workouts
    case profile
}

extension TabBarItem {

    var title: String {
        switch self {
        case .nutrition: "Nutrition"
        case .workouts: "Workouts"
        case .profile: "Profile"
        }
    }

    var imageName: String {
        switch self {
        case .nutrition: "takeoutbag.and.cup.and.straw"
        case .workouts: "list.bullet.clipboard"
        case .profile: "person"
        }
    }

    var imageNameFilled: String {
        imageName + ".fill"
    }
}
