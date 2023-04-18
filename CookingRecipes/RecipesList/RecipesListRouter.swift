//
//  RecipesListRouter.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import Foundation

protocol ReceipeListRouterLogic {
    func navigateToNextScreen()
}
protocol ReceipeListDataPassing {
    
}

class ReceipeListRouter: ReceipeListRouterLogic {
    
    weak var viewController: RecipesListViewController?
    
    func navigateToNextScreen() {
        guard let currnetVc = viewController else { return }
        let nextVC = RecipesListDetailedViewController()
        currnetVc.navigationController?.pushViewController(nextVC, animated: true)
    }
}
