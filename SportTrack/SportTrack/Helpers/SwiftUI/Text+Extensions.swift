//
//  Text+Extensions.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 12.04.2024.
//

import SwiftUI

extension Text {

    var largeTitle: some View {
        font(.largeTitle)
            .bold()
    }

    var title1: some View {
        font(.title)
            .bold()
    }

    // TODO: Перименовать и сделать по дефолту  bold(), другие проглядеть, поставить .style(.secondary)
    var title2: some View {
        font(.title2)
            .bold()
    }

    var title3: some View {
        font(.title3)
            .bold()
    }

    var callout: some View {
        font(.callout)
    }

    var headline: some View {
        font(.headline)
    }

    var subheadline: some View {
        font(.subheadline)
    }

    var footnote: some View {
        font(.footnote)
    }
}
