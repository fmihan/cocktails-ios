//
//  FiltersViewModelTest.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import XCTest
import Combine
import Factory

@testable import Cocktails

final class FiltersViewModelTests: XCTestCase {

    var viewModel: FiltersView.ViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Container.shared.reset()
        viewModel = FiltersView.ViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoadFilters() {
        let expectation = XCTestExpectation(description: "Load filters")

        viewModel.$sectionsNonTracked
            .dropFirst()
            .sink { sections in
                XCTAssertEqual(sections.count, 3)
                XCTAssertEqual(sections.first?.type, .category)
                XCTAssertEqual(sections.first?.items.first?.name, "Ordinary Drink")
                expectation.fulfill()
            }
            .store(in: &cancellables)


        viewModel.loadFilters()
        wait(for: [expectation], timeout: 5.0)
    }

    func testSelectFilter() {
        let filter = Cocktails.CocktailFilter(name: "Glass 1")
        viewModel.selectFilter(filter, for: .glass)

        XCTAssertTrue(viewModel.isSelected(filter, for: .glass))
        XCTAssertEqual(viewModel.selectedFilters[.glass], filter)
    }

    func testIsSelected() {
        let filter = Cocktails.CocktailFilter(name: "Glass1")
        let otherFilter = Cocktails.CocktailFilter(name: "Glass2")

        viewModel.selectFilter(filter, for: .glass)

        XCTAssertTrue(viewModel.isSelected(filter, for: .glass))
        XCTAssertFalse(viewModel.isSelected(otherFilter, for: .glass))
    }
}

private extension Container {

    var cocktailsCilent: Factory<CocktailsClientProtocol> {
        Factory(self) { MockCocktailsClient() }.scope(.singleton)
    }

    var cocktailUseCase: Factory<CocktailUseCaseProtocol> {
        Factory(self) { CocktailUseCase(cocktailClient: self.cocktailsCilent.resolve() ) }.scope(.singleton)
    }

}
