//
//  Navigation.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI

final class Navigation: ObservableObject {
    @Published var path = NavigationPath()
    @Published var activeTab: TabBarItem = .workouts
}

extension Navigation {

    func removeAll() {
        path.removeLast(path.count)
    }

    func addScreen<T: Hashable>(screen: T) {
        path.append(screen)
    }

    func openPreviousScreen() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
