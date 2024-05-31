//
//  CocktailClinetTests.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import XCTest
import Combine

final class CocktailClinetTests: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var cocktailClient: CocktailsClientProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        cocktailClient = CocktailsClient(network: mockNetworkService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cocktailClient = nil
        cancellables = nil
        super.tearDown()
    }


    func testGetRandomCocktail() {
        let responseData = Data(MockStrings.mockCocktail.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/random.php"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getRandomCocktail()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks?.count, 1)
                XCTAssertEqual(value.drinks?.first?.idDrink, "11000")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/random.php")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetCocktail() {
        let id = "11000"
        let responseData = Data(MockStrings.mockCocktail.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getCocktail(id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks?.count, 1)
                XCTAssertEqual(value.drinks?.first?.idDrink, id)
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetCocktailList() {
        let searchText = "Mojito"
        let responseData = Data(MockStrings.mockCocktail.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getCocktailList(searchText: searchText)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks?.count, 1)
                XCTAssertEqual(value.drinks?.first?.idDrink, "11000")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetFilteredCocktailList() {
        let params: [String: String] = ["c": "list"]
        let responseData = Data(MockStrings.mockCocktail.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=list"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getFilteredCocktailList(params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks?.count, 1)
                XCTAssertEqual(value.drinks?.first?.idDrink, "11000")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=list")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetGlassListFilter() {
        let responseData = Data(MockStrings.mockGlasses.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getGlassListFilter()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks.count, 8)
                XCTAssertEqual(value.drinks.first?.strGlass, "Highball glass")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetCategoryListFilter() {
        let responseData = Data(MockStrings.mockCategory.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getCategoryListFilter()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks.count, 11)
                XCTAssertEqual(value.drinks.first?.strCategory, "Ordinary Drink")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }

    func testGetAlcoholicListFilter() {
        let responseData = Data(MockStrings.mockAlcoholic.utf8)
        let response = HTTPURLResponse(
            url: URL(
                string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let expectation = XCTestExpectation(description: "Successful request")

        cocktailClient.getAlcoholicListFilter()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertEqual(value.drinks.count, 3)
                XCTAssertEqual(value.drinks.first?.strAlcoholic, "Alcoholic")
                XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list")
            }).store(in: &cancellables)

            wait(for: [expectation], timeout: 5)
    }





    
}
