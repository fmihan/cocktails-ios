//
//  NetworkProtocol.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import Foundation
import Combine

protocol NetworkProtocol {
    func sendRequest<T: Codable>(endpoint: EndPoint) -> AnyPublisher<T, Error>
}
