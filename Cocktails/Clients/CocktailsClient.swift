//
//  CocktailsClient.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
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

class CocktailsClient: CocktailsClientProtocol {

    private var network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    // MARK: - Details

    func getRandomCocktail() -> AnyPublisher<CocktailsListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .randomCocktail,
                method: .get
            )
        )
    }

    func getCocktail(id: String) -> AnyPublisher<CocktailsListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .cocktailDetails,
                method: .get,
                options: [.queryParams(["i": id])]
            )
        )
    }

    // MARK:  - List

    func getCocktailList(searchText: String = "") -> AnyPublisher<CocktailsListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .cocktailList,
                method: .get,
                options: [.queryParams(["s": searchText])]
            )
        )
    }

    func getFilteredCocktailList(_ params: [String: String]) -> AnyPublisher<CocktailsListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .filter,
                method: .get,
                options: [.queryParams(params)]
            )
        )
    }

    // MARK:  - Filters

    func getGlassListFilter() -> AnyPublisher<CocktailGlassFilterListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .filterList,
                method: .get,
                options: [.queryParams(["g": "list"])]
            )
        )
    }

    func getCategoryListFilter() -> AnyPublisher<CocktailCategoryFilterListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .filterList,
                method: .get,
                options: [.queryParams(["c": "list"])]
            )
        )
    }

    func getAlcoholicListFilter() -> AnyPublisher<CocktailAlcoholicFilterListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .filterList,
                method: .get,
                options: [.queryParams(["a": "list"])]
            )
        )
    }



}
