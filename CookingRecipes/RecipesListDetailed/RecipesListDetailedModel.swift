//
//  RecipesListDetailedModel.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation

enum RecipesDetailedModels {
    
    enum FetchReceipt {
        
        struct Request {
            let id: Int
        }
        
        struct Response {
            let receipeDetail: Result<[DetailedRecipe], Error>
        }
        
        struct ViewModel {
            let recipeDetail: [DetailedRecipe]
        }
        
        struct ViewModelFailure {
            let errorMessage: String
        }
    }
}
