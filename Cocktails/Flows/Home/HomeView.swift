//
//  HomeView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI
import FlowStacks

struct HomeView: View {

    @EnvironmentObject var navigator: FlowNavigator<AppScreen>
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Color(.blue500)
                .ignoresSafeArea(.container, edges: .top)
            VStack(spacing: 0) {
                CCSearchBar(
                    text: $viewModel.searchText,
                    filtersTapped: {
                        navigator.push(.filters)
                    }
                ).zIndex(1)

                List(viewModel.cocktails) { cocktail in
                    CocktailListView(
                        cocktail: cocktail,
                        onTap: { navigator.push(.details(id: cocktail.id)) }
                    )
                }
                .listStyle(.plain)
                .listRowInsets(.none)
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .background(.blue100)
            }
            .overlay(alignment: .bottom) {
                Button("home.button.feelingLucky") {
                    viewModel.fetchRandomCocktail()
                }
                .buttonStyle(
                    RoundedButtonStyle(
                        style: .withTextPadding(ofSize: 50)
                    )
                )
            }
            .overlay {
                if viewModel.isLoadingRandom {
                    LoadingView()
                        .transition(.opacity)
                }
            }
            .onChange(of: viewModel.randomId) { _, newValue in
                navigator.push(.details(id: newValue))
            }
        }
    }
}

#Preview {
    HomeView()
}
