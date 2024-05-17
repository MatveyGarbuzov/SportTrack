//
//  CGFloat+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import UIKit

extension CGFloat {

    static let navBarHeight: CGFloat = UIDevice.isSe ? 64 : 96
    static let tabBarSpacing: CGFloat = UIDevice.isSe ? .SPx20 : .SPx20
}

// MARK: - Spacings

extension CGFloat {

    /// Spacing of 2
    static let SPx0_5: CGFloat = 2
    /// Spacing of 4
    static let SPx1: CGFloat = 4
    /// Spacing of 8
    static let SPx2: CGFloat = 8
    /// Spacing of 12
    static let SPx3: CGFloat = 12
    /// Spacing of 16
    static let SPx4: CGFloat = 16
    /// Spacing of 20
    static let SPx5: CGFloat = 20
    /// Spacing of 24
    static let SPx6: CGFloat = 24
    /// Spacing of 40
    static let SPx10: CGFloat = 40
    /// Spacing of 48
    static let SPx12: CGFloat = 48
    /// Spacing of 60
    static let SPx15: CGFloat = 60
    /// Spacing of 80
    static let SPx20: CGFloat = 80
}

// MARK: - Radiuses

extension CGFloat {

    /// Corner radius of 4
    static let CRx1: CGFloat = 4
    /// Corner radius of 8
    static let CRx2: CGFloat = 8
    /// Corner radius of 12
    static let CRx3: CGFloat = 12
    /// Corner radius of 16
    static let CRx4: CGFloat = 16
    /// Corner radius of 20
    static let CRx5: CGFloat = 20
    /// Corner radius of 32
    static let CRx8: CGFloat = 32
}
