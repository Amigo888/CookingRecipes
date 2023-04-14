//
//  APICaller.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 14.04.2023.
//

import Foundation

class URLBuilder {
    static func buildURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem], value: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        components.queryItems?[0].value = value
        return components.url
    }
}

enum CustomError: Error {
    case invalidURL
    case invalidData
}

protocol APICallerProtocol {
    func makeRequest<T: Decodable>(with url: URL?, expecting: T.Type ,completion: @escaping(Result<T, Error>) -> Void)
}

class APICaller: APICallerProtocol {
    
    func makeRequest<T: Decodable>(with url: URL?, expecting: T.Type ,completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = url else { return completion(.failure(CustomError.invalidURL)) }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else  {  return completion(.failure(CustomError.invalidData)) }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


