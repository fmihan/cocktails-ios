//
//  HomeViewModel.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI
import Combine
import Factory

extension HomeView {
    
    @Observable
    class ViewModel {

        @ObservationIgnored
        @Injected(\.cocktailUseCase) private var useCase

        var cocktails: [Cocktail] = []

        private var cancellables = Set<AnyCancellable>()

        init() {
            fetchCocktails()
        }

        private func fetchCocktails() {
            useCase.getCocktailList()
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished")
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
