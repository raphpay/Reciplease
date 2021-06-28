//
//  RecipeDataModel.swift
//  Reciplease
//
//  Created by Raphaël Payet on 25/06/2021.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {}

extension Recipe {}

class RecipeObject {
    var id = UUID()
    var label: String?
    var cuisineType: String?
    var calories: Double?
    var cookTime: Double?
    var url: URL?
    var imageURL: URL?
    
    // TODO: Add ingredients
    
    init(id: UUID, label: String, cuisineType: String, calories: Double, cookTime: Double, url: URL, imageURL: URL) {
        
        self.id             = id
        self.label          = label
        self.cuisineType    = cuisineType
        self.calories       = calories
        self.cookTime       = cookTime
        self.url            = url
        self.imageURL       = url
    }
}
