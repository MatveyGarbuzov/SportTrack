//
//  Buttons.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 18.04.2024.
//

import SwiftUI

struct FillButton: View {
    var title: String
    var action: (() -> Void)? = nil
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button{
            action?()
        } label: {
            Text(LocalizedStringKey(title))
                .foregroundColor(colorScheme == .dark ?  Color.black : .white)
                .title3
                .padding()
                .frame(maxWidth: .infinity, minHeight: .height)
                .background {
                    RoundedRectangle(cornerRadius: .CRx4)
                        .fill(colorScheme == .dark ?  Color.white : .black)
                }
        }
    }
}

struct BorderButton: View {
    var title: String
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            Text(LocalizedStringKey(title))
                .foregroundColor(.primary)
                .title3
                .padding(.horizontal, .SPx3)
                .frame(maxWidth: .infinity, minHeight: .height)
                .overlay {
                    RoundedRectangle(cornerRadius: .CRx4)
                        .stroke()
                        .tint(.primary)
                }
        }
    }
}

struct IconButton: View {
    var iconName: String
    var withOverlay: Bool = true
    var size: CGSize
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: iconName)
                .frame(size: size)
                .foregroundColor(.primary)
                .if(withOverlay) {
                    $0.overlay {
                        Circle()
                            .stroke()
                            .tint(.primary)
                    }
                }
        }
    }
}

// MARK: - Constants

fileprivate extension CGFloat {

    static let height: CGFloat = 52
}
