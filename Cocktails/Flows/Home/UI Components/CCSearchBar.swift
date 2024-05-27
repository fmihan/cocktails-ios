//
//  CCSearchBar.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI

struct CCSearchBar: View {

    @FocusState private var isActive: Bool
    @State var text = ""

    var filtersTapped: (() -> Void)

    var body: some View {
        HStack(spacing: 16) {
            HStack {
                Image(.searchMagnifyingglass)
                    .padding(.leading, 10)
                TextField("",text: $text, prompt: textFieldPrompt)
                .font(.A1)
                .kerning(-0.5)
                .padding(.vertical, 12)
                .tint(.black)
                .focused($isActive)
            }
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))

            if !isActive {
                Button(action: filtersTapped) {
                    Image(.filter)
                }
            }
        }
        .animation(.interpolatingSpring, value: isActive)
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .foregroundStyle(.blue800)
                .frame(height: 1)
                .shadow(color: .black.opacity(0.5), radius: 1, x: 0, y: 1)
        })
    }

    var textFieldPrompt: Text {
        Text((text.isEmpty && !isActive) ? "Search" : "Type to search")
            .foregroundStyle(isActive ? .neutral500 : .neutral900)
    }
}
