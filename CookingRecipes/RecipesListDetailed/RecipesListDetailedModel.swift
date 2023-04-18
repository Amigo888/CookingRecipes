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
            let typeOfMeal: String
        }
        
        struct Response {
            let receipe: Result<[SummaryReceipe], Error>
        }
        
        struct ViewModel {
            let recipe: [SummaryReceipe]
        }
        
        struct ViewModelFailure {
            let errorMessage: String
        }
    }
}
