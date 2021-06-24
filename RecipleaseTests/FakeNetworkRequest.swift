//
//  FakeNetworkRequest.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 12/06/2021.
//

import Foundation
@testable import Reciplease


class FakeAFSession: RecipeRequestDelegate {
    var lastID: Double = 0
    var maxRecipes: Int = 0
    var data: Data?
    var response: HTTPURLResponse?
    var error: RecipleaseError?
    var url: URL? = nil
    
    init(data: Data?, response: HTTPURLResponse?, error: RecipleaseError?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func getRecipes(completion: @escaping ([Recipe]?, RecipleaseError?) -> Void) {
        guard let response = response,
              response.statusCode == 200 else {
            completion(nil, .invalidResponse)
            return
        }
        
        guard let data = data else {
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
        
        var totalRecipes = [Recipe]()
        
        for hit in hits {
            guard let dict = hit["recipe"] as? [String: Any],
                  let recipe = Recipe.transformRecipe(dict: dict, lastId: lastID) else {
                completion(nil, .invalidResponse)
                return
            }
            
            totalRecipes.append(recipe)
        }
        
        completion(totalRecipes, nil)
    }
}
