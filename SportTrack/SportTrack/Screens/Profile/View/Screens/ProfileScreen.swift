//
//  ProfileScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI

struct ProfileScreen: View {

    @Environment(\.modelContext) var context
    @State private var userViewModel = UserViewModel()
    @State var user = User()

    typealias ViewModel = ProfileViewModel

    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var nav: Navigation

    init(viewModel: ViewModel = .mockData) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        MainView
            .customNavBar(title: "Profile")
            .customTabBarItem(placement: .topBarTrailing, iconName: "pencil") {
                open(.editProfile)
            }
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .editProfile:
                    EditProfileScreen()
                case .achievementsScreen:
                    Text("achievementsScreen")
                case .recentActivitiesScreen:
                    RecentActivitiesScreen()
                }
            }
            .onAppear {
                userViewModel.context = context

                guard let userFromMemory = userViewModel.read() else { return }
                user = userFromMemory
            }
    }
}

// MARK: - Actions

extension ProfileScreen {

    func open(_ screen: Screens) {
        nav.addScreen(screen: screen)
    }

    enum Screens {
        case editProfile
        case achievementsScreen
        case recentActivitiesScreen
    }
}

#Preview {
    MainView()
        .environmentObject(Navigation())
}
