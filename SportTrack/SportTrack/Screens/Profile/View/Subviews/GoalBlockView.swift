//
//  GoalBlockView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI
import Charts

extension ProfileScreen {

    var GoalBlock: some View {
        HStack(spacing: .SPx4) {
            GoalTextInfo
            GoalChart
        }
        .padding(.horizontal)
        .frame(height: Constants.goalBlockHeight)
    }

    var GoalTextInfo: some View {
        VStack(alignment: .leading) {
            TotalTitle
            Points
        }
    }

    var TotalTitle: some View {
        HStack(spacing: 0) {
            Text(LocalizedStringKey("Total"))
                .callout
                .bold()
                .foregroundStyle(.secondary)

            Text(viewModel.getTotalString)
                .callout
                .bold()
                .foregroundStyle(.secondary)
        }
    }

    var Points: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
            Text(viewModel.getCurrentAmountOfPointsString)
                .title2

            HStack(spacing: 0) {
                Text(viewModel.getPointsToAchieveString)
                    .callout
                    .foregroundStyle(.secondary)

                Text(LocalizedStringKey("points"))
                    .callout
                    .foregroundStyle(.secondary)
            }
        }
    }

    var GoalChart: some View {
        Chart {
            ForEach(viewModel.getGoalChartData) { data in
                LineMark(
                    x: .value("", data.day),
                    y: .value("", data.points)
                )
                .interpolationMethod(.cardinal)
                .symbol {
                    Circle()
                        .fill(.secondary)
                        .frame(width: 5, height: 5)
                }
            }

            ForEach(viewModel.getGoalChartData) { data in
                AreaMark(
                    x: .value("", data.day),
                    y: .value("", data.points)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.5), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: Constants.chartHeight)
    }
}

fileprivate extension ProfileScreen {

    enum Constants {
        static let goalBlockHeight: CGFloat = 140
        static let chartHeight: CGFloat = 100
    }
}
