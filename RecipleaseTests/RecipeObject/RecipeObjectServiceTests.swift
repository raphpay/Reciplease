//
//  RecipeObjectServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 28/06/2021.
//

import XCTest
@testable import Reciplease

class RecipeObjectServiceTests: XCTestCase {
    
    let service = RecipeObjectService.shared
    
    func testGivenIncorrectDict_WhenTransformingToRecipeObject_ThenRecipeIsNotNil() {
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
}
