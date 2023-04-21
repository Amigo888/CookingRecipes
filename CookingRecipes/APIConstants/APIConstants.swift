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
    
    static let API_KEY = "a858a579a81c4457b0aaea9ae48f41b0"

    enum URLPaths: String {
        case scheme = "https"
        case host = "api.spoonacular.com"
        case hostPhoto = "spoonacular.com"
        case receipes = "/recipes/complexSearch"
        case path = "/recipes"
        case pathPhoto = "/cdn/ingredients_250x250/"
    }
}
