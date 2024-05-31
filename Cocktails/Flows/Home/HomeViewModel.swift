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
    class ViewModel: ObservableObject {

        @ObservationIgnored
        @Injected(\.cocktailUseCase) private var useCase

        private(set) var cocktails: [Cocktail] = []
        private var cancellables = Set<AnyCancellable>()

        var randomId: String = ""
        var isLoadingRandom: Bool = false

        init() {
            fetchCocktails()
        }

        private func fetchCocktails() {
            useCase.getCocktailList()
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished fetching list")
                    case .failure(let failure):
                        print("Failed with error. \(failure)")
                    }
                }, receiveValue: { [weak self] list in
                    guard let self else { return }
                    cocktails = list
                })
                .store(in: &cancellables)
        }

        func fetchRandomCocktail() {
            if isLoadingRandom { return }

            withAnimation {
                isLoadingRandom = true
            }

            useCase.getRandomCocktail()
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished fetching list")
                    case .failure(let failure):
                        print("Failed with error. \(failure)")
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    withAnimation(Animation.snappy.delay(0.5)) {
                        self.isLoadingRandom = false
                    }
                    randomId = response
                })
                .store(in: &cancellables)
        }
    }


}
