//
//  UINavigationController+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 17.04.2024.
//

import UIKit

extension UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        // Позволяет сделать плавный свайп назад
        interactivePopGestureRecognizer?.delegate = nil
    }
}
