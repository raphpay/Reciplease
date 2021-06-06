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
        #warning("Add error parameter in completion")
        
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
            
            guard let hits = json["hits"] as? [AnyObject] else {
                completion(nil, false)
                return
            }
            
            var totalRecipes: [Recipe] = []
            
            for hit in hits {
                guard let dict = hit["recipe"] as? [String: Any],
                      let recipe = Recipe.transformRecipe(dict: dict)
                      else {
                    completion(nil, false)
                    return
                }
                totalRecipes.append(recipe)
            }
            
            completion(totalRecipes, true)
        }
    }
    
    
    func addToFavorites(recipe: Recipe?) {
        // TODO: Save to Core Data
        guard let recipe = recipe else { return }
        favorites.append(recipe)
        do {
            try AppDelegate.persistantContainer.viewContext.save()
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
}
