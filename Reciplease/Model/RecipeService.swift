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
    
    
    // MARK: - Public Methods
    func getRecipe(containing knownIngredients: [String],
                   completion: @escaping ((_ recipes: [Recipe]?,_ success: Bool, _ error: RecipleaseError?) -> Void)) {
        // TODO : See if there is a way to construct the url with Alamofire
        
        var ingredientString = ""
        for ingredient in knownIngredients {
            ingredientString += "\(ingredient),"
        }
        
        guard !ingredientString.isEmpty else {
            completion(nil, false, .noIngredients)
            return
        }
       
        let completeURL = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        
        AF.request(completeURL).responseData { response in
            
            guard let data = response.data else {
                completion(nil, false, .invalidData)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                completion(nil, false, .invalidData)
                return
            }
            
            guard let hits = json["hits"] as? [AnyObject],
                  !hits.isEmpty else {
                completion(nil, false, .noRecipes)
                return
            }
            
            var totalRecipes: [Recipe] = []
            
            for hit in hits {
                
                guard let dict = hit["recipe"] as? [String: Any],
                      let recipe = RecipeDataModel.transformRecipe(dict: dict)
                      else {
                    completion(nil, false, .invalidResponse)
                    return
                }
                
                totalRecipes.append(recipe)
            }
            
            completion(totalRecipes, true, nil)
        }
    }
    
    
    func fetchImageData(from url: URL, completion: @escaping (_ imageData: Data?, _ success: Bool,_ error: RecipleaseError?) -> Void) {
        AF.request(url).validate().responseData { response in
            guard let data = response.data else {
                completion(nil, false, .invalidData)
                return
            }
            
            completion(data, true, nil)
        }
    }
    
    
    func addToFavorites(recipe: Recipe, completion: @escaping (_ success: Bool,_ error: RecipleaseError?) -> Void) {
       
        for object in RecipeDataModel.all {
            guard object.label != recipe.label else {
                completion(false, .alreadyInFavorites)
                return 
            }
        }
        
        Recipe.transformToDataModel(recipe: recipe)
        
        do {
            try AppDelegate.persistantContainer.viewContext.save()
            completion(true, nil)
        } catch {
            completion(false, .unableToFavorite)
        }
    }
}
