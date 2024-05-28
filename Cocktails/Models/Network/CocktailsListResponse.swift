//
//  CocktailsListResponse.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
//

import Foundation

struct CocktailsListResponse: Codable {
    let drinks: [CocktailResponse]?
}
