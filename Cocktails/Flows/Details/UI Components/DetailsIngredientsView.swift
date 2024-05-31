//
//  DetailsIngredientsView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

struct DetailsIngredientsView: View {
    let ingredients: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("details.view.ingredients")
                .font(.A1Bold)
                .kerning(-0.6)

            LazyVStack(alignment: .leading) {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .font(.A1)
                        .kerning(-0.6)
                        .padding(.leading, 4)
                }
            }
        }
    }
}

