//
//  LoadingView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI


struct LoadingView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color(.blue500)
                .ignoresSafeArea(.all)
            VStack {
                Text("loding.view.title")
                    .multilineTextAlignment(.center)
                    .font(.ccFont(ofSize: 25, weight: .bold))
                    .kerning(-0.6)
                    .environment(\._lineHeightMultiple, 0.65)
                    .shadow(radius: 2)

                Image(.coctail)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    LoadingView()
}
