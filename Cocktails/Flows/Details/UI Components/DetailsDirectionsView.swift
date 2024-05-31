//
//  DetailsDirectionsView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

struct DetailsDirectionsView: View {

    let directions: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("details.view.directions")
                .font(.A1Bold)
                .kerning(-0.6)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(directions)
                .font(.A1)
                .kerning(-0.6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
