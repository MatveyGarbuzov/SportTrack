//
//  SDUser.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 03.05.2024.
//

import SwiftUI
import SwiftData
import Foundation

@Model
final class SDUser {
    var name:  String
    var image: Data?

    init(name: String, image: Data?) {
        self.name = name
        self.image = image
    }
}
