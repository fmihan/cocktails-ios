//
//  ViewExtension.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

extension View {
    func stretchy() -> some View {
        self.modifier(Stretchy())
    }
}
