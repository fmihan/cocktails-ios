//
//  Stretchy.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

struct Stretchy: ViewModifier {

    func heightFor(_ reader: GeometryProxy) -> CGFloat {
        let height = reader.size.height
        let frame  = reader.frame(in: .global)
        let deltaY = frame.minY
        return height + max(0, deltaY)
    }

    func offsetFor(_ reader: GeometryProxy) -> CGFloat {
        let frame  = reader.frame(in: .global)
        let deltaY = frame.minY
        return min(0, -deltaY)
    }

    func body(content: Content) -> some View {
        GeometryReader { reader in
            Color.clear
                .overlay(content.aspectRatio(contentMode: .fill), alignment: .center)
                .clipped()
                .frame(height: heightFor(reader))
                .offset(y: offsetFor(reader))
        }
    }
}
