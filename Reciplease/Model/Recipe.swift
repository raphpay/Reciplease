//
//  Recipe.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import Foundation
import CoreData


class Recipe {}

class RecipeDataModel: NSManagedObject {
    static var all: [RecipeDataModel] {
        let request: NSFetchRequest<RecipeDataModel> = RecipeDataModel.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return []}
        return recipes
    }
}

extension RecipeDataModel {}

class Ingredient: NSManagedObject {}

extension Ingredient {
    
}
