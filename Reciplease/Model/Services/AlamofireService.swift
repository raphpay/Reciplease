//
//  AlamofireService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation
import Alamofire


class AlamofireService: NetworkRequest {
    
    static let shared = AlamofireService()
    private init() {}
<<<<<<< HEAD
    
    private let baseURL         = "https://api.edamam.com/search?"
    private let APP_ID          = "08b5ed9a"
    private let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
    #warning("Always let max recipes to 10")
    private let maxRecipes      = 10
    
    
    
    func createURL(with ingredients: [String]) -> URL? {
        guard !ingredients.isEmpty else {
            return nil
        }
        
        
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += "\(ingredient.removingWhitespaces()),"
        }
        
        let urlString = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        guard let url = URL(string: urlString) else {
            print("no url")
            return nil
        }
        
        return url
    }
    
    
    
    func getRecipeObjects(from response: [String: Any]?) -> [RecipeObject]? {
        guard let response = response,
              let hits = response["hits"] as? [AnyObject],
                          !hits.isEmpty else { return nil }
                    
        var totalRecipes: [RecipeObject] = []
        
        for hit in hits {
            
            guard let dict = hit["recipe"] as? [String: Any] else { return nil }
            
            if let recipe = RecipeObjectService.shared.transformFromDict(dict) {
                totalRecipes.append(recipe)
            }
        }
        
        return totalRecipes
    }
    
    func fetchImage(from url: URL?, completion: @escaping (_ data: Data?, _ error : NetworkRequestError?) -> Void) {
        guard let url = url else {
            completion(nil, .invalidURL)
            return
        }
        
        AF.request(url).validate().responseData { response in
            DispatchQueue.main.async {
                guard let data = response.value else {
                    completion(nil, .incorrectResponse)
                    return
                }
                
                completion(data, nil)
            }
        }
    }
=======
>>>>>>> development
}
