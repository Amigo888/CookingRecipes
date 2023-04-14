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
        let url = URLBuilder.buildURL(scheme: APIConstants.scheme, host: APIConstants.host, path: APIConstants.path, queryItems: APIConstants.queryItems, value: type)
        apiCaller.makeRequest(with: url, expecting: ReceiptListResponse.self, completion: { result in
            switch result {
            case .success(let receipt):
                completion(.success(receipt.results))
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
}
