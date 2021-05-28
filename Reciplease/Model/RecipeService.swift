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
    func getRecipe() {
        // TODO : See if there is a way to construct the url with Alamofire
        let completeURL = "\(baseURL)&app_id=\(APP_ID)&app_key=\(APP_KEY)&to=\(maxRecipes)&q=chicken"
        AF.request(completeURL).validate().responseJSON { response in
            guard let JSON = response.value else {
                print("no JSON")
                return
            }
            print(JSON)
        }
    }
}

//Alamofire.request("https://jsonplaceholder.typicode.com/todos/")
//  .responseData { response in
//    let decoder = JSONDecoder()
//    let todo: Result<Todo> = decoder.decodeResponse(from: response)
//}
