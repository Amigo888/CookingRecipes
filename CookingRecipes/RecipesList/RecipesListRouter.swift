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
    var dataStoreId: Int? { get set }
}

class ReceipeListRouter: ReceipeListRouterLogic, ReceipeListDataPassing {
    
    var dataStoreId: Int?
    weak var viewController: RecipesListViewController?
    
    func navigateToNextScreen() {
        guard let currnetVc = viewController else { return }
        let nextVC = RecipesListDetailedViewController()
        nextVC.id = dataStoreId ?? 0
        currnetVc.navigationController?.pushViewController(nextVC, animated: true)
    }
}
