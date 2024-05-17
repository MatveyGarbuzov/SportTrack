//
//  PersonBlockView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI

extension ProfileScreen {

    var PersonBlock: some View {
        HStack(spacing: .SPx4) {
            ImageBlock
            PersonTextBlock
        }
        .padding(.horizontal)
    }

    var ImageBlock: some View {
        Image(uiImage: UIImage(data: user.image ?? .empty) ?? .profile)
            .resizable()
            .clipShape(.circle)
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.imageEdge, height: Constants.imageEdge)
            .onTapGesture {
                viewModel.increasePercentage()
            }
    }

    var PersonTextBlock: some View {
        VStack(alignment: .leading) {
            PersonName
            PersonExperience
            PersonLevelProgressBar
            PersonLevel
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }

    var PersonName: some View {
        Text(user.name)
            .title2
            .lineLimit(1)
    }

    var PersonExperience: some View {
        Text(LocalizedStringKey(viewModel.getUserExperience))
            .subheadline
            .foregroundStyle(.secondary)
            .lineLimit(1)
    }

    var PersonLevelProgressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.primary.opacity(Constants.progressBarBackgroundOpacity))

                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: .init(colors: [.green, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: min(viewModel.user.stats.percentage * geometry.size.width, geometry.size.width))
                    .animation(.bouncy, value: viewModel.user.stats.percentage)
            }
            .clipped()
        }
        .frame(height: Constants.progressBarHeight)
    }

    var PersonLevel: some View {
        HStack(spacing: 0) {
            Text(LocalizedStringKey("Level"))
                .footnote
                .bold()
                .animation(.snappy, value: viewModel.user.stats.level)
                .contentTransition(.numericText())
                .lineLimit(1)
            Text(viewModel.getLevelString())
                .footnote
                .bold()
                .animation(.snappy, value: viewModel.user.stats.level)
                .contentTransition(.numericText())
                .lineLimit(1)
        }
    }
}

fileprivate extension ProfileScreen {

    enum Constants {
        static let imageEdge: CGFloat = 90
        static let progressBarHeight: CGFloat = 10
        static let progressBarBackgroundOpacity: CGFloat = 0.1
    }
}
