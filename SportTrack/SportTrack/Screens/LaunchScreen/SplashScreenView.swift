//
//  SplashScreenView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.05.2024.
//

import SwiftUI

struct SplashScreenView: View {

    @Binding var isPresented: Bool

    @State private var opacity: Double = 1
    @State private var scale = CGSize(width: 0.8, height: 0.8)

    var body: some View {
        ZStack {
            ZStack {
                LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                Color.black.opacity(0.5)
                    .ignoresSafeArea()
            }

            Image(.app)
                .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.snappy(duration: 1)) {
                scale = CGSize(width: 1, height: 1)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
                withAnimation(.easeIn(duration: 0.3)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.45) {
                withAnimation(.easeIn(duration: 0.3)) {
                    isPresented.toggle()
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
