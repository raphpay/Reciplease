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
    let cuisineType: [String]
    
    static let fakeRecipe = Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60, cuisineType: [])
    
    static let mockRecipes = [
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60, cuisineType: []),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60, cuisineType: []),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60, cuisineType: []),
        Recipe(label: "Pizza", ingredients: [Ingredient(text: "Mozzarella")], calories: 3000, totalTime: 60, cuisineType: [])
    ]
}

struct Ingredient: Decodable {
    let text: String
}

