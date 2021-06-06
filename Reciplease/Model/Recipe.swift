//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation
import CoreData


class Recipe: NSManagedObject {
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipes
    }
}

class Ingredient: NSManagedObject {
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return ingredients
    }
}

extension Recipe {
    
    static var fakeRecipe: Recipe {
        let recipe = Recipe()
        recipe.label        = "Pizza"
        recipe.calories     = 3000
        recipe.cookTime     = 20
        recipe.cuisineType  = "Italian"
        return recipe
    }
    
    static var mockRecipes: [Recipe] {
        let recipes = [fakeRecipe, fakeRecipe, fakeRecipe]
        return recipes
    }
    
    
    static func transformRecipe(dict: [String: Any]) -> Recipe? {
        let recipe = Recipe(context: AppDelegate.viewContext)
        
        guard let label = dict["label"] as? String,
              let calories = dict["calories"] as? Double,
              let cookTime = dict["totalTime"] as? Double,
              let cuisineType = dict["cuisineType"] as? [String]
        else { return nil }
        
        guard let ingredients = dict["ingredients"] as? [AnyObject] else { return nil }
        
        recipe.label        = label
        recipe.calories     = calories
        recipe.cookTime     = cookTime
        recipe.cuisineType  = cuisineType[0]
        
        for object in ingredients {
            guard let _ = Ingredient.transformIngredient(dict: object, for: recipe) else { return nil }
            // Ingredient - Recipe relation
        }
        
        return recipe
    }
}

extension Ingredient {
    static func transformIngredient(dict: AnyObject, for recipe: Recipe) -> Ingredient? {
        let ingredient = Ingredient(context: AppDelegate.viewContext)
        
        guard let text = dict["text"] as? String else { return nil }
        
        ingredient.text     = text
        ingredient.recipe   = recipe
        
        return ingredient
    }
}
