//
//  RecipeDataModelService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 28/05/2021.
//

import Foundation
import CoreData

class RecipeDataModelService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    } 
}

extension RecipeDataModelService {
    public func addRecipeToFavorite(_ recipe: RecipeObject) -> RecipeDataModel {
        let dataModel = RecipeDataModel(context: managedObjectContext)
        
        dataModel.id            = recipe.id
        dataModel.label         = recipe.label
        dataModel.cuisineType   = recipe.cuisineType
        dataModel.calories      = recipe.calories ?? 0
        dataModel.cookTime      = recipe.cookTime ?? 0
        dataModel.url           = recipe.url
        dataModel.imageURL      = recipe.imageURL
        
        if let ingredients = recipe.ingredients {
            for ingredient in ingredients {
                if let dataModelIngredient = Ingredient.transformIngredient(text: ingredient,
                                                                            for: dataModel,
                                                                            context: managedObjectContext) {
                    dataModel.addToIngredients(dataModelIngredient)
                }
            }
        }
        
        
        coreDataStack.saveContext(managedObjectContext)
        return dataModel
    }
    
    public func removeRecipeFromFavorites(_ recipe: RecipeObject) {
        // TODO : Handle error
        guard let favorites = getRecipes() else { return }
        for object in favorites {
            if object.id == recipe.id {
                coreDataStack.viewContext.delete(object)
                coreDataStack.saveContext(managedObjectContext)
            }
        }
    }
    
    
    public func getRecipes() -> [RecipeDataModel]? {
        let recipeFetch: NSFetchRequest<RecipeDataModel> = RecipeDataModel.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(recipeFetch)
            return results
        } catch  {
            return nil
        }
    }
    
    
    func isInFavorites(recipe: RecipeObject) -> Bool {
        guard let favorites = getRecipes() else { return false }
        
        for favorite in favorites {
            if recipe.id == favorite.id { return true }
        }
        
        return false
    }
}
