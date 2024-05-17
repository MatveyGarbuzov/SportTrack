//
//  SegmentedControl.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 14.04.2024.
//

import SwiftUI

extension WorkoutScreen {

    var SegmentedControlBlock: some View {

        GeometryReader {
            let minY = $0.frame(in: .global).minY
            let offsetFromNavBar: CGFloat = .navBarHeight + .SPx4 - minY

            SegmentedControl(
                tabs: SegmentedControlTab.allCases,
                activeTab: $activeTab
            ) { size in
                RoundedRectangle(cornerRadius: Constants.segmentedControlRadius)
                    .fill(.blue)
                    .frame(height: size.height)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .background {
                RoundedRectangle(cornerRadius: Constants.segmentedControlRadius)
                    .fill(.thinMaterial)
                    .ignoresSafeArea()
            }
            .padding(.horizontal)
            .offset(y: max(offsetFromNavBar, 0))
        }
        .zIndex(1)
    }

    struct SegmentedControl<Indicator: View>: View {

        var tabs: [SegmentedControlTab]
        @Binding var activeTab: SegmentedControlTab

        @ViewBuilder var indicatorView: (CGSize) -> Indicator

        @State private var excessTabWidth: CGFloat = .zero
        @State private var minX: CGFloat = .zero

        var body: some View {
            GeometryReader { geometry in
                let size = geometry.size
                let containerWidthForEachTab = size.width / CGFloat(tabs.count)

                HStack(spacing: 0) {
                    ForEach(tabs, id: \.rawValue) { tab in
                        TabText(tab.rawValue, currentTab: tab)
                            .animation(.snappy, value: activeTab)
                            .onTapGesture {
                                if let index = tabs.firstIndex(of: tab), let activeIndex = tabs.firstIndex(of: activeTab) {
                                    activeTab = tab
                                    withAnimation(.snappy(duration: Constants.animationDuration, extraBounce: 0), completionCriteria: .logicallyComplete) {
                                        excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
                                    } completion: {
                                        withAnimation(.snappy(duration: Constants.animationDuration, extraBounce: 0)) {
                                            minX = containerWidthForEachTab * CGFloat(index)
                                            excessTabWidth = 0
                                        }
                                    }
                                }
                            }
                        .background(alignment: .leading) {
                            if tabs.first == tab {
                                GeometryReader {
                                    let size = $0.size

                                    indicatorView(size)
                                        .frame(width: size.width + (excessTabWidth < 0 ? -excessTabWidth : excessTabWidth), height: size.height)
                                        .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                                        .offset(x: minX)
                                }
                            }
                        }
                    }
                }
                .preference(key: SizeKey.self, value: size)
                .onPreferenceChange(SizeKey.self) { size in
                    guard let index = tabs.firstIndex(of: activeTab) else { return }
                    minX = containerWidthForEachTab * CGFloat(index)
                    excessTabWidth = 0
                }
            }
            .frame(height: Constants.height)
        }

        func TabText(_ text: String, currentTab tab: SegmentedControlTab) -> some View {
            Text(LocalizedStringKey(text))
                .font(.title3)
                .bold()
                .foregroundStyle(activeTab == tab ? Color.primary : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(.rect)
        }
    }

    // TODO: Можно избавиться? Добавлялся для поворота экрана
    fileprivate struct SizeKey: PreferenceKey {

        static var defaultValue: CGSize = .zero
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
}

fileprivate extension WorkoutScreen {

    enum Constants {
        static let height: CGFloat = 45
        static let segmentedControlRadius: CGFloat = .CRx8
        static let animationDuration: CGFloat = 0.25
    }
}
