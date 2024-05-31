//
//  NetworkingService.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import Combine
import Foundation

class NetworkingService: NetworkProtocol {

    func sendRequest<T>(endpoint: EndPoint) -> AnyPublisher<T, Error> where T : Codable {
        guard let urlRequest = endpoint.urlRequest else {
            precondition(false, "Failed URLRequest")
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    throw APIError.invalidURL
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if error is DecodingError {
                    return APIError.failedToDecode
                } else if let error = error as? APIError {
                    return error
                } else {
                    return APIError.unknownError
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
