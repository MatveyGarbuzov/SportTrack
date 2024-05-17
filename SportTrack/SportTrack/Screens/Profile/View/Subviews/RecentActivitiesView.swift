//
//  RecentActivitiesView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 13.04.2024.
//

import SwiftUI

extension ProfileScreen {

    @ViewBuilder
    var RecentActivitiesBlock: some View {
        ScrollView(.horizontal) {
            HStack(spacing: .SPx4) {
                ForEach(viewModel.getRecentActivitiesCategory, id: \.self.id) { activity in
                    card(activity: activity)
                        .frame(width: Constants.cardSize, height: Constants.cardSize)
                }
            }
            .padding()
        }
        .frame(height: Constants.scrollViewHeight, alignment: .top)
    }

    func card(activity: RecentActivitiesCategory) -> some View {
        ZStack(alignment: .leading) {
            CardBackground(color: activity.color)

            VStack(alignment: .leading) {
                RecentAcitvityCircleView(iconName: activity.iconName, color: activity.color)
                    .frame(height: Constants.cardSize * 0.2, alignment: .topLeading)
                    .offset(CGSize(width: Constants.imageOffset, height: Constants.imageOffset))

                CartTitleSubtitle(activity: activity)
                    .frame(width: Constants.cardSize, height: Constants.cardSize * 0.8, alignment: .leading)
            }
        }
    }

    func CartTitleSubtitle(activity: RecentActivitiesCategory) -> some View {
        VStack(alignment: .leading) {
            Spacer()

            // TODO: Переделать модель, чтобы доставать значения
            CardPoints("100", lastAddedPoints: "+5", color: activity.color)
            CardTitle(activity.typeTitle)
        }
        .padding([.leading, .bottom], .SPx2)
    }

    func CardPoints(_ points: String, lastAddedPoints: String, color: Color) -> some View {
        HStack(alignment: .lastTextBaseline, spacing: .SPx1) {
            Text(points)
                .title2

            Text(lastAddedPoints)
                .callout
                .bold()
                .foregroundStyle(color.secondary)
        }
        .lineLimit(1)
    }

    func CardTitle(_ title: String) -> some View {
        Text(title)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
    }

    func CardBackground(color: Color) -> some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: Constants.backgroundCircleSize, height: Constants.backgroundCircleSize)
                .offset(CGSize(width: -45, height: -35))

            Rectangle()
                .fill(Material.ultraThin)

        }
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
        .shadow(color: .primary.opacity(0.1), radius: 2, x: Constants.shadowOffset, y: Constants.shadowOffset)
    }
}

fileprivate extension ProfileScreen {

    enum Constants {
        static let cardSize: CGFloat = 120
        static let scrollViewHeight: CGFloat = 150
        static let imageOffset: CGFloat = .SPx3
        static let backgroundCircleSize: CGFloat = 75
        static let shadowOffset: CGFloat = .SPx1
    }
}

#Preview {
    ProfileScreen(viewModel: .mockData)
}
