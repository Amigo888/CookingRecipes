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
        let url = URLBuilderDetailed.buildURL(scheme: APIConstants.URLPaths.scheme.rawValue,
                                              host: APIConstants.URLPaths.host.rawValue,
                                              path: APIConstants.URLPaths.path.rawValue,
                                              queryItems: ["includeNutrition" : "\(false)",
                                                           "apiKey" : APIConstants.API_KEY],
                                              id: id)
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
