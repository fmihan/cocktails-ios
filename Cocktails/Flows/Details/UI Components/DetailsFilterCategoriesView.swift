//
//  DetailsFilterCategoriesView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

struct DetailsFilterCategoriesView: View {

    let details: [CocktailDetailsFilter]

    var body: some View {
        HStack {
            ForEach(details) { detail in
                Spacer()

                VStack {
                    Circle()
                        .stroke(.neutral200, lineWidth: 2)
                        .fill(.white)
                        .frame(height: 50)
                        .overlay {
                            Image(detail.filterCategory.image)
                        }

                    Text(detail.value)
                        .font(.A1)
                        .kerning(-0.6)
                        .foregroundStyle(.neutral900)
                }

                Spacer()
            }
        }
        .background {
            Rectangle()
                .fill(.blue100)
                .clipShape(
                    .rect(
                        topLeadingRadius: 40,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 40,
                        style: .continuous
                    )
                )
                .padding(.top, -20)
        }
    }
}
