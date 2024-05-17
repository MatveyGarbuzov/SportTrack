//
//  TabBarView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var nav: Navigation
    @State private var allTabs: [AnimatedTab] = TabBarItem.allCases.compactMap {
        AnimatedTab(TabBarItem: $0)
    }

    var body: some View {
        CustomTabBar
    }
}

// MARK: - Private Subviews

private extension TabBarView {

    @ViewBuilder
    var CustomTabBar: some View {
        HStack(spacing: 0) {
            ForEach($allTabs) { $animatedTab in
                let tabBarItem = animatedTab.TabBarItem
                VStack(spacing: 2) {
                    Image(systemName: nav.activeTab == tabBarItem ? tabBarItem.imageNameFilled : tabBarItem.imageName)
                        .font(.title2)
                        .symbolEffect(.bounce.down.byLayer, value: animatedTab.isAnimating)

                    Text(LocalizedStringKey(tabBarItem.title))
                        .textCase(.uppercase)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(nav.activeTab == tabBarItem ? Color.primary : .primary.opacity(0.6))
                .padding(.vertical, 5)

                .contentShape(.rect)
                .onTapGesture {
                    nav.activeTab = tabBarItem
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                        animatedTab.isAnimating = true
                    } completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    }
                }
            }
        }
        .background(Material.ultraThin)
    }
}

// MARK: - Preview

#Preview {
    TabBarView()
        .environmentObject(Navigation())
}

// MARK: - Constants

struct AnimatedTab: Identifiable {
    var id = UUID()
    var TabBarItem: TabBarItem
    var isAnimating: Bool?
}
