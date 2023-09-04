//
//  RecipesListDetailedWorker.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation

protocol ReceipeListDetaildWorkerLogic {
    func fetchReceiptDetails(id: Int, completion: @escaping (Result<DetailedRecipe, Error>) -> Void)
}

class RecipesListDetailedWorker: ReceipeListDetaildWorkerLogic {
    
    let apiCaller: APICallerProtocol
    
    init(apiCaller: APICaller) {
        self.apiCaller = apiCaller
    }
    
    func fetchReceiptDetails(id: Int, completion: @escaping (Result<DetailedRecipe, Error>) -> Void) {
        let url = URLBuilder.buildURL(baseURL: APIConstants.URLDetail.baseURL,
                                      pathComponents: ["recipes",
                                                       "\(id)",
                                                       "information"],
                                      queryParameters: APIConstants.URLDetail.QueryParametersDetailed)
        apiCaller.makeRequest(with: url, expecting: DetailedRecipe.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detailedInfo):
                    completion(.success(detailedInfo))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    
}
