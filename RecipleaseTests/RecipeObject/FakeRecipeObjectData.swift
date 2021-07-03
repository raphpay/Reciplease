//
//  FakeRecipeObjectData.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 28/06/2021.
//

import Foundation

class FakeRecipeObjectData {
    
    static var correctDict : [String: Any] {
        let dict = [
            "label" : "Essentials: Rice",
            "calories": 3000.0,
            "cuisineType": ["indian"],
            "image" : "https://www.edamam.com/web-img/b71/b716942f16e3e9490829f7da8dba509e.jpg",
            "ingredientLines" : [ "1 cup long-grain white rice"],
            "shareAs" : "http://www.edamam.com/recipe/essentials-rice-b1957a6a4025b25f6da6aef1fad452d4/rice%2C",
            "source" : "Serious Eats",
            "totalTime" : 0.0,
            "totalWeight" : "618.4279791671553",
            "uri" : "http://www.edamam.com/ontologies/edamam.owl#recipe_b1957a6a4025b25f6da6aef1fad452d4",
            "url" : "http://www.seriouseats.com/recipes/2008/04/essentials-how-to-cook-rice.html",
        ] as [String : Any]
        
        return dict
    }
    
    
    static var incorrectDict : [String: Any] {
        let dict = [ "Hello": "World"]
        return dict
    }
}
