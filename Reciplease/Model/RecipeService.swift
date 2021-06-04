//
//  RecipeService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 28/05/2021.
//

import Foundation
import Alamofire

class RecipeService {
    
    // MARK: - Properties
    static var shared = RecipeService()
    private init() {}
    
    private let baseURL         = "https://api.edamam.com/search?"
    private let APP_ID          = "08b5ed9a"
    private let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
    private let maxRecipes      = 2
    
    var favorites: [Recipe]     = []
    
    
    // MARK: - Public Methods
    func getRecipe(containing knownIngredients: [String], completion: @escaping ((_ recipes: [Recipe]?,_ success: Bool) -> Void)) {
        // TODO : See if there is a way to construct the url with Alamofire
        // TODO: Add error parameter in completion
        var ingredientString = ""
        for ingredient in knownIngredients {
            ingredientString += "\(ingredient),"
        }
        guard !ingredientString.isEmpty else {
            completion(nil, false)
            return
        }
        let completeURL = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        
        AF.request(completeURL).responseData { response in
            guard let data = response.data else {
                completion(nil, false)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                completion(nil, false)
                return
            }
            
            if let hits = json["hits"] as? [AnyObject] {
                var totalRecipes: [Recipe] = []
                
                for hit in hits {
                    if let recipe = hit["recipe"] as? [String: Any],
                       let label = recipe["label"] as? String,
                       let calories = recipe["calories"] as? Double,
                       let totalTime = recipe["totalTime"] as? Double,
                       let cuisineType = recipe["cuisineType"] as? [String],
                       let ingredients = recipe["ingredients"] as? [AnyObject] {
                        var recipeIngredients : [String] = []
                        for object in ingredients {
                            if let text = object["text"] as? String {
                                recipeIngredients.append(text)
                            } else {
                                completion(nil, false)
                            }
                        }
                        let decodedRecipe = Recipe(label: label, calories: calories, cookTime: totalTime, cuisineType: cuisineType, ingredients: recipeIngredients)
                        totalRecipes.append(decodedRecipe)
                    } else {
                        completion(nil, false)
                    }
                }
                
                completion(totalRecipes, true)
            } else {
                completion(nil, false)
            }
        }
    }
    
    
    func addToFavorite(recipe: Recipe) {
        // TODO: Save to Core Data
        favorites.append(recipe)
        do {
            try AppDelegate.persistantContainer.viewContext.save()
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
}
