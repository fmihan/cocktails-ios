//
//  MockCocktailsClient.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Combine
import Foundation

class MockCocktailsClient: CocktailsClientProtocol {

    enum MockError: Error {
        case decodingError
    }

    private let decoder = JSONDecoder()

    func getCocktail(id: String) -> AnyPublisher<CocktailsListResponse, Error> {
        guard let data = MockStrings.mockCocktail.data(using: .utf8),
              let response = try? decoder.decode(CocktailsListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getRandomCocktail() -> AnyPublisher<CocktailsListResponse, Error> {
        guard let data = MockStrings.mockCocktail.data(using: .utf8),
              let response = try? decoder.decode(CocktailsListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getCocktailList(searchText: String) -> AnyPublisher<CocktailsListResponse, Error> {
        guard let data = MockStrings.mockCocktail.data(using: .utf8),
              let response = try? decoder.decode(CocktailsListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getFilteredCocktailList(_ params: [String : String]) -> AnyPublisher<CocktailsListResponse, Error> {
        guard let data = MockStrings.mockCocktail.data(using: .utf8),
              let response = try? decoder.decode(CocktailsListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getGlassListFilter() -> AnyPublisher<CocktailGlassFilterListResponse, Error> {
        guard let data = MockStrings.mockGlasses.data(using: .utf8),
              let response = try? decoder.decode(CocktailGlassFilterListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getCategoryListFilter() -> AnyPublisher<CocktailCategoryFilterListResponse, Error> {
        guard let data = MockStrings.mockCategory.data(using: .utf8),
              let response = try? decoder.decode(CocktailCategoryFilterListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getAlcoholicListFilter() -> AnyPublisher<CocktailAlcoholicFilterListResponse, Error> {
        guard let data = MockStrings.mockAlcoholic.data(using: .utf8),
              let response = try? decoder.decode(CocktailAlcoholicFilterListResponse.self, from: data) else {
            return Fail(error: MockError.decodingError).eraseToAnyPublisher()
        }
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    

}
