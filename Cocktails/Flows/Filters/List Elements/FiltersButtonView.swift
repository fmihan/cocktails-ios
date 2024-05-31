//
//  FiltersButtonView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import SwiftUI

struct FiltersButtonView: View {

    var selected: Bool
    var title: String
    var onTap: (() -> Void)

    var body: some View {
        HStack {
            Image(selected ? .radioButtonOn : .radioButtonOff)
            Text(title)
                .font(.A1)
                .kerning(-0.6)
                .foregroundStyle(.neutral900)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    FiltersButtonView(selected: false, title: "Lorem Ipsum") {}
}
