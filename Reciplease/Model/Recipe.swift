//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation

struct RecipeHits: Decodable {
    let hits: [RecipeInformations]
}

struct RecipeInformations: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let ingredients: [Ingredient]
    let calories: Double
    let totalTime: Double
    
    static let fakeRecipe = Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60)
    
    static let mockRecipes = [
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60)
    ]
}

struct Ingredient: Decodable {
    let text: String
}

