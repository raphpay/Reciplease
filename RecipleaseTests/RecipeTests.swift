//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 12/06/2021.
//

import XCTest
@testable import Reciplease

class RecipeTests: XCTestCase {
    
    #warning("TODO: Test also the properties ?")
    
    // MARK: - Recipe class
    func testGivenRecipeIsSomething_WhenTransformingToDataModel_ThenDataModelIsCreated(){
        // 1 Passer un recipe avec tous les paramètres
        // 2 Appeler la méthode
        // 3 Vérifier que le data model est dans le contexte ???
            // A : Tester avec un vrai recipe
            // B : Tester avec un faux recipe
    }
    
    func testGivenDict_WhenTransformingToRecipeObject_ThenRecipeIsCreated(){
        // 1 Créer un faux dictionnaire
        // 2 Appeler la méthode
        // 3 Vérifier que le recipe est bien créé
            // A : Tester avec un vrai dict
            // B : Tester avec une erreur dans le dict
            // C : Tester avec autre chose qu'un dict ( est-ce réellement possible ? )
    }
    
    // MARK: - RecipeDataModel class
    func testGivenRecipeIsADataModel_WhenTransformingToObject_ThenRecipeObjectIsReturned(){
        // 1 Récupérer un data model ???
        // 2 Appeler la méthode
        // 3 Vérifier que l'on reçoit un objet recipe
            // A : Tester avec un vrai data model
            // B : Tester avec un faux data model
    }
    
    
    // MARK: - Ingredients class
    func testGivenTextAndRecipe_WhenTransformingToIngredient_ThenIngreddientIsCreated(){
        // 1 Créer un faux texte
        // 2 Créer un faux recipe
        // 3 Appeler la méthode
        // 4 Vérifier que l'ingrédient est bien créé et ajouté au bon recipe
            // A : Tester avec des bonnes valeurs
            // B : Tester avec un mauvais string ( empty string )
            // C : Tester avec un mauvais recipe 
    }
}
