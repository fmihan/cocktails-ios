//
//  AppScreen.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Foundation

enum AppScreen: Hashable {
    case filters
    case details(id: String)
    case filterResults(for: [FilterCategory: CocktailFilter])
}
