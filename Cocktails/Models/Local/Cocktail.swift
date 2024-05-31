//
//  Cocktail.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import Foundation

struct Cocktail: Identifiable {
    var id: String
    var imageUrl: String
    var cocktailName: String
    var cocktailIngredients: [String]

    init(id: String, imageUrl: String, cocktailName: String, cocktailIngredients: [String]) {
        self.id = id
        self.imageUrl = imageUrl
        self.cocktailName = cocktailName
        self.cocktailIngredients = cocktailIngredients
    }

    init(cocktailResponse cocktail: CocktailResponse) {
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

        self.id = cocktail.idDrink ?? ""
        self.imageUrl = cocktail.strDrinkThumb ?? ""
        self.cocktailName = cocktail.strDrink ?? ""
        self.cocktailIngredients = ingredients
    }
}

extension Cocktail {
    var urlForImage: URL? {
        URL(string: imageUrl)
    }
}
