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


        private var searchSubject = PassthroughSubject<String, Never>()

        var searchText: String = "" {
            didSet {
                searchSubject.send(searchText)
            }
        }
        var randomId: String = ""
        var isLoadingRandom: Bool = false

        init() {
            fetchCocktails()
            observeSearchText()
        }

        private func fetchCocktails() {
            useCase.getCocktailList(searchText: "")
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

        private func observeSearchText() {
            searchSubject
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .flatMap { [weak self] text -> AnyPublisher<[Cocktail], Error> in
                    guard let self = self else {
                        return Empty(completeImmediately: true).eraseToAnyPublisher()
                    }
                    return self.useCase.getCocktailList(searchText: text)
                }
                .sink(receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished fetching list")
                    case .failure(let failure):
                        print("Failed with error: \(failure)")
                    }
                }, receiveValue: { [weak self] list in
                    self?.cocktails = list
                })
                .store(in: &cancellables)
        }

        func fetchRandomCocktail() {
            if isLoadingRandom { return }

            withAnimation {
                isLoadingRandom = true
            }

            useCase.getRandomCocktail()
                .sink(receiveCompletion: { [weak self] status in
                    switch status {
                    case .finished:
                        print("Finished fetching list")
                    case .failure(let failure):
                        print("Failed with error. \(failure)")
                    }
                    withAnimation(Animation.snappy.delay(0.5)) {
                        self?.isLoadingRandom = false
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    randomId = response
                })
                .store(in: &cancellables)
        }
    }


}
