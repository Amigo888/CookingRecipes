//
//  RecipesListWorker.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListDoingSomethingWorkerLogic {
    func fetchReceipt(type: String, completion: @escaping (Result<[Receipt], Error>) -> Void)
}
enum APIError: Error {
    case failedTogetData  //emptylist
    case serverError(Error)
}


class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    
    let apiCaller: APICallerProtocol
    
    init(apiCaller: APICaller) {
        self.apiCaller = apiCaller
    }
    
    func fetchReceipt(type: String, completion: @escaping (Result<[Receipt], Error>) -> Void) {
        let url = URLBuilder.buildURL(scheme: APIConstants.URLPaths.scheme.rawValue,
                                      host: APIConstants.URLPaths.host.rawValue,
                                      path: APIConstants.URLPaths.receipes.rawValue,
                                      queryItems: ["type" : "\(type)",
                                                   "number" : "20",
                                                   "apiKey" : APIConstants.API_KEY],
                                      value: type)
        apiCaller.makeRequest(with: url, expecting: ReceiptListResponse.self, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let receipt):
                    completion(.success(receipt.results))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        })
    }
}
