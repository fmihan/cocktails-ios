//
//  HomeView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI

struct HomeView: View {

    let viewModel = ViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Color(.blue500)
                .ignoresSafeArea(.container, edges: .top)
            VStack(spacing: 0) {
                CCSearchBar(
                    filtersTapped: viewModel.openFilters
                ).zIndex(1)

                List(0..<12) { _ in
                    CocktailListView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .listRowInsets(.none)
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .background(.blue100)
            }
            .overlay(alignment: .bottom) {
                Button("FEELING LUCKY") {

                }
                .buttonStyle(
                    RoundedButtonStyle(
                        style: .withTextPadding(ofSize: 50)
                    )
                )

            }
        }
    }
}

#Preview {
    HomeView()
}
