//
//  RecipesListWorker.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListDoingSomethingWorkerLogic {
    func doSomething(completionHandler: (RecipesModels.FetchReceipt.Response) -> Void)
}

class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    
    func doSomething(completionHandler: (RecipesModels.FetchReceipt.Response) -> Void) {
        //do Smt
    }
    
    
}
