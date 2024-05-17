//
//  ConfettisView.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 02.04.2024.
//

import SwiftUI

struct ConfettisView: View {

    @State var confettiAnimate: [Bool] = [false]
    @State var confettiFinishedAnimationCouter = 0
    @State var confettiCounter = 0
    @State private var confettiTimer: Timer?

    /// Длительность анимации выпуска конфетти
    private let animationDuration: CGFloat = 2.5
    /// Кол-во конфетти выстреливающихся за один раз
    private let confettiCount: Int = 4

    var body: some View {
        VStack{
            ZStack{
                ForEach(confettiFinishedAnimationCouter...confettiCounter, id:\.self) { index in
                    ConfettiContainer(
                        animate: $confettiAnimate[index],
                        finishedAnimationCouter: $confettiFinishedAnimationCouter,
                        confettiCount: confettiCount
                    )
                }
            }
        }
        .onAppear {
            startConfettiTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                stopConfettiTimer()
            }
        }
    }

    func startConfettiTimer()  {
        confettiTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            confettiAnimate[confettiCounter].toggle()
            confettiAnimate.append(false)
            confettiCounter += 1
        }

        _ = confettiTimer
    }

    func stopConfettiTimer() {
        confettiTimer?.invalidate()
    }
}

struct Movement {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var opacity: Double
}

struct ConfettiContainer: View {
    @Binding var animate: Bool
    @Binding var finishedAnimationCouter: Int

    var confettiCount: Int

    var body: some View{
        ZStack{
            ForEach(0...confettiCount-1, id:\.self) { _ in
                Confetti(animate: $animate, finishedAnimationCouter:$finishedAnimationCouter)
            }
        }
        .onChange(of: animate) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                finishedAnimationCouter += 1
            }
        }
    }
}

struct Confetti: View {

    @Binding var animate: Bool
    @Binding var finishedAnimationCouter: Int
    @State var movement = Movement(x: 0, y: 0, z: 1.3, opacity: 0)

    /// Время, за которое конфетти доходит до верха
    private let timeToTheTop: CGFloat = 0.5
    /// Время, которое конфетти находится сверху, после начинает падать вниз
    private let timeAtTheTop: CGFloat = 0.4
    /// Рандомная позиция по оси-х
    private var randomX: CGFloat { CGFloat.random(in: -200...200) }
    /// Рандомная позиция по оси-y
    private var randomY: CGFloat { -300 * CGFloat.random(in: 0.7...1) }

    var body: some View{
        SingleConfettiView()
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.z)
            .opacity(movement.opacity)
            .onChange(of: animate) { _, _ in
                withAnimation(Animation.easeOut(duration: timeToTheTop)) {
                    movement.opacity = 1
                    movement.x = randomX
                    movement.y = randomY
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + timeAtTheTop) {
                    withAnimation(Animation.easeIn(duration: 3)) {
                        movement.y = 500
                        movement.opacity = 0.0
                    }
                }
            }
    }
}

struct SingleConfettiView: View {

    @State private var animate = false
    @State private var xSpeed = Double.random(in: 0.7...2)
    @State private var zSpeed = Double.random(in: 1...2)
    @State private var anchor = CGFloat.random(in: 0...1).rounded()

    private var randomColor: Double { Double.random(in: 0...1) }

    var body: some View {
        Rectangle()
            .fill(Color(red: randomColor, green: randomColor, blue: randomColor))
            .frame(edge: 10, alignment: .center)
            .onAppear(perform: { animate = true })
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 1, y: 0, z: 0))
            .animation(Animation.linear(duration: xSpeed).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: anchor, y: anchor))
            .animation(Animation.linear(duration: zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}
