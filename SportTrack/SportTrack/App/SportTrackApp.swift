//
//  SportTrackApp.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 11.04.2024.
//

import SwiftUI
import SwiftData

@main
struct SportTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .modelContainer(for: [SDEatenRecipe.self, SDExercise.self, SDProgram.self, SDUser.self])
        }
    }
}
