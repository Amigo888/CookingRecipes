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
    
    enum URLDetail {
        static let baseURL = URL(string: "https://api.spoonacular.com")!
        static let baseURLPhoto = URL(string: "https://spoonacular.com")!
        static let pathComponentsList = ["recipes","complexSearch"]
        static let pathComponentsListDetailed = ["information"]
        static let pathComponentsPhoto = "cdn/ingredients_250x250"
        static let emptyQueryParameters = ["" : ""]
        static let QueryParametersDetailed = ["includeNutrition" : "\(false)", "apiKey" : APIConstants.API_KEY]
    }
}
