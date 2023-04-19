//
//  APIConstants.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 13.04.2023.
//

import Foundation

struct APIConstants {
     static let mealTypes = ["main course","sidedish","dessert",
                            "appetizer","salad","bread","breakfast",
                            "soup","beverage","sauce","marinade",
                            "fingerfood","snack","drink"]
    
    static let API_KEY = "66152d306ad04f3ca4c6cd4240c32ab8"

    enum URLPaths: String {
        case scheme = "https"
        case host = "api.spoonacular.com"
        case receipes = "/recipes/complexSearch"
        case path = "/recipes"
    }
}
