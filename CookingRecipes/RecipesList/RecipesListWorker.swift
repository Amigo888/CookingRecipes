//
//  RecipesListWorker.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListDoingSomethingWorkerLogic {
    func fetchReceipt() -> [Receipt]
}

class ReceipeListWorker: ReceipeListDoingSomethingWorkerLogic {
    
    func fetchReceipt() -> [Receipt] {
        let sourceManager = Source.makeContacts()
        return sourceManager
    }
    
    
}
