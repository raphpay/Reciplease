//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 18/06/2021.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeServiceTests: XCTestCase {
    
    // Error - OK
    // No data - Response ok -
    // Incorrect data - Response ok - OK
    // Correct data - Response not ok -
    // Correct data - Response ok - OK
    
    func testGivenCallbackFailed_WhenError_ThenRecipesAreNilAndErrorIsNotNil(){
        let fakeSession = FakeAFSession(data: nil, response: nil, error: RecipleaseError.unableToComplete)
        
        let expectation = XCTestExpectation(description: "Error")
        fakeSession.getRecipes() { _recipes, _error in
            XCTAssertNil(_recipes)
            XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCallbackFailed_WhenNoDataAndValidResponse_ThenRecipesAreNilAndErrorIsNotNil(){
        let fakeSession = FakeAFSession(data: nil,
                                        response: FakeResponseRecipeData.responseOK,
                                        error: nil)
        
        let expectation = XCTestExpectation(description: "No data")
        
        fakeSession.getRecipes { _recipes, _error in
            XCTAssertNil(_recipes)
            XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCallbackFailed_WhenIncorrectDataAndValidResponse_ThenRecipesAreNilAndErrorIsNotNil(){
        let fakeSession = FakeAFSession(data: FakeResponseRecipeData.recipeIncorrectData,
                                        response: FakeResponseRecipeData.responseOK,
                                        error: nil)
        
        let expectation = XCTestExpectation(description: "Incorrect Data")
        
        fakeSession.getRecipes { _recipes, _error in
            XCTAssertNil(_recipes)
            XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCallbackFailed_WhenCorrectDataAndInvalidResponse_ThenRecipesAreNilAndErrorIsNotNil(){
        let fakeSession = FakeAFSession(data: FakeResponseRecipeData.recipeCorrectData,
                                        response: FakeResponseRecipeData.responseNotOK,
                                        error: nil)
        
        let expectation = XCTestExpectation(description: "Invalid Response")
        
        fakeSession.getRecipes { _recipes, _error in
            XCTAssertNil(_recipes)
            XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCallbackSucceed_WhenCorrectDataAndValidResponse_ThenRecipesAreNilAndErrorIsNotNil(){
        let fakeSession = FakeAFSession(data: FakeResponseRecipeData.recipeCorrectData,
                                        response: FakeResponseRecipeData.responseOK,
                                        error: nil)
        
        let expectation = XCTestExpectation(description: "Success")
        
        fakeSession.getRecipes { _recipes, _error in
            XCTAssertNotNil(_recipes)
            XCTAssertNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - From Kévin
    // TODO: To delete
    func testGivenCallbackFailed_WhenError_ThenSuccessIsFalseAndTextIsNil(){
        // Given
        //        let fakeSession = TranslateURLSessionFake(data: nil, response: nil, error: FakeTranslationResponseData.error)
        //        let translationService = TranslationService(session: fakeSession)
        //
        //        // When
        //        let expectation = XCTestExpectation(description: "Error")
        //        translationService.getTranslation(baseText: FakeTranslationResponseData.baseText, targetLanguage: .french) { (success, text) in
        //            // Then
        //            XCTAssertFalse(success)
        //            XCTAssertNil(text)
        //            expectation.fulfill()
        //        }
        //        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
}
