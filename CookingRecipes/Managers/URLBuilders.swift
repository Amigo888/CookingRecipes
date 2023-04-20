//
//  URLBuilders.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 18.04.2023.
//

import Foundation

class URLBuilder {
    static func buildURL(scheme: String, host: String, path: String, queryItems: [String: String]?, value: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        if let queryItems = queryItems {
                components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
            }
        
        return components.url
    }
}

class URLBuilderDetailed {
    static func buildURL(scheme: String, host: String, path: String, queryItems: [String: String]?, id: Int) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(path)/\(id)/information"
        if let queryItems = queryItems {
                components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
            }
        
        return components.url
    }
}

class URLBuilderPhoto {
    static func buildURL(scheme: String, host: String, path: String, productName: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(path)\(productName)"
        return components.url
    }
}
