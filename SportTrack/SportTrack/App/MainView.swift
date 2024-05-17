//
//  MainView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI

struct MainView: View {

    @StateObject var workoutsViewModel: WorkoutsViewModel
    @StateObject var nav: Navigation
    @State private var size: CGSize = .zero

    init(nav: Navigation = Navigation(), workoutsViewModel: WorkoutsViewModel = .init(programs: .mockArrayOfPrograms)) {
        self._nav = StateObject(wrappedValue: nav)
        self._workoutsViewModel = StateObject(wrappedValue: workoutsViewModel)
    }

    var body: some View {
        NavigationStack(path: $nav.path) {
            MainViewBlock
        }
        .environmentObject(nav)
        .viewSize(size: $size)
    }
}

// MARK: - UI Subviews

private extension MainView {

    var MainViewBlock: some View {
        ZStack(alignment: .bottom) {
            AllTabBarViews
            TabBarView()
        }
    }

    @ViewBuilder
    var AllTabBarViews: some View {
        switch nav.activeTab {
        case .workouts:
            WorkoutScreen(viewModel: workoutsViewModel, size: size)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .nutrition:
            NutritionScreen()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .profile:
            ProfileScreen()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    MainView()
        .environmentObject(Navigation())
}
