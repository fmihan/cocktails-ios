//
//  MainCoordinator.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import SwiftUI
import FlowStacks

enum AppScreen: Hashable {
    case filters
    case details(id: String)
    case filterResults(for: [FilterCategory: CocktailFilter])
}

struct AppCoordinator: View {

    @State var routes: [Route<AppScreen>] = []

    var body: some View {
        FlowStack($routes, withNavigation: true) {
            HomeView()
                .flowDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .filters:
                       FiltersView()
                    case .details(let id):
                        DetailsView(cocktailId: id)
                    case .filterResults(for: let filters):
                        FilterResultsView(filters: filters)
                    }
                }

        }
    }
}
