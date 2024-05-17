//
//  AcitvityCircleView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 17.04.2024.
//

import SwiftUI

struct AcitvityCircleView: View {

    var activity: ActivityCategory

    var body: some View {
            ZStack {
                Image(systemName: activity.iconName)
                    .background(
                        Circle()
                            .fill(activity.color)
                            .frame(edge: .imageCircleSize)
                    )
                    .frame(edge: .imageSize)
                    .foregroundStyle(.white)
        }
    }
}

struct RecentAcitvityCircleView: View {

    var iconName: String
    var color: Color

    var body: some View {
        ZStack {
            Image(systemName: iconName)
                .background(
                    Circle()
                        .fill(color)
                        .frame(edge: .imageCircleSize)
                )
                .frame(edge: .imageSize)
                .foregroundStyle(.white)
        }
    }
}

// MARK: - Constants

private extension CGFloat {

    static let imageCircleSize: CGFloat = 30
    static let imageSize: CGFloat = 16
}
