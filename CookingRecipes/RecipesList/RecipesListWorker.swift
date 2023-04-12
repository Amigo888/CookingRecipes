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

class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    func fetchReceipt(completion: @escaping (Result<[Receipt], Error>) -> Void) {
        do {
            let receipes = Source.makeContacts()
            completion(.success(receipes))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
}
