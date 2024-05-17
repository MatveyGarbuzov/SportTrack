//
//  CollapsibleInlinePicker.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 28.04.2024.
//

import SwiftUI

struct CollapsibleInlinePicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    var title: String
    @Binding var selection: SelectionValue
    @ViewBuilder let content: () -> Content

    var body: some View {
        CollapsibleView(title: title) {
            Picker(selection: $selection, content: content) {
                EmptyView()
            }
            .pickerStyle(.inline)
        }
    }
}
