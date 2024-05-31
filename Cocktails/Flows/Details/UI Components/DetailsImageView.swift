//
//  DetailsImageView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import SwiftUI
import Kingfisher

struct DetailsImageView: View {
    let imageUrl: String

    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .placeholder { ProgressView().progressViewStyle(.circular) }
            .stretchy()
            .aspectRatio(contentMode: .fill)
            .frame(height: 300)
    }
}
