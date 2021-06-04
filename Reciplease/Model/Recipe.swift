//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation
import CoreData

//struct RecipeHits: Decodable {
//    let hits: [RecipeInformations]
//}
//
//struct RecipeInformations: Decodable {
//    let recipe: Recipe
//}

// TODO: Change to struct
class Recipe {
//    static var all: [Recipe] {
//        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
//        return recipes
//    }
    
    let label: String
    let calories: Double
    let cookTime: Double
    let cuisineType: [String]
    let ingredients: [String]
    
    init(label: String, calories: Double, cookTime: Double, cuisineType: [String], ingredients: [String]) {
        self.label = label
        self.calories = calories
        self.cookTime = cookTime
        self.cuisineType = cuisineType
        self.ingredients = ingredients
    }
    
    static let fakeRecipe = Recipe(label: "Pizza", calories: 3000, cookTime: 20, cuisineType: ["Italian"], ingredients: ["Mozzarella", "Cheese", "Tomato"])

    static let mockRecipes = [
        Recipe(label: "Pizza", calories: 3000, cookTime: 20, cuisineType: ["Italian"], ingredients: ["Mozzarella", "Cheese", "Tomato"]),
        Recipe(label: "Pizza", calories: 3000, cookTime: 20, cuisineType: ["Italian"], ingredients: ["Mozzarella", "Cheese", "Tomato"]),
        Recipe(label: "Pizza", calories: 3000, cookTime: 20, cuisineType: ["Italian"], ingredients: ["Mozzarella", "Cheese", "Tomato"]),
        Recipe(label: "Pizza", calories: 3000, cookTime: 20, cuisineType: ["Italian"], ingredients: ["Mozzarella", "Cheese", "Tomato"])
    ]
}


