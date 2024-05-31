//
//  CocktailListView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI
import Kingfisher

struct CocktailListView: View {

    var searchText: String? = nil
    let cocktail: Cocktail
    let onTap: (() -> Void)

    var body: some View {
        HStack(alignment: .center, spacing: 0) {

            KFImage(cocktail.urlForImage)
                .resizable()
                .placeholder { ProgressView().progressViewStyle(.circular) }
                .frame(width: 74, height: 84)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))

            VStack(alignment: .leading, spacing: 0) {
                Text(highlightedText())
                    .font(.A1)
                    .kerning(-0.4)
                    .foregroundStyle(.neutral900)

                if !cocktail.cocktailIngredients.isEmpty {
                    Text(cocktail.cocktailIngredients.joined(separator: ", "))
                        .font(.A1)
                        .kerning(-0.4)
                        .foregroundStyle(.neutral500)
                        .lineLimit(1)
                }

            }
            .padding(.leading, 24)

            Spacer()
        }
        .padding(20)
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(.blue300)
                .frame(height: 1.5)
                .padding(.horizontal, 20)
        })
        .background(.blue100)
        .onTapGesture {
            onTap()
        }
        .contentShape(Rectangle())
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }

    func highlightedText() -> LocalizedStringKey {
        guard let searchText, !searchText.isEmpty else {
            return "**\(cocktail.cocktailName)**"
        }

        if let range = cocktail.cocktailName.range(of: searchText, options: .caseInsensitive) {
            let highlighted = cocktail.cocktailName.replacingOccurrences(of: searchText.lowercased(), with: "**\(searchText.lowercased())**", options: .caseInsensitive, range: range)
            return LocalizedStringKey(highlighted)
        } else {
            return LocalizedStringKey(cocktail.cocktailName)
        }
    }
}
