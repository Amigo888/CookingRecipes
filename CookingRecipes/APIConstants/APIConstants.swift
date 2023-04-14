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
    static let scheme = "https"
    static let host = "api.spoonacular.com"
    static let path = "/recipes/complexSearch"
    static var queryItems = [
        URLQueryItem(name: "type", value: "drink"),
        URLQueryItem(name: "number", value: "20"),
        URLQueryItem(name: "apiKey", value: "a858a579a81c4457b0aaea9ae48f41b0")
        ]
}