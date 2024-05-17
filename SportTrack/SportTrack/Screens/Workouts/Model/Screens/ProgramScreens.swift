//
//  ProgramScreens.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 05.04.2024.
//

import Foundation

extension ProgramDetailedView {

    enum Screens: Hashable {
        case startProgram(exercises: [Exercise])
        case editProgram
    }
}

extension EditProgramScreen {

    // TODO: Перенести во ViewModel всё это
    enum Screens: Hashable {
        case addExercise
    }
}
