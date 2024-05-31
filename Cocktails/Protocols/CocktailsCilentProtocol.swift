//
//  CocktailsCilentProtocol.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Combine
import Foundation

protocol CocktailsClientProtocol {

    func getCocktail(id: String) -> AnyPublisher<CocktailsListResponse, Error>
    func getRandomCocktail() -> AnyPublisher<CocktailsListResponse, Error>

    func getCocktailList(searchText: String) -> AnyPublisher<CocktailsListResponse, Error>
    func getFilteredCocktailList(_ params: [String: String]) -> AnyPublisher<CocktailsListResponse, Error>

    func getGlassListFilter() -> AnyPublisher<CocktailGlassFilterListResponse, Error>
    func getCategoryListFilter() -> AnyPublisher<CocktailCategoryFilterListResponse, Error>
    func getAlcoholicListFilter() -> AnyPublisher<CocktailAlcoholicFilterListResponse, Error>
}
