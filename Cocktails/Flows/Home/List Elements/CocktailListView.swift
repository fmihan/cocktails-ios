//
//  CocktailListView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI

struct CocktailListView: View {

    let cocktail: Cocktail

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.black)
                .frame(width: 74, height: 84)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))

            VStack(alignment: .leading, spacing: 0) {
                Text(cocktail.cocktailName)
                    .font(.A1Bold)
                    .kerning(-0.4)
                    .foregroundStyle(.neutral900)

                Text(cocktail.cocktailIngredients.joined(separator: ", "))
                    .font(.A1)
                    .kerning(-0.4)
                    .foregroundStyle(.neutral500)
                    .lineLimit(1)
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
    }
}
