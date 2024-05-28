//
//  HomeViewModel.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 26.05.2024..
//

import SwiftUI
import Combine
import FlowStacks

extension HomeView {
    
    @Observable
    class ViewModel {

        private var cancellables = Set<AnyCancellable>()
        let network = NetworkingService()

        init() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.tryNesto()
            }
        }

        func tryNesto() {
            let cocktailClient = CocktailsClient(network: network)
            cocktailClient.getCocktailList()
                .sink(receiveCompletion: {
                    print($0)
                }, receiveValue: {
                    print($0)
                })
                .store(in: &cancellables)

        }
    }


}
