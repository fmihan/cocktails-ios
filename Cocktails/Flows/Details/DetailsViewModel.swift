//
//  DetailsViewModel.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import Combine
import Factory
import Foundation

extension DetailsView {

    @Observable
    class ViewModel: ObservableObject {
        
        @ObservationIgnored
        @Injected(\.cocktailUseCase) var useCase

        var cocktailName: String = ""
        var detailsSections: [CocktailDetailsViewType] = []

        private var cancellables = Set<AnyCancellable>()

        func fetchDetails(for id: String) {
            useCase.getCocktailDetails(for: id)
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished fetching details")
                    case .failure(let error):
                        print("Error occured while fetching details. Error: \(error)")
                    }
                }, receiveValue: { [weak self] value in
                    guard let self else { return }
                    detailsSections = value
                    findName()
                })
                .store(in: &cancellables)
        }

        private func findName() {
            detailsSections.forEach { section in
                guard case let .name(name) = section else { return }
                self.cocktailName = name
            }
        }

    }
}
