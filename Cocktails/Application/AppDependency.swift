//
//  AppDependency.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import Factory
import Foundation

extension Container {

    var cocktailsCilent: Factory<CocktailsClientProtocol> {
        Factory(self) { CocktailsClient(network: NetworkingService()) }.scope(.singleton)
    }

    var cocktailUseCase: Factory<CocktailUseCaseProtocol> {
        Factory(self) { CocktailUseCase(cocktailClient: self.cocktailsCilent.resolve() ) }.scope(.singleton)
    }
    
}
