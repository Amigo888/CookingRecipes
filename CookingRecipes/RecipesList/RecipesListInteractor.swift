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
    
    init(worker: ReceipeListDoingSomethingWorkerLogic) {
        self.worker = worker
    }
    
    func fetchFoods(request: RecipesModels.FetchReceipt.Request) {
        worker?.fetchReceipt(completion: { [weak self] result in
            switch result {
            case .success(let receipes):
                let response = RecipesModels.FetchReceipt.Response(receipe: receipes)
                self?.presenter?.presentFetchResults(response: response)
            case .failure(let failure):
                print(failure)
            }
        })
    }
}

