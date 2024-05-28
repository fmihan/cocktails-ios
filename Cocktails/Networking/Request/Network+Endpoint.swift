//
//  Network+Endpoint.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 27.05.2024..
//

import Foundation

struct EndPoint {

    enum Path: String {
        case filter = "list.php"
        case cocktailList = "search.php"
        case cocktailDetails = "details.php"
    }

    enum Options: Equatable {
        case body([String: String])
        case headers([String: String])
        case queryParams([String: String])
    }

    private let host: String
    private let scheme: String
    private let path: Path
    private let method: HTTPMethod
    private let options: [Options]

    init(
        _ scheme: String = "https",
        _ host: String = "www.thecocktaildb.com",
        path: Path,
        method: HTTPMethod,
        options: [Options] = []
    ) {
        self.scheme = scheme
        self.host = host
        self.method = method
        self.path = path
        self.options = options
    }

    public var urlRequest: URLRequest? {

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/api/json/v1/1/"

        if let queryParamsOption = options.first(where: {
            if case .queryParams = $0 { return true }
            return false
        }) {
            if case .queryParams(let dictionary) = queryParamsOption {
                var queryItems = [URLQueryItem]()
                for (key, value) in dictionary {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                if !queryItems.isEmpty {
                    urlComponents.queryItems = queryItems
                }
            }
        }

        guard let url = urlComponents.url else {
            return nil
        }

        let newUrl = url.appendingPathComponent(path.rawValue)

        let encoder = JSONEncoder()
        var request = URLRequest(url: newUrl)

        request.httpMethod = method.rawValue

        for option in options {
            switch option {
            case .body(let dictionary):
                request.httpBody = try? encoder.encode(dictionary)
            case .headers(let dictionary):
                request.allHTTPHeaderFields = dictionary
            default:
                break
            }
        }

        return request
    }

}
