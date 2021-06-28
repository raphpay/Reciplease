//
//  RecipeObjectServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 28/06/2021.
//

import XCTest
@testable import Reciplease

class RecipeObjectServiceTests: XCTestCase {
    
    func testGivenIncorrectDict_WhenTransformingToRecipeObject_ThenRecipeIsNotNil() {
        let service = RecipeObjectService.shared
        let recipe = service.transformFromDict(FakeRecipeObjectData.correctDict)
        
        let url = URL(string: "http://www.seriouseats.com/recipes/2008/04/essentials-how-to-cook-rice.html")
        let imageURL = URL(string: "https://www.edamam.com/web-img/b71/b716942f16e3e9490829f7da8dba509e.jpg")
        
        XCTAssertNotNil(recipe)
        XCTAssertEqual(recipe?.label, "Essentials: Rice")
        XCTAssertEqual(recipe?.calories, 3000.0)
        XCTAssertEqual(recipe?.cookTime, 0.0)
        XCTAssertEqual(recipe?.cuisineType, "indian")
        XCTAssertEqual(recipe?.url, url)
        XCTAssertEqual(recipe?.imageURL, imageURL)
        XCTAssertEqual(recipe?.ingredients, ["1 cup long-grain white rice"])
    }
    
    func testGivenCorrectDict_WhenTransformingToRecipeObject_ThenRecipeIsNotNil() {
        let service = RecipeObjectService.shared
        let recipe = service.transformFromDict(FakeRecipeObjectData.incorrectDict)
        
        XCTAssertNil(recipe)
        XCTAssertNil(recipe?.label)
        XCTAssertNil(recipe?.calories)
        XCTAssertNil(recipe?.cookTime)
        XCTAssertNil(recipe?.cuisineType)
        XCTAssertNil(recipe?.url)
        XCTAssertNil(recipe?.imageURL)
        XCTAssertNil(recipe?.ingredients)
    }
    
    func testGivenCorrectRecipeInCoreData_WhenTransformingToRecipeObject_ThenObjectIsNotNil() {
        let coreDataStack   = FakeCoreDataStack()
        let recipeService   = RecipeService(managedObjectContext: coreDataStack.viewContext, coreDataStack: coreDataStack)
        let service         = RecipeObjectService.shared
         
        let object = RecipeObject(id: UUID(), label: "Rice", cuisineType: "Chinese", ingredients: ["Ing1"], calories: 3000, cookTime: 20, url: FakeRecipeData.url, imageURL: FakeRecipeData.imageURL)
        let recipe = recipeService.addRecipeToFavorite(object)
        
        let newObject = service.transformFromCoreData(recipe: recipe)
        
        
        XCTAssertNotNil(newObject)
        XCTAssertEqual(newObject?.id, object.id)
        XCTAssertEqual(newObject?.label, object.label)
        XCTAssertEqual(newObject?.cuisineType, object.cuisineType)
        XCTAssertEqual(newObject?.ingredients, object.ingredients)
        XCTAssertEqual(newObject?.calories, object.calories)
        XCTAssertEqual(newObject?.cookTime, object.cookTime)
        XCTAssertEqual(newObject?.url, object.url)
        XCTAssertEqual(newObject?.imageURL, object.imageURL)
    }
    
    func testGivenNoRecipeInCoreData_WhenTransformingToRecipeObject_ThenObjectIsNIl() {
        let service         = RecipeObjectService.shared
        
        let newObject = service.transformFromCoreData(recipe: nil)
        
        XCTAssertNil(newObject)
        XCTAssertNil(newObject?.id)
        XCTAssertNil(newObject?.label)
        XCTAssertNil(newObject?.calories)
        XCTAssertNil(newObject?.cookTime)
        XCTAssertNil(newObject?.cuisineType)
        XCTAssertNil(newObject?.ingredients)
        XCTAssertNil(newObject?.url)
        XCTAssertNil(newObject?.imageURL)
    }
}
