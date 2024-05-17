//
//  RecentActivitiesModel.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

struct RecentActivitiesModel: Identifiable {
    var id = UUID()

    var category: [RecentActivitiesCategory] = .mock
}

extension RecentActivitiesModel {

    static let mock = RecentActivitiesModel()
}
