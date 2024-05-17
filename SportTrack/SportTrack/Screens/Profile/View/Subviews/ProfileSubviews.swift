//
//  ProfileSubviews.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI

extension ProfileScreen {

    var MainView: some View {
        ScrollView {
            VStack(spacing: 0) {
                PersonBlock
                GoalBlock
                ProfileSection(title: "Recent activities") {
                    RecentActivitiesBlock
                } action: {
                    open(.recentActivitiesScreen)
                }
            }
            .padding(.top)
        }
        .scrollIndicators(.never)
    }
}

#Preview {
//    ProfileScreen(viewModel: .mockData)
//        .environmentObject(Navigation())
    MainView()
        .environmentObject(Navigation())
}

