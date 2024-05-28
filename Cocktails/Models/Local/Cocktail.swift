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
}
