//
//  CocktailDetails.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 30.05.2024..
//

import Foundation

enum CocktailDetailsViewType: Identifiable, Equatable {

    var id: String {
        return UUID().uuidString
    }

    case name(String)
    case image(String)
    case filterCategories([CocktailDetailsFilter])
    case ingredients([String])
    case directions(String)
    case updatedAt(String)

    static func == (lhs: CocktailDetailsViewType, rhs: CocktailDetailsViewType) -> Bool {
        lhs.id == rhs.id
    }
}

struct CocktailDetails {

    let id: String
    let name: String
    let imageUrl: String
    let category: String
    let glassType: String
    let alcoholType: String
    let ingredients: [String]
    let directions: String
    let dateModified: String

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

        let measurements = [
            cocktail.strMeasure1,
            cocktail.strMeasure2,
            cocktail.strMeasure3,
            cocktail.strMeasure4,
            cocktail.strMeasure5,
            cocktail.strMeasure6,
            cocktail.strMeasure7,
            cocktail.strMeasure8,
            cocktail.strMeasure9,
            cocktail.strMeasure10,
            cocktail.strMeasure11,
            cocktail.strMeasure12,
            cocktail.strMeasure13,
            cocktail.strMeasure14,
            cocktail.strMeasure15
        ].compactMap { $0 }

        let ingredientsWithMeasurements = zip(ingredients, measurements).map { ingredient, measurement in
            return "\(measurement) \(ingredient)"
        }

        self.id = cocktail.idDrink ?? ""
        self.name = cocktail.strDrink ?? ""
        self.imageUrl = cocktail.strDrinkThumb ?? ""
        self.category = cocktail.strCategory ?? ""
        self.glassType = cocktail.strGlass ?? ""
        self.alcoholType = cocktail.strAlcoholic ?? ""
        self.ingredients = ingredientsWithMeasurements
        self.directions = cocktail.strInstructions ?? ""
        self.dateModified = cocktail.dateModified ?? ""

    }

}

extension CocktailDetails {
    
    func createSections() -> [CocktailDetailsViewType] {
        var views: [CocktailDetailsViewType] = []

        views.append(.name(name))

        if !imageUrl.isEmpty {
            views.append(.image(imageUrl))
        }

        var filters = [CocktailDetailsFilter]()

        if !category.isEmpty {
            filters.append(CocktailDetailsFilter( filterCategory: .category, value: category))
        }

        if !glassType.isEmpty {
            filters.append(CocktailDetailsFilter(filterCategory: .glass, value: glassType))
        }

        if !alcoholType.isEmpty {
            filters.append(CocktailDetailsFilter(filterCategory: .alcoholic, value: alcoholType))
        }

        views.append(.filterCategories(filters))

        if !ingredients.isEmpty {
            views.append(.ingredients(ingredients))
        }

        if !directions.isEmpty {
            views.append(.directions(directions))
        }

        if !dateModified.isEmpty {
            let updatedAt = DateUtils.categorizeDate(dateModified)
            views.append(.updatedAt(updatedAt))
        }

        return views

    }

}
