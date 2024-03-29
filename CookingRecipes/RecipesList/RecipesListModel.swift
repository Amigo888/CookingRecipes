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
            let typeOfMeal: String
        }
        
        struct Response {
            let receipe: Result<[Receipt], Error>
        }
        
        struct ViewModel {
            let recipe: [Receipt]
        }
        
        struct ViewModelFailure {
            let errorMessage: String
        }
        struct ViewModelLoading {
            var isLoading: Bool
        }
    }
}
