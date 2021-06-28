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
              let cuisines = dict["cuisineType"] as? [String],
              let ingredients = dict["ingredientLines"] as? [String],
              let calories = dict["calories"] as? Double,
              let cookTime = dict["totalTime"] as? Double,
              let urlString = dict["url"] as? String,
              let imageURLString = dict["image"] as? String,
              let url = URL(string: urlString),
              let imageURL = URL(string: imageURLString) else {
            return nil
        }
        
        let cuisineType = cuisines[0]
        let recipeObject = RecipeObject(id: UUID(), label: label, cuisineType: cuisineType, ingredients: ingredients, calories: calories, cookTime: cookTime, url: url, imageURL: imageURL)
        return recipeObject
    }
    
    func transformFromCoreData(object: Recipe) -> RecipeObject? {
        return nil
    }
}
