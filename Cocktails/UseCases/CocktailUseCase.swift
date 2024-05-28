//
//  CocktailUseCase.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import Combine
import Foundation

protocol CocktailUseCaseProtocol {
    func getCocktailList() -> AnyPublisher<[Cocktail], Error>
}

class CocktailUseCase: CocktailUseCaseProtocol {

    var cocktailClient: CocktailsClientProtocol

    init(cocktailClient: CocktailsClientProtocol) {
        self.cocktailClient = cocktailClient
    }

    func getCocktailList() -> AnyPublisher<[Cocktail], Error> {
        cocktailClient.getCocktailList()
            .map { response in
                guard let list = response.drinks else { return [] }
                return list.map { cocktail in
                    
                    let ingredients = [
                        cocktail.strIngredient1,
                        cocktail.strIngredient2,
                        cocktail.strIngredient3,
                        cocktail.strIngredient4,
                        cocktail.strIngredient5,
                        cocktail.strIngredient6,
                        cocktail.strIngredient7,
                        cocktail.strIngredient8,
                        cocktail.strIngredient9,
                        cocktail.strIngredient10,
                        cocktail.strIngredient11,
                        cocktail.strIngredient12,
                        cocktail.strIngredient13,
                        cocktail.strIngredient14,
                        cocktail.strIngredient15
                    ].compactMap { $0 }

                    return Cocktail(
                        id: cocktail.idDrink ?? "",
                        imageUrl: cocktail.strDrinkThumb ?? "",
                        cocktailName: cocktail.strDrink ?? "",
                        cocktailIngredients: ingredients
                    )
                }
            }
            .eraseToAnyPublisher()
    }

}
