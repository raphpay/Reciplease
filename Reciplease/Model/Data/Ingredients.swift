//
//  Ingredients.swift
//  Reciplease
//
//  Created by Raphaël Payet on 25/06/2021.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {}

extension Ingredient {
    static func transformIngredient(text: String, for dataModel: Recipe, context: NSManagedObjectContext) -> Ingredient? {
        let ingredient = Ingredient(context: context)
        
        ingredient.text     = text
        ingredient.recipe   = dataModel
        
        CoreDataStack.shared.saveContext(context)
        
        return ingredient
    }
}

