//
//  MainCoordinator.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import SwiftUI
import FlowStacks

struct MainCoordinator: View {

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
