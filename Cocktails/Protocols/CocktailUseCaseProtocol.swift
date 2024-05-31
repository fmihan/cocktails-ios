//
//  CocktailUseCaseProtoco.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Combine
import Foundation

protocol CocktailUseCaseProtocol {

    func getRandomCocktail() -> AnyPublisher<String, Error>
    func getCocktailDetails(for id: String) -> AnyPublisher<[CocktailDetailsViewType], Error>

    func getCocktailList(searchText: String) -> AnyPublisher<[Cocktail], Error>
    func filterCocktails(_ filter: [FilterCategory: CocktailFilter]) -> AnyPublisher<[Cocktail], Error>

    func getFilters() -> AnyPublisher<[FilterSection], Error>
    func getGlassFilters() -> AnyPublisher<[CocktailFilter], Error>
    func getAlcoholFilters() -> AnyPublisher<[CocktailFilter], Error>
    func getCategoryFilters() -> AnyPublisher<[CocktailFilter], Error>
}
