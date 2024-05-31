//
//  NetworkTests.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import XCTest
import Combine

final class NetworkServiceTests: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testSuccessfulRequest() {
        let responseData = Data(MockStrings.mockCocktail.utf8)
        let response = HTTPURLResponse(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Moj")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        mockNetworkService.data = responseData
        mockNetworkService.response = response

        let publisher: AnyPublisher<CocktailsListResponse, Error> = mockNetworkService.sendRequest(
            endpoint: .init(
                path: .cocktailList,
                method: .get,
                options: [.queryParams(["s": "Moj"])]
            )
        )

        let expectation = XCTestExpectation(description: "Successful request")

        publisher.sink(receiveCompletion: { completion in
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
            XCTAssertEqual(response?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Moj")
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func testFailedRequest() {
        // Set up mock error for failed request
        let mockError = NSError(domain: "TestError", code: 123, userInfo: nil)
        mockNetworkService.error = mockError

        // Call the method to be tested
        let publisher: AnyPublisher<String, Error> = mockNetworkService.sendRequest(
            endpoint: .init(
                path: .cocktailList,
                method: .get
            )
        )

        // Use XCTest expectations to assert the result
        let expectation = XCTestExpectation(description: "Failed request")

        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "TestError")
                XCTAssertEqual(error.code, 123)
            case .finished:
                XCTFail("Expected failure, but received completion")
            }
            expectation.fulfill()
        }, receiveValue: { _ in
            XCTFail("Expected failure, but received value")
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    // Add more test cases as needed for different scenarios
}
