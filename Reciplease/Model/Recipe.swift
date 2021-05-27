//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation

struct Recipe {
    let name: String
    let ingredients: [String]
    let cookTime: Int
    let calories: Int
    
    static let fakeRecipe = Recipe(name: "Pizza", ingredients: ["Mozzarella, Pepperoni, Cheese"], cookTime: 10, calories: 3000)
    
    static let mockRecipes = [
        Recipe(name: "Pizza",
               ingredients: ["Mozzarella, Pepperoni, Cheese", "Mozzarella, Pepperoni, Cheese", "Mozzarella, Pepperoni, Cheese", "Mozzarella, Pepperoni, Cheese"],
               cookTime: 10,
               calories: 3000),
        Recipe(name: "Pasta", ingredients: ["Steak, Tomato, Cheese"], cookTime: 30, calories: 2000),
        Recipe(name: "Salad", ingredients: ["Salad, Tomato, Corn"], cookTime: 10, calories: 1500)
    ]
    
    static let secondMockRecipes = [
        Recipe(name: "Pizza", ingredients: ["Mozzarella, Pepperoni, Cheese"], cookTime: 10, calories: 3000),
        Recipe(name: "Pasta", ingredients: ["Steak, Tomato, Cheese"], cookTime: 30, calories: 2000),
        Recipe(name: "Salad", ingredients: ["Salad, Tomato, Corn"], cookTime: 10, calories: 1500),
        Recipe(name: "Pizza", ingredients: ["Mozzarella, Pepperoni, Cheese"], cookTime: 10, calories: 3000),
        Recipe(name: "Pasta", ingredients: ["Steak, Tomato, Cheese"], cookTime: 30, calories: 2000),
        Recipe(name: "Salad", ingredients: ["Salad, Tomato, Corn"], cookTime: 10, calories: 1500),
    ]

}

