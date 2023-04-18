//
//  SummaryReceipe.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import Foundation

struct DetailedRecipe {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
    let creditsText, license, sourceName: String
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType, summary: String
    let cuisines: [Any?]
    let dishTypes: [String]
    let diets, occasions: [Any?]
    let winePairing: WinePairing
    let instructions: String
    let analyzedInstructions: [Any?]
    let originalID: NSNull
    let spoonacularSourceURL: String
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient {
    let id: Int
    let aisle, image: String
    let consistency: Consistency
    let name, nameClean, original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

enum Consistency {
    case liquid
    case solid
}

// MARK: - Measures
struct Measures {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric {
    let amount: Double
    let unitShort, unitLong: String
}

// MARK: - WinePairing
struct WinePairing {
    let pairedWines: [Any?]
    let pairingText: String
    let productMatches: [Any?]
}
