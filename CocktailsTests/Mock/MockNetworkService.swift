//
//  MockNetworkService.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Combine
import Foundation

class MockNetworkService: NetworkProtocol {

    var data: Data?
    var error: Error?
    var response: URLResponse?

    func sendRequest<T>(endpoint: EndPoint) -> AnyPublisher<T, Error> where T : Codable {

        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let data = data, let response = response else {
            fatalError("MockNetworkService is not properly configured. Please set data and response.")
        }

        return Just(data)
            .tryMap { data -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }
            .eraseToAnyPublisher()

    }
}
