//
//  RecipesListDetailedPresenter.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation

protocol RecipesListDetailedPresenterLogic {
    func presentFetchResults(response: RecipesDetailedModels.FetchReceipt.Response)
    
}

class RecipesListDetailedPresenter: RecipesListDetailedPresenterLogic {
    
    weak var viewController: RecipesListDetaildeDisplayLogic?
    
    
    func presentFetchResults(response: RecipesDetailedModels.FetchReceipt.Response) {
        switch response.receipeDetail {
        case (.success(let detailedInfo)):
            if detailedInfo.isEmpty {
                let viewModel = RecipesDetailedModels.FetchReceipt.ViewModelFailure(errorMessage: "No data")
                viewController?.displaySummaryListFailure(viewModel: viewModel)
            } else {
                let response = detailedInfo
                let viewModel = RecipesDetailedModels.FetchReceipt.ViewModel(recipeDetail: detailedInfo)
                viewController?.displaySummaryList(viewModel: viewModel)
            }
        case (.failure(let error)):
            let viewModel = RecipesDetailedModels.FetchReceipt.ViewModelFailure(errorMessage: error.localizedDescription)
            viewController?.displaySummaryListFailure(viewModel: viewModel)
        }
    }
    
    
}
 
