//
//  CocktailUseCaseTest.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import XCTest
import Combine

final class CocktailUseCaseTest: XCTestCase {

    var useCase: CocktailUseCaseProtocol!
    var cocktailClient: CocktailsClientProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cocktailClient = MockCocktailsClient()
        useCase = CocktailUseCase(cocktailClient: cocktailClient)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cocktailClient = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetRandomCocktail() {

        let expectation = XCTestExpectation(description: "Get random cocktail")

        useCase.getRandomCocktail()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { idDrink in
                XCTAssertEqual(idDrink, "11000")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetCocktailDetails() {
        let expectation = XCTestExpectation(description: "Get cocktail details")

        useCase.getCocktailDetails(for: "11000")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { cocktailDetails in
                XCTAssertEqual(cocktailDetails.count, 6)

                for detail in cocktailDetails {
                    switch detail {
                    case .name(let string):
                        XCTAssertEqual(string, "Mojito")
                    case .image(let string):
                        XCTAssertEqual(string, "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg")
                    case .directions(let string):
                        XCTAssertEqual(string, "Muddle mint leaves with sugar and lime juice. Add a splash of soda water and fill the glass with cracked ice. Pour the rum and top with soda water. Garnish and serve with straw.")
                    case .updatedAt(let string):
                        XCTAssertEqual(string, DateUtils.categorizeDate("2016-11-04 09:17:09"))
                    default:
                        break
                    }
                }

            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetCocktailList() {
        let expectation = XCTestExpectation(description: "Get cocktail list")

        // Act
        useCase.getCocktailList(searchText: "Mojito")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { cocktails in
                // Assert
                XCTAssertEqual(cocktails.count, 1)
                XCTAssertEqual(cocktails.first?.id, "11000")
                XCTAssertEqual(cocktails.first?.cocktailName, "Mojito")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testFilterCocktails() {
        let filter: [FilterCategory: CocktailFilter] = [
            .glass: CocktailFilter(name: "Highball glass"),
            .alcoholic: CocktailFilter(name: "Alcoholic")
        ]

        let expectation = XCTestExpectation(description: "Filter cocktails")

        // Act
        useCase.filterCocktails(filter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { cocktails in
                // Assert
                XCTAssertEqual(cocktails.count, 1)
                XCTAssertEqual(cocktails.first?.id, "11000")
                XCTAssertEqual(cocktails.first?.cocktailName, "Mojito")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetFilters() {

        let expectation = XCTestExpectation(description: "Get filters")

        // Act
        useCase.getFilters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { filterSections in
                // Assert
                XCTAssertEqual(filterSections.count, 3)

                let categorySection = filterSections.first(where: { $0.type == .category })
                XCTAssertEqual(categorySection?.items.count, 11)
                XCTAssertEqual(categorySection?.items.first?.name, "Ordinary Drink")

                let glassSection = filterSections.first(where: { $0.type == .glass })
                XCTAssertEqual(glassSection?.items.count, 8)
                XCTAssertEqual(glassSection?.items.first?.name, "Highball glass")

                let alcoholSection = filterSections.first(where: { $0.type == .alcoholic })
                XCTAssertEqual(alcoholSection?.items.count, 3)
                XCTAssertEqual(alcoholSection?.items.first?.name, "Alcoholic")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetGlassFilters() {
        let expectation = XCTestExpectation(description: "Get glass filters")

        useCase.getGlassFilters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { filters in
                // Assert
                XCTAssertEqual(filters.count, 8)
                XCTAssertEqual(filters.first?.name, "Highball glass")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetAlcoholFilters() {
        let expectation = XCTestExpectation(description: "Get alcohol filters")

        useCase.getAlcoholFilters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { filters in
                XCTAssertEqual(filters.count, 3)
                XCTAssertEqual(filters.first?.name, "Alcoholic")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetCategoryFilters() {
        let expectation = XCTestExpectation(description: "Get category filters")

        useCase.getCategoryFilters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { filters in
                XCTAssertEqual(filters.count, 11)
                XCTAssertEqual(filters.first?.name, "Ordinary Drink")
            }).store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }







}

