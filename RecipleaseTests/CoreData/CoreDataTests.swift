//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 25/06/2021.
//

import XCTest
@testable import Reciplease

class CoreDataTests: XCTestCase {
    var recipeService: RecipeService!
    var coreDataStack: CoreDataStack!
    let object = RecipeObject(id: UUID(), label: "Rice", cuisineType: "Chinese", calories: 3000, cookTime: 20, url: FakeRecipeData.url, imageURL: FakeRecipeData.imageURL)
    
    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        recipeService = RecipeService(managedObjectContext: coreDataStack.viewContext,
                                      coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        recipeService = nil
        coreDataStack = nil
    }
    
    func testAddRecipeToFavorites() {
        
        let recipe = recipeService.addRecipeToFavorite(object)
        
        
        XCTAssertNotNil(recipe, "Recipe should not be nil")
        XCTAssertEqual(recipe.label, object.label)
        XCTAssertEqual(recipe.cuisineType, object.cuisineType)
        XCTAssertEqual(recipe.calories, object.calories)
        XCTAssertEqual(recipe.cookTime, object.cookTime)
        XCTAssertEqual(recipe.url, object.url)
        XCTAssertEqual(recipe.imageURL, object.imageURL)
        XCTAssertNotNil(recipe.id)
    }
    
    func testGetReports() {
        let newRecipe = recipeService.addRecipeToFavorite(object)
        let favorites = recipeService.getRecipes()
        
        XCTAssertNotNil(favorites)
        XCTAssertEqual(favorites?.isEmpty, false)
        XCTAssertTrue(newRecipe.id == favorites?.first?.id)
    }
    
    func testDeleteReport() {
        let newRecipe = recipeService.addRecipeToFavorite(object)
        
        var favorites = recipeService.getRecipes()
        XCTAssertTrue(favorites?.count == 1)
        XCTAssertTrue(newRecipe.id == favorites?.first?.id)
        
        recipeService.removeRecipeFromFavorites(object)
        
        favorites = recipeService.getRecipes()
        XCTAssertTrue(favorites?.isEmpty ?? false)
    }

}
