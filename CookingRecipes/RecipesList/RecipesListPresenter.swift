//
//  RecipesListPresenter.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListPresentationLogic {
    func presentFetchResults(response: RecipesModels.FetchReceipt.Response)
}

final class ReceipeListPresenter: ReceipeListPresentationLogic {
    
    weak var viewController: RecipesListDisplayLogic?
    
    func presentFetchResults(response: RecipesModels.FetchReceipt.Response) {
        switch response.receipe {
        case .success(let receipes):
            if receipes.isEmpty {
                let viewModel = RecipesModels.FetchReceipt.ViewModelFailure(errorMessage: "Not data")
                viewController?.displayRecipesListFailure(viewModel: viewModel)
            } else {
                let response = receipes
                let viewModel = RecipesModels.FetchReceipt.ViewModel(recipe: response)
                viewController?.displayRecipesList(viewModel: viewModel)
            }
        case.failure(let error):
            let viewModel = RecipesModels.FetchReceipt.ViewModelFailure(errorMessage: error.localizedDescription)
            viewController?.displayRecipesListFailure(viewModel: viewModel)
        }
    }
}
