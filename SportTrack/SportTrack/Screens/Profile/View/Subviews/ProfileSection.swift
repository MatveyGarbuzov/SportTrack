//
//  ProfileSection.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI

struct ProfileSection<Content>: View where Content: View {

    var title: String
    @ViewBuilder let content: () -> Content
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            Text(LocalizedStringKey(title))
                .title3
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal)

            content()
        }
        .onTapGesture {
            action?()
        }
    }
}
