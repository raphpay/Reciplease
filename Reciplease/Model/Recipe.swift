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
        
        
        recipe.label = label
        recipe.calories = calories
        recipe.cookTime = cookTime
        recipe.cuisineType = cuisineType[0]
        #warning("Add ingredients relation")
        return recipe
    }
}


