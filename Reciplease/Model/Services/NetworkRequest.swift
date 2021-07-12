//
//  NetworkRequest.swift
//  Reciplease
//
//  Created by Raphaël Payet on 12/07/2021.
//

import Foundation
import UIKit
import Alamofire

public enum NetworkRequestError: Error {
    case invalidURL
    case incorrectData
    case incorrectResponse
    case serializationError(Error)
}

public protocol NetworkRequest {
    func getResponse(from url: URL?, completion: @escaping (_ dictionnary: [String: Any]?, _ error : NetworkRequestError?) -> Void)
    func fetchImage(from url: URL?, completion: @escaping (_ data: UIImage?, _ error : NetworkRequestError?) -> Void)
    func createURL(with ingredients: [String]) -> URL?
    func getRecipeObjects(from response: [String: Any]?) -> [RecipeObject]?
}

extension NetworkRequest {
    
    // MARK: - Requests methods
    func getResponse(from url: URL?, completion: @escaping ([String: Any]?, NetworkRequestError?) -> Void) {
        guard let url = url else {
            completion(nil, .invalidURL)
            return
        }
        
        AF.request(url).validate().responseJSON { response in
            guard let value = response.value as? [String: Any] else {
                completion(nil, .incorrectResponse)
                return
            }
            completion(value, nil)
        }
    }
    
    func fetchImage(from url: URL?, completion: @escaping (_ data: UIImage?, _ error : NetworkRequestError?) -> Void) {
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
                
                guard let image = UIImage(data: data) else {
                    completion(nil, .incorrectData)
                    return
                }
                
                completion(image, nil)
            }
        }
    }
    
    
    
    // MARK: - No request methods
    public func createURL(with ingredients: [String]) -> URL? {
        guard !ingredients.isEmpty else {
            return nil
        }
        
        
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += "\(ingredient),"
        }
        
        let baseURL         = "https://api.edamam.com/search?"
        let APP_ID          = "08b5ed9a"
        let APP_KEY         = "ad5b86fa2c4478bfc7c55184d216b14a"
        // Max recipes is 10 to contain the number of recipes.
        // To be optimized when the possibility of loading more recipes is added
        let maxRecipes      = 10
        
        let urlString = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        print(urlString)
        
        return url
    }
    
    public func getRecipeObjects(from response: [String: Any]?) -> [RecipeObject]? {
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
}
