//
//  CocktailsClient.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import Combine
import Foundation

protocol CocktailsClientProtocol {
    func getCocktailList() -> AnyPublisher<CocktailsListResponse, Error>
}

class CocktailsClient: CocktailsClientProtocol {

    var network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getCocktailList() -> AnyPublisher<CocktailsListResponse, Error> {
        network.sendRequest(
            endpoint: .init(
                path: .cocktailList,
                method: .get,
                options: [.queryParams(["s": ""])]
            )
        )
    }

}
