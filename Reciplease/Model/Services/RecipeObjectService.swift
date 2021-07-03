//
//  RecipeObjectService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 28/06/2021.
//

import Foundation

class RecipeObjectService {
    static let shared = RecipeObjectService()
    private init() {}
    
    func transformFromDict(_ dict :[String: Any]) -> RecipeObject? {
        guard let label = dict["label"] as? String,
              let ingredients = dict["ingredientLines"] as? [String],
              let calories = dict["calories"] as? Double,
              let cookTime = dict["totalTime"] as? Double,
              let urlString = dict["url"] as? String,
              let imageURLString = dict["image"] as? String,
              let url = URL(string: urlString),
              let imageURL = URL(string: imageURLString) else {
            return nil
        }
        
        var cuisineType = ""
        if let cuisines = dict["cuisineType"] as? [String] {
            cuisineType = cuisines[0]
        }
        

        let recipeObject = RecipeObject(id: UUID(), label: label, cuisineType: cuisineType, ingredients: ingredients, calories: calories, cookTime: cookTime, url: url, imageURL: imageURL)
        return recipeObject
    }
    
    func transformFromCoreData(recipe: RecipeDataModel?) -> RecipeObject? {
        guard let recipe = recipe,
              let id = recipe.id,
              let label = recipe.label,
              let cuisineType = recipe.cuisineType,
              let url = recipe.url,
              let imageURL = recipe.imageURL,
              let ingredients = recipe.ingredients?.allObjects else { return nil }
        
        var ingredientsArray: [String] = []
        for ingredient in ingredients {
            
            guard let ingredient = ingredient as? Ingredient,
                  let text = ingredient.text else { return nil }
            
            ingredientsArray.append(text)
        }
        
        let object = RecipeObject(id: id, label: label, cuisineType: cuisineType, ingredients: ingredientsArray,
                                  calories: recipe.calories, cookTime: recipe.cookTime, url: url, imageURL: imageURL)
        
        return object
    }
}
