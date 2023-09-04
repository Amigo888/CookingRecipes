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

final class ReceipeListInteractor: ReceipeListBuisnessLogic {
    
    var presenter: ReceipeListPresentationLogic?
    var worker: ReceipeListDoingSomethingWorkerLogic
    
    init(worker: ReceipeListDoingSomethingWorkerLogic) {
        self.worker = worker
    }
    
    func fetchFoods(request: RecipesModels.FetchReceipt.Request) {
        worker.fetchReceipt(type: request.typeOfMeal, completion: { receipes in
            let response = RecipesModels.FetchReceipt.Response(receipe: receipes)
            self.presenter?.presentFetchResults(response: response)
        })
    }
}

