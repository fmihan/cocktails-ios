//
//  EndPointTests.swift
//  CocktailsTests
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import XCTest

final class EndPointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLRequestWithQueryParams() throws {

        let endpoint = EndPoint(path: .cocktailList, method: .get, options: [.queryParams(["name": "margarita"])])
        let urlRequest = endpoint.urlRequest

        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/search.php?name=margarita")
    }

    func testURLRequestWithBody() throws {
        let bodyDict: [String: String] = ["key": "value"]
        let endpoint = EndPoint(path: .filter, method: .post, options: [.body(bodyDict)])

        let urlRequest = endpoint.urlRequest
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
        XCTAssertEqual(urlRequest?.httpBody, try? JSONEncoder().encode(bodyDict))
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/filter.php")
    }

    func testURLRequestWithHeaders() throws {
        let headers: [String: String] = ["Authorization": "Bearer token"]
        let endpoint = EndPoint(path: .randomCocktail, method: .get, options: [.headers(headers)])

        let urlRequest = endpoint.urlRequest

        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields, headers)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://www.thecocktaildb.com/api/json/v1/1/random.php")
    }
}
