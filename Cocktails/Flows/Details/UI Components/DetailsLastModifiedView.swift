//
//  DetailsLastModifiedView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI

struct DetailsLastModifiedView: View {

    let time: String

    var body: some View {
        HStack(spacing: 4) {
            Text("details.view.lastModified")
                .font(.A1Bold)
                .kerning(-0.6)
            +
            Text(" \(time)")
                .font(.A1)
                .kerning(-0.6)

            Spacer()
        }


    }

}
