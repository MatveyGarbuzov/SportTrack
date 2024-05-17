//
//  Array+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 21.04.2024.
//

import Foundation

extension Array {

    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }

        return self[index]
    }
}
