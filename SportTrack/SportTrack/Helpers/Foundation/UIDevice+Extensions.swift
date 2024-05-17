//
//  UIDevice+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 14.04.2024.
//

import UIKit

extension UIDevice {

    static var isSe: Bool {
        self.current.name.contains("SE")
    }
}
