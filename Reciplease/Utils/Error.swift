//
//  Error.swift
//  Reciplease
//
//  Created by Raphaël Payet on 10/06/2021.
//

import Foundation

enum RecipleaseError: String, Error {

    case title              = "Oups ! An error occured."
    case noRecipes          = "No recipe could be find. Please change your ingredients"
    case noIngredients      = "No ingredients was entered. Please insert at least one ingredient"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this recipe. Please try again."
    case alreadyInFavorites = "You already have that recipe in favorites !\nIt must be REALLY delicious !"
}

