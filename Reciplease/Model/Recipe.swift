//
//  RecipeDataModel.swift
//  Reciplease
//
//  Created by Raphaël Payet on 25/06/2021.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {    
    static var favorites: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? CoreDataStack().viewContext.fetch(request) else { return []}
        return recipes
    }
}

extension Recipe {}
