//
//  FilterViewModel.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 29.05.2024..
//

import SwiftUI
import Factory
import Combine

extension FiltersView {

    @Observable
    class ViewModel: ObservableObject {

        @ObservationIgnored
        @Injected(\.cocktailUseCase) var useCase

        @ObservationIgnored
        @Published var sectionsNonTracked: [FilterSection] = []

        private var cancellables = Set<AnyCancellable>()

        var sections: [FilterSection] = [] { didSet { sectionsNonTracked = sections } }
        var selectedFilters: [FilterCategory: CocktailFilter] = [:]

        init() {
            loadFilters()
        }

        func loadFilters() {
            useCase.getFilters()
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished loading filters")
                    case .failure(let error):
                        print("Error occured while fetching filters. Error: \(error)")
                    }
                }, receiveValue: { [weak self] value in
                    guard let self else { return }
                    self.sections = value
                })
                .store(in: &cancellables)
        }

        func selectFilter(_ filter: CocktailFilter, for category: FilterCategory) {
            selectedFilters[category] = filter
        }

        func isSelected(_ filter: CocktailFilter, for category: FilterCategory) -> Bool {
            return selectedFilters[category] == filter
        }
    }

}

