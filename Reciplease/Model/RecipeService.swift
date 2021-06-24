//
//  RecipeService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 28/05/2021.
//

import Foundation
import Alamofire

#warning("Implement those methods")
protocol RecipeRequestDelegate {
    var lastID: Double { get set }
    var maxRecipes: Int { get set }
    var url: URL? { get set }
    
    func getRecipes(completion: @escaping (_ recipe: [Recipe]?,_ error: RecipleaseError?) -> Void)
}

extension RecipeRequestDelegate {
    
    func getRecipes(completion: @escaping ([Recipe]?, RecipleaseError?) -> Void) {
        // TODO : See if there is a way to construct the url with Alamofire
        guard let url = self.url else {
            print("Invalid URL: \(self.url)")
            return
        }
        
        AF.request(url).responseData { response in
            print("in request")
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
            
            var totalRecipes: [Recipe] = []
            
            for hit in hits {
                guard let dict = hit["recipe"] as? [String: Any],
                      let recipe = Recipe.transformRecipe(dict: dict, lastId: Double(self.lastID))
                else {
                    completion(nil, .invalidResponse)
                    return
                }

                totalRecipes.append(recipe)
            }
            
            completion(totalRecipes, nil)
        }
    }
}

class RecipeService: RecipeRequestDelegate {
    var url: URL?
    var lastID: Double = 0
    var maxRecipes: Int = 10
    
    // MARK: - Properties
    static var shared = RecipeService()
    private init() {}
    
    private let baseURL         = "https://api.edamam.com/search?"
    private let APP_ID          = "08b5ed9a"
    private let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
    
    init(url: URL?) {
        guard let url = url else {
            self.url = URL(string: "https://apple.com")
            return
        }
        self.url = url
    }
    
    
    // MARK: - Public Methods
    func createAPIURL(with ingredients: [String]) -> URL? {
        guard !ingredients.isEmpty else { return nil }

        var ingredientString = ""
        for text in ingredients {
            ingredientString += "\(text),"
        }

        let urlString = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        return URL(string: urlString)
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
            try AppDelegate.viewContext.save()
            recipe.isFavorite = true
            completion(true, nil)
        } catch {
            recipe.isFavorite = false
            completion(false, .unableToFavorite)
        }
    }
    
    func removeFromFavorites(recipe: Recipe, completion: @escaping (_ success: Bool) -> Void) {
        // TODO: Implement method
        // TODO: Remove object by its ID
        for object in RecipeDataModel.all {
            if object.id == recipe.id {
                AppDelegate.viewContext.delete(object)
                do {
                    try AppDelegate.viewContext.save()
                    completion(true)
                } catch {
                    completion(false)
                }
            }
        }
    }
}
