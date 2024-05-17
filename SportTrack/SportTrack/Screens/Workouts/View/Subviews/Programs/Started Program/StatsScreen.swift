//
//  StatsScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 31.04.2024.
//

import SwiftUI

struct StatsView: View {

    var exercise: Exercise

    var groupedDataByYears: [(String, [PreviousSetsAndWeights])] {
        Dictionary(
            grouping: exercise.previousSetsAndWeights,
            by: {
                let year = Calendar.current.component(.year, from: $0.date)
                return String(year)
            }
        ).sorted(by: { $0.key > $1.key })
    }

    var body: some View {
        NavigationView {
            MainBlock
                .navigationTitle(exercise.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
    }
}


// MARK: - UI Subviews

extension StatsView {

    var MainBlock: some View {
        ScrollView {
            VStack(spacing: .SPx3) {
                ForEach(groupedDataByYears, id: \.0) { year, previousSetsAndWeights in
                    Text(year)
                        .title3

                    BlockByMonths(year, previousSetsAndWeights: previousSetsAndWeights)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.SPx6)
            .scrollClipDisabled()
        }
    }

    func BlockByMonths(_ year: String, previousSetsAndWeights: [PreviousSetsAndWeights]) -> some View {
        let groupedDataByMonth: [(String, [PreviousSetsAndWeights])] = Dictionary(
            grouping: previousSetsAndWeights,
            by: {
                let month = Calendar.current.component(.month, from: $0.date)
                return String(month)
            }
        ).sorted(by: { Int($0.key) ?? 0 < Int($1.key) ?? 0 })


        return VStack(spacing: .SPx5) {
            ForEach(groupedDataByMonth, id: \.0) { month, data in
                BlockByDays(month, previousSetsAndWeights: data)
            }
        }
    }

    func BlockByDays(_ month: String, previousSetsAndWeights: [PreviousSetsAndWeights]) -> some View {
        let groupedDataByDays: [(String, [PreviousSetsAndWeights])] = Dictionary(
            grouping: previousSetsAndWeights,
            by: {
                let day = Calendar.current.component(.day, from: $0.date)
                return String(day)
            }
        ).sorted(by: { Int($0.key) ?? 0 < Int($1.key) ?? 0 })
        let monthStringFull = monthStringFull(Int(month) ?? 0)
        let monthString = monthString(Int(month) ?? 0)

        return VStack(alignment: .leading) {
            Text(LocalizedStringKey(monthStringFull))
                .title3

            ScrollView(.horizontal) {
                HStack {
                    ForEach(groupedDataByDays, id: \.0) { day, data in
                        ForEach(data) { data in
                            SetsAndWeightsCell(day: day, month: monthString, setsAndWeights: data.setsAndWeights)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    func SetsAndWeightsCell(day: String, month: String, setsAndWeights: [SetAndWeight]) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(day + .space)
                    .headline
                    .lineLimit(1)
                Text(LocalizedStringKey(month))
                    .headline
                    .lineLimit(1)
            }


            ForEach(setsAndWeights) { data in
                let weight: String = String(format: "%.1f",data.weight ?? 0)
                let reps: String = String(data.reps ?? 0)

                HStack(alignment: .lastTextBaseline, spacing: .SPx0_5) {
                    Text(weight)
                        .subheadline

                    Text("x")
                        .footnote

                    Text(reps)
                        .subheadline
                }
                .lineLimit(1)
            }

            Spacer()
        }
        .padding(.SPx2)
        .frame(maxWidth: 150)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: .CRx2))
    }

    func monthString(_ month: Int) -> String {
        switch month {
        case 1: return "Jan"
        case 2: return "Feb"
        case 3: return "Mar"
        case 4: return "Apr"
        case 5: return "May"
        case 6: return "Jun"
        case 7: return "Jul"
        case 8: return "Aug"
        case 9: return "Sep"
        case 10: return "Oct"
        case 11: return "Nov"
        case 12: return "Dec"
        default: return ""
        }
    }

    func monthStringFull(_ month: Int) -> String {
        switch month {
        case 1: "January"
        case 2: "February"
        case 3: "March"
        case 4: "April"
        case 5: "May"
        case 6: "June"
        case 7: "July"
        case 8: "August"
        case 9: "September"
        case 10: "October"
        case 11: "November"
        case 12: "December"
        default: ""
        }
    }
}
