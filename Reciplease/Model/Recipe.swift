//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation
import CoreData


class Recipe {
    var label: String?
    var cuisineType: String?
    var calories: Double?
    var cookTime: Double?
    var ingredients: [String]?
    var url: URL?
    var imageURL: URL?
    
    
    static var fakeRecipe: Recipe {
        let recipe = Recipe()
        
        recipe.label        = "Pizza"
        recipe.calories     = 3000
        recipe.cookTime     = 20
        recipe.cuisineType  = "Italian"
        recipe.ingredients  = ["Tomato", "Mozzarella", "Cheese"]
        
        return recipe
    }

    
    static var mockRecipes: [Recipe] {
        let recipes = [fakeRecipe, fakeRecipe, fakeRecipe]
        return recipes
    }
    
    
    static func transformToDataModel(recipe: Recipe) {
        let dataModel = RecipeDataModel(context: AppDelegate.viewContext)
        
        dataModel.label         = recipe.label
        dataModel.cuisineType   = recipe.cuisineType
        dataModel.calories      = recipe.calories ?? 0
        dataModel.cookTime      = recipe.cookTime ?? 0
        if let ingredients = recipe.ingredients {
            dataModel.ingredients   = NSSet(array: ingredients)
        }
        dataModel.url           = recipe.url
        dataModel.imageURL      = recipe.imageURL
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
    
    func transformToObject() -> Recipe? {
        let recipe = Recipe()
        
        
        recipe.label        = self.label
        recipe.calories     = self.calories
        recipe.cookTime     = self.cookTime
        recipe.cuisineType  = self.cuisineType
        recipe.url          = self.url
        recipe.imageURL     = self.imageURL
        
        guard let ingredients = self.ingredients else { return nil }
        var ingredientsArray: [String] = []
        
        for ingredient in ingredients {
            if let ingredientString = ingredient as? String {
                #warning("Convert ingredients")
                ingredientsArray.append(ingredientString)
            }
        }
        
        recipe.ingredients = ingredientsArray
        
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
            guard let optionalText = object["text"] as? String?,
                  let text = optionalText else { return nil }
            ingredientsString.append(text)
        }
        
        let recipe = Recipe()
        
        recipe.label        = label
        recipe.calories     = calories
        recipe.cookTime     = cookTime
        recipe.cuisineType  = cuisineType
        recipe.url          = url
        recipe.imageURL     = imageURL
        recipe.ingredients  = ingredientsString

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
