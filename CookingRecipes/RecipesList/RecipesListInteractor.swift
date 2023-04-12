//
//  RecipesListInteractor.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListBuisnessLogic {
    func fetchFoods(request: RecipesModels.FetchReceipt.Request)
}

class ReceipeListInteractor: ReceipeListBuisnessLogic {
    
    var presenter: ReceipeListPresentationLogic?
    var worker: ReceipeListDoingSomethingWorkerLogic?
    
    func fetchFoods(request: RecipesModels.FetchReceipt.Request) {
        let response  = worker?.fetchReceipt()
        presenter?.presentFetchResults(response: response)
    }
}

