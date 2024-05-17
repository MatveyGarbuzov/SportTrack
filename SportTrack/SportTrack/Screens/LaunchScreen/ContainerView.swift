//
//  ContainerView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI

struct ContainerView: View {

    @State private var isSplashScreenViewPresented: Bool = true

    var body: some View {
        if isSplashScreenViewPresented {
            SplashScreenView(isPresented: $isSplashScreenViewPresented)
        } else {
            MainView()
        }
    }
}

#Preview {
    ContainerView()
}
