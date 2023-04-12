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

class ReceipeListPresenter: ReceipeListPresentationLogic {
    
    weak var viewController: RecipesListDisplayLogic?
    
    func presentFetchResults(response: RecipesModels.FetchReceipt.Response) {
        let response = response.receipe
        let viewModel = RecipesModels.FetchReceipt.ViewModel(recipe: response)
        viewController?.displayRecipesList(viewModel: viewModel)
    }
    
    
}
