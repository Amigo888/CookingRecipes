//
//  URLBuilders.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 18.04.2023.
//

import Foundation

class URLBuilder {
    static func buildURL(baseURL: URL, pathComponents: [String], queryParameters: [String: String]?) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let path = pathComponents.joined(separator: "/")
        components?.path = "/" + path
        if let queryItems = queryParameters {
            components?.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
            }
        return components?.url
    }
}


