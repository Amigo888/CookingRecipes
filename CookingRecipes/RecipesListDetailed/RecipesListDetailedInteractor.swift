//
//  RecipesListDetailedInteractor.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation

protocol RecipesListDetailedBuisnessLogic {
    func fetchDetails(response: RecipesDetailedModels.FetchReceipt.Request)
}

final class RecipesListDetailedInteractor: RecipesListDetailedBuisnessLogic {
    
    var worker: ReceipeListDetaildWorkerLogic
    var presenter: RecipesListDetailedPresenterLogic?
    
    init(worker: RecipesListDetailedWorker) {
        self.worker = worker
    }
    
    func fetchDetails(response: RecipesDetailedModels.FetchReceipt.Request) {
        worker.fetchReceiptDetails(id: response.id) { detailedInfo in
            let response = RecipesDetailedModels.FetchReceipt.Response(receipeDetail: detailedInfo)
            self.presenter?.presentFetchResults(response: response)
        }
    }
}
