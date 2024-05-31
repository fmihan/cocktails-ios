//
//  CocktailUseCase.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 28.05.2024..
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

class CocktailUseCase: CocktailUseCaseProtocol {

    var cocktailClient: CocktailsClientProtocol

    init(cocktailClient: CocktailsClientProtocol) {
        self.cocktailClient = cocktailClient
    }

    // MARK: - Details

    func getRandomCocktail() -> AnyPublisher<String, Error> {
        cocktailClient.getRandomCocktail()
            .tryMap { response -> CocktailResponse in
                guard let first = response.drinks?.first else {
                    throw URLError(.badServerResponse)
                }
                return first
            }
            .map { cocktailResponse in
                return cocktailResponse.idDrink ?? ""
            }
            .eraseToAnyPublisher()
    }

    func getCocktailDetails(for id: String) -> AnyPublisher<[CocktailDetailsViewType], Error> {
        cocktailClient.getCocktail(id: id)
            .tryMap { response -> CocktailResponse in
                guard let first = response.drinks?.first else {
                    throw URLError(.badServerResponse)
                }
                return first
            }
            .map { cocktailResponse in
                return CocktailDetails(cocktailResponse: cocktailResponse).createSections()
            }
            .eraseToAnyPublisher()
    }


    // MARK: - Lists

    func getCocktailList(searchText: String = "") -> AnyPublisher<[Cocktail], Error> {
        cocktailClient.getCocktailList(searchText: searchText)
            .map { response in
                guard let list = response.drinks else { return [] }
                return list.map { Cocktail(cocktailResponse: $0) }
            }
            .eraseToAnyPublisher()
    }

    func filterCocktails(_ filter: [FilterCategory: CocktailFilter]) -> AnyPublisher<[Cocktail], Error> {
        let params = Dictionary(uniqueKeysWithValues: filter.map { key, value in (
            key.queryKey, value.name)
        })

        return cocktailClient.getFilteredCocktailList(params)
            .map { response in
                guard let list = response.drinks else { return [] }
                return list.map { Cocktail(cocktailResponse: $0) }
            }
            .eraseToAnyPublisher()
    }


    // MARK: - Filters

    func getFilters() -> AnyPublisher<[FilterSection], Error> {
        Publishers.Zip3(getGlassFilters(), getAlcoholFilters(), getCategoryFilters())
            .map { glassFilters, alcoholFilters, categoryFilters in
                return [
                    FilterSection(type: .category, items: categoryFilters),
                    FilterSection(type: .glass, items: glassFilters),
                    FilterSection(type: .alcoholic, items: alcoholFilters)
                ]
            }
            .catch { error -> AnyPublisher<[FilterSection], Error> in
                print("Error encountered: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func getGlassFilters() -> AnyPublisher<[CocktailFilter], Error> {
        cocktailClient.getGlassListFilter()
            .map { response in
                response.drinks.map { CocktailFilter(name: $0.strGlass) }
            }
            .eraseToAnyPublisher()
    }

    func getAlcoholFilters() -> AnyPublisher<[CocktailFilter], Error> {
        cocktailClient.getAlcoholicListFilter()
            .map { response in
                response.drinks.map { CocktailFilter(name: $0.strAlcoholic) }
            }
            .eraseToAnyPublisher()
    }


    func getCategoryFilters() -> AnyPublisher<[CocktailFilter], Error> {
        cocktailClient.getCategoryListFilter()
            .map { response in
                response.drinks.map { CocktailFilter(name: $0.strCategory) }
            }
            .eraseToAnyPublisher()
    }
}
