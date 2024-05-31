//
//  CocktailFilter.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 29.05.2024..
//

import Foundation

struct CocktailFilter: Identifiable, Equatable, Hashable {
    var id = UUID().uuidString
    let name: String
}
