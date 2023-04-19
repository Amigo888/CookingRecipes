//
//  SummaryReceipe.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation


    
    struct DetailedRecipe: Decodable {
        let id: Int
        let title: String
        let image: String?
        let servings: Int
        let readyInMinutes: Int
        let summary: String
        let instructions: String?
        let analyzedInstructions: [Instruction]?
        let extendedIngredients: [Ingredient]?
    }

    struct Instruction: Decodable {
        let name: String?
        let steps: [Step]?
    }

    struct Step: Decodable {
        let number: Int
        let step: String
        let ingredients: [Ingredient]?
        let equipment: [Equipment]?
    }

    struct Ingredient: Decodable {
        let id: Int
        let name: String
        let amount: Double?
        let unit: String?
    }

    struct Equipment: Decodable {
        let id: Int
        let name: String
    }
