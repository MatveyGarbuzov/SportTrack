//
//  TextField+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 20.04.2024.
//

import SwiftUI

extension TextField {
    func customizedTextField() -> some View {
        self
            .frame(height: 70)
            .textFieldStyle(RoundedOutlineRectangleTextFieldStyle())
    }
}

struct RoundedOutlineRectangleTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .font(.title).bold()
            .tint(.primary)
            .clipShape(RoundedRectangle(cornerRadius: .CRx4))
            .overlay {
                RoundedRectangle(cornerRadius: .CRx4)
                    .stroke()
            }
    }
}
