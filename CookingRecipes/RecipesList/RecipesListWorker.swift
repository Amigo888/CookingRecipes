//
//  RecipesListWorker.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListDoingSomethingWorkerLogic {
    func fetchReceipt(completion: @escaping (Result<[Receipt], Error>) -> Void)
}
enum APIError: Error {
    case failedTogetData  //emptylist
    case serverError(Error)
}

let str = "https://api.spoonacular.com/recipes/complexSearch?type=drinks&number=20&apiKey=a858a579a81c4457b0aaea9ae48f41b0"

class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    
//    let ap: APICallerPr
    func fetchReceipt(completion: @escaping (Result<[Receipt], Error>) -> Void) {
        //let url = URLBuilder.buildURL(scheme: <#T##String#>, host: <#T##String#>, path: <#T##String#>, queryParams: <#T##[String : String]?#>)
        APICaller.makeRequest(with: URL(string: str), expecting: ReceiptListResponse.self) { result in
            switch result {
            case .success(let receipt):
                completion(.success(receipt.results))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
