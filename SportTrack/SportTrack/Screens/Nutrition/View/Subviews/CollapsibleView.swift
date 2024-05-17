//
//  CollapsibleView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 28.04.2024.
//

import SwiftUI

struct CollapsibleView<Content>: View where Content: View {
    @State private var isSecondaryViewVisible = false

    var title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        Group {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(.background.opacity(0.0001))


                if isSecondaryViewVisible {
                    Image(systemName: "xmark.circle")
                }
            }
            .onTapGesture {
                withAnimation {
                    isSecondaryViewVisible.toggle()
                }
            }

            if isSecondaryViewVisible {
                content()
            }
        }
    }
}

#Preview {
    RecipeFiltersScreen(filterSettings: .init()) { _ in }
}
