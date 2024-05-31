//
//  FilterResultsView.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import SwiftUI
import FlowStacks

struct FilterResultsView: View {

    @EnvironmentObject var navigator: FlowNavigator<AppScreen>
    @StateObject var viewModel = ViewModel()

    private let filters: [FilterCategory: CocktailFilter]

    init(filters: [FilterCategory: CocktailFilter]) {
        self.filters = filters
    }

    var body: some View {
        List(viewModel.cocktails) { cocktail in
            CocktailListView(
                cocktail: cocktail,
                onTap: { navigator.push(.details(id: cocktail.id)) }
            )
            .listRowBackground(Color.blue100)
        }
        .listStyle(.plain)
        .listRowInsets(.none)
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .background(.blue100)
        .navigationTitle("filterResults.title")
        .onAppear {
            viewModel.getCocktails(for: filters)
        }
    }
}

#Preview {
    FilterResultsView(filters: [.alcoholic: CocktailFilter(name: "Alcoholic")])
}
