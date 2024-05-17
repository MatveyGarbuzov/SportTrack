//
//  View+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI

extension View {
    
    func frame(edge size: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(size: CGSize(width: size, height: size), alignment: alignment)
    }

    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
}

extension View {
    
    func backNavBarButton(withBackground: Bool = true, action: @escaping () -> Void) -> some View {
        customTabBarItem(placement: .topBarLeading, iconName: "chevron.backward", withBackground: withBackground, action: action)
    }

    func checkmarkNavBarButton(action: @escaping () -> Void) -> some View {
        customTabBarItem(placement: .topBarTrailing, iconName: "checkmark", action: action)
    }

    func customTabBarItem(
        placement: ToolbarItemPlacement,
        iconName: String,
        withBackground: Bool = true,
        action: @escaping () -> Void
    ) -> some View {
        self.toolbar {
            ToolbarItem(placement: placement) {
                Button(action: action) {
                    ZStack {
                        if withBackground {
                            Circle()
                                .fill(.ultraThinMaterial)
                        }

                        Image(systemName: iconName)
                            .tint(.primary)
                    }
                    .frame(edge: 44)
                }
            }
        }
    }

    func customNavBar(title: String) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .navigationTitle(LocalizedStringKey(title))
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {

    func viewSize(size: Binding<CGSize>) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size.wrappedValue = proxy.size
                    }
            }
        }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
