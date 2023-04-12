//
//  RecipesListModel.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

enum RecipesModels {
    
    enum FetchReceipt {
        
        struct Request {
            let receipe: [Receipt]
        }
        
        struct Response {
            let receipe: [Receipt]
        }
        
        struct ViewModel {
            let recipe: [Receipt]
        }
    }
}
