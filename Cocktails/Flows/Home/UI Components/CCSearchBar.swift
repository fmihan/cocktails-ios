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
                
                if isActive {
                    Button(action: {
                        text = ""
                        isActive = false
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.neutral200)
                                .frame(height: 20)
                            Image(.searchXmark)
                        }
                    })
                    .padding(.trailing, 12)
                }

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
        if text.isEmpty && !isActive {
            return Text("search.placeholder.inactive").foregroundStyle(.neutral900)
        } else {
            return Text("search.placeholder.active").foregroundStyle(.neutral900)
        }
    }
}

#Preview {
    CCSearchBar() { }
}
