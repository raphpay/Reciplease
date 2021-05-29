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
    func getRecipe(containing knownIngredients: [String]) {
        // TODO : See if there is a way to construct the url with Alamofire
        var ingredientString = ""
        for ingredient in knownIngredients {
            ingredientString += "\(ingredient),"
        }
        print(ingredientString)
        let completeURL = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=\(ingredientString)"
        AF.request(completeURL).validate().responseDecodable(of: RecipeHits.self) { response in
            
            guard response.error == nil else {
                print("error : \(response.error!)")
                return }
            guard let value = response.value else {
                print("no value")
                return
            }
            for hit in value.hits {
                let recipe = hit.recipe
                print("Meal: \(recipe.label)")
//                print("Ingredients")
                for ingredient in recipe.ingredients {
//                    print(ingredient.text)
                }
//                print("Calories: \(recipe.calories)")
//                print("Total time: \(recipe.totalTime)")
            }
        }
    }
}
