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
    var isFavorite: Bool?
    
    
    static var fakeRecipe: Recipe {
        let recipe = Recipe()
        
        recipe.label        = "Pizza"
        recipe.calories     = 3000
        recipe.cookTime     = 20
        recipe.cuisineType  = "Italian"
        recipe.ingredients  = ["Tomato", "Mozzarella", "Cheese"]
        recipe.isFavorite   = false
        
        return recipe
    }

    
    static var mockRecipes: [Recipe] {
        let recipes = [fakeRecipe, fakeRecipe, fakeRecipe]
        return recipes
    }
    
    
    static func transformRecipe(dict: [String: Any], lastID: Int) -> Recipe? {
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
        recipe.isFavorite   = false
        
        return recipe
    }
    
    func isInFavorites() -> Bool {
        var isFavorite = false
        for dataModel in RecipeDataModel.all {
            if let name = self.label,
                dataModel.label == name {
                isFavorite = true
            }
        }
        return isFavorite
    }
    
    func transformToDataModel() {
        let dataModel = RecipeDataModel(context: AppDelegate.viewContext)
        
        dataModel.label         = self.label
        dataModel.cuisineType   = self.cuisineType
        dataModel.calories      = self.calories ?? 0
        dataModel.cookTime      = self.cookTime ?? 0
        dataModel.url           = self.url
        dataModel.imageURL      = self.imageURL
        
        if let ingredients = self.ingredients {
            for ingredient in ingredients {
                if let DMIngredient = Ingredient.transformIngredient(text: ingredient, for: dataModel) {
                    dataModel.addToIngredients(DMIngredient)
                }
            }
        }
    }
    
    func addToFavorites(completion: @escaping (_ success: Bool,_ error: RecipleaseError?) -> Void) {
        for object in RecipeDataModel.all {
            guard object.label != self.label else {
                completion(false, .alreadyInFavorites)
                return
            }
        }
        
        self.transformToDataModel()
        
        do {
            try AppDelegate.viewContext.save()
            self.isFavorite = true
            completion(true, nil)
        } catch {
            self.isFavorite = false
            completion(false, .unableToFavorite)
        }
    }
    
    func removeFromFavorites(completion: @escaping (_ success: Bool) -> Void) {
        for object in RecipeDataModel.all {
            if let name = self.label,
                object.label == name {
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
        
        // The recipe is forced to be true, caused it's contained by the CoreData stack
        recipe.isFavorite   = true
        
        guard let ingredients = self.ingredients?.allObjects else { return nil }
        var ingredientsArray: [String] = []
        for ingredient in ingredients {
            
            guard let ingredient = ingredient as? Ingredient,
               let text = ingredient.text else { return nil }
            
            ingredientsArray.append(text)
        }
        
        recipe.ingredients = ingredientsArray
        
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
    static func transformIngredient(text: String, for dataModel: RecipeDataModel) -> Ingredient? {
        let ingredient = Ingredient(context: AppDelegate.viewContext)
        
        ingredient.text     = text
        ingredient.recipe   = dataModel
        
        return ingredient
    }
}
