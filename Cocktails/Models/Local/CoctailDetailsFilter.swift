//
//  CoctailDetailsFilter.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Foundation

struct CocktailDetailsFilter: Identifiable {
    var id = UUID().uuidString

    let filterCategory: FilterCategory
    let value: String
}
