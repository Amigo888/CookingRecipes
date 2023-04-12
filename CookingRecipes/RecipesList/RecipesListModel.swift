//
//  RecipesListModel.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

enum RecipesModels {
    
    enum FetchReceipt {
        
        struct Request {}
        
        struct Response {
            let receipe: Result<[Receipt], Error>
        }
        
        struct ViewModel {
            let recipe: [Receipt]
        }
        
        struct ViewModelFailure {
            let errorMessage: String
        }
    }
}
