//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation
import CoreData


struct Recipe: Decodable {
    let label: String?
    let cuisineType: String?
    let calories: Double?
    let cookTime: Double?
    let ingredients: [String]?
    let url: URL?
    let imageURL: URL?
    
    static var fakeRecipe: Recipe {
        let recipe = Recipe(label: "Pizza", cuisineType: "Italian", calories: 3000, cookTime: 20, ingredients: ["Tomato", "Mozzarella", "Cheese"], url: nil, imageURL: nil)
        return recipe
    }
    
    static var mockRecipes: [Recipe] {
        let recipes = [fakeRecipe, fakeRecipe, fakeRecipe]
        return recipes
    }
}

class RecipeDataModel: NSManagedObject {
    static var all: [RecipeDataModel] {
        let request: NSFetchRequest<RecipeDataModel> = RecipeDataModel.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return []}
        return recipes
    }
}

extension RecipeDataModel {
    
    
    static func transformRecipeToDataModel(recipe: Recipe) -> RecipeDataModel {
        let dataModel = RecipeDataModel(context: AppDelegate.viewContext)
        dataModel.label = recipe.label
        return dataModel
    }
    
    static func transformRecipeFromDataModel(dataModel: RecipeDataModel) -> Recipe {
        let recipe = Recipe(label: dataModel.label, cuisineType: dataModel.cuisineType, calories: dataModel.calories, cookTime: dataModel.cookTime, ingredients: [""], url: dataModel.url, imageURL: dataModel.imageURL)
        return recipe
    }
    
    static func transformRecipe(dict: [String: Any]) -> Recipe? {
        guard let label = dict["label"] as? String,
              let calories = dict["calories"] as? Double,
              let cookTime = dict["totalTime"] as? Double,
              let urlString = dict["url"] as? String,
              let imageURLString = dict["image"] as? String
        else { return nil }
        
        guard let ingredients   = dict["ingredients"] as? [AnyObject]   else { return nil }
        guard let url           = URL(string: urlString)                else { return nil }
        guard let imageURL      = URL(string: imageURLString)           else { return nil }
        var cuisineType: String = ""
        if let cuisineTypes = dict["cuisineType"] as? [String] {
          cuisineType = cuisineTypes[0]
        }
        
        var ingredientsString: [String] = []
        for object in ingredients {
            guard let text = object["text"] as? String else { return nil }
            ingredientsString.append(text)
        }
        
        let recipe = Recipe(label: label, cuisineType: cuisineType, calories: calories, cookTime: cookTime, ingredients: ingredientsString, url: url, imageURL: imageURL)
        return recipe
    }
}

class Ingredient: NSManagedObject {
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else { return []}
        return ingredients
    }
}

extension Ingredient {
    static func transformIngredient(dict: AnyObject, for recipe: RecipeDataModel) -> Ingredient? {
        let ingredient = Ingredient(context: AppDelegate.viewContext)
        
        guard let text = dict["text"] as? String else { return nil }
        
        ingredient.text     = text
        ingredient.recipe   = recipe
        
        return ingredient
    }
}
