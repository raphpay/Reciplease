//
//  RecipeService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 28/05/2021.
//

import Foundation
import Alamofire

protocol RecipeDelegate {
    var lastID: Int { get set }
    func createAPIURL(with ingredients: [String]) -> URL?
    func getRecipeHits(from url: URL, completion: @escaping (_ hits: [AnyObject]?,_ error: RecipleaseError?) -> Void)
    func transformHitsToRecipes(_ hits: [AnyObject]?) -> [Recipe]?
    func fetchImageData(from url: URL, completion: @escaping (_ imageData: Data?,_ error: RecipleaseError?) -> Void)
}

extension RecipeDelegate {
    
    func createAPIURL(with ingredients: [String]) -> URL? {
        let baseURL         = "https://api.edamam.com/search?"
        let APP_ID          = "08b5ed9a"
        let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
        let maxRecipes      = 10
        
        guard !ingredients.isEmpty else { return nil }
        
        var ingredientString = String()
        for ingredient in ingredients {
            ingredientString += "\(ingredient),"
        }
        
        let completeURL = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        guard let url = URL(string: completeURL) else { return nil }
        
        return url
    }
    
    
    func getRecipeHits(from url: URL, completion: @escaping ([AnyObject]?, RecipleaseError?) -> Void) {
        AF.request(url).validate().responseData { response in
            guard let data = response.data else {
                completion(nil, .invalidData)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                completion(nil, .invalidData)
                return
            }
            
            guard let hits = json["hits"] as? [AnyObject],
                  !hits.isEmpty else {
                completion(nil, .noRecipes)
                return
            }
            
            completion(hits, nil)
        }
    }
    
    func transformHitsToRecipes(_ hits: [AnyObject]?) -> [Recipe]? {
        guard let hits = hits else { return nil }
        
        var recipes = [Recipe]()
        for hit in hits {
            guard let dict = hit["recipe"] as? [String: Any],
                  let recipe = Recipe.transformRecipe(dict: dict, lastID: lastID) else { return nil }
            recipes.append(recipe)
        }
        
        return recipes
    }
    
    func fetchImageData(from url: URL, completion: @escaping (_ imageData: Data?,_ error: RecipleaseError?) -> Void) {
        AF.request(url).validate().responseData { response in
            guard let data = response.data else {
                completion(nil, .invalidData)
                return
            }
            
            completion(data, nil)
        }
    }
}

class RecipeService: RecipeDelegate {
    // TODO: Remove last id if no solution found
    var lastID = 0
    static let shared = RecipeService()
    private init() {}
}
