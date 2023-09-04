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


final class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    
    let apiCaller: APICallerProtocol
    
    init(apiCaller: APICaller) {
        self.apiCaller = apiCaller
    }
    
    func fetchReceipt(type: String, completion: @escaping (Result<[Receipt], Error>) -> Void) {
        let url = URLBuilder.buildURL(
            baseURL: APIConstants.URLDetail.baseURL,
            pathComponents: APIConstants.URLDetail.pathComponentsList,
            queryParameters: ["type" : "\(type)",
                              "number" : "20",
                              "apiKey" : APIConstants.API_KEY]
        )
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
