//
//  APICaller.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 14.04.2023.
//

import Foundation



enum APIMethod  {
    
    case fetchPayments
    case fetchApprovals
    
    var params: [String: String] {
        switch self {
        case .fetchPayments:
            return ["apiKey": "dasdasdas"]
        case .fetchApprovals:
            return [:]
        }
    }
    
    var header: [String: String] {
        return ["header": "dsadas"]
    }
}
//let paymentsFetch = APIMethod.fetchPayments
//paymentsFetch.params


class URLBuilder {
    
    //        func build(_ method: APIMethod) -> URL? {
    //            let params = method.params
    //
    //            return URL.applicationDirectory
    //        }
    
    static func buildURL(scheme: String, host: String, path: String, queryParams: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        if let queryParams = queryParams {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }
        return components.url
    }
}


enum CustomError: Error {
    case invalidURL
    case invalidData
}

//generic protocol
protocol APICallerPr {
    func makeRequest<T: Decodable>(with url: URL?, expecting: T.Type ,completion: @escaping(Result<T, Error>) -> Void)
}

class APICaller {
    
    static func makeRequest<T: Decodable>(with url: URL?, expecting: T.Type ,completion: @escaping(Result<T, Error>) -> Void) {
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


