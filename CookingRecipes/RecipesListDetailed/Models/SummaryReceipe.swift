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
    let dishTypes: [String]
    let readyInMinutes: Int
    let summary: String
    let instructions: String?
    let healthScore: Int
    let vegan: Bool
    let glutenFree: Bool
    let aggregateLikes: Int
    let analyzedInstructions: [Instruction]?
    let extendedIngredients: [Ingredient]?
    let winePairing: WinePairing?
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
    let image: String?
    let measures: Measures?
}

struct Equipment: Decodable {
    let id: Int
    let name: String
}

struct Measures: Decodable {
    let metric: Metric
}

struct Metric: Decodable {
    let amount: Double
    let unitShort, unitLong: String
}

struct WinePairing: Decodable {
    let pairingText: String
    let productMatches: [PairingMatches]?
}

struct PairingMatches: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: String?
    let imageUrl: String?
}


