//
//  FilterResultsViewModel.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import SwiftUI
import Factory
import Combine

extension FilterResultsView {

    @Observable
    class ViewModel: ObservableObject {

        @ObservationIgnored
        @Injected(\.cocktailUseCase) var useCase
        private var cancellables = Set<AnyCancellable>()

        var cocktails: [Cocktail] = []

        func getCocktails(for filters: [FilterCategory: CocktailFilter]) {
            useCase.filterCocktails(filters)
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished filtering cocktails")
                    case .failure(let failure):
                        print("Failed with error. \(failure)")
                    }
                }, receiveValue: { [weak self] list in
                    guard let self else { return }
                    cocktails = list
                })
                .store(in: &cancellables)
        }

    }

}
