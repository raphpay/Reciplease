
//
//  AlamofireServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import XCTest
@testable import Reciplease

class AlamofireServiceTests: XCTestCase {
    
    let fakeURL = URL(string: FakeAlamofireData.apiURLString)
    
    // MARK: - Create URL
    func testGivenIngredientAreRiceAndChicken_WhenCreatingURL_ThenURLIsNotNil() {
        let alamofireService = AlamofireNetworkRequest.shared
        let url = alamofireService.createURL(with: FakeAlamofireData.ingredients)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, FakeAlamofireData.apiURLString)
    }
    
    func testGivenIngredientsAreEmpty_WhenCreatingURL_ThenURLIsNil() {
        let alamofireService = AlamofireNetworkRequest.shared
        let url = alamofireService.createURL(with: [])
        XCTAssertNil(url)
    }
    
    
    // MARK: - Get response
    func testGivenGettingDictionnary_WhenDataAndResponseAreCorrect_ThenResultIsNotNil() {
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.correctData,
                                                  response: FakeAlamofireData.responseOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
            XCTAssertNotNil(_dict)
            XCTAssertNil(_error)
        }
    }
    
    func testGivenGettingDictionnary_WhenDataIsIncorrect_ThenResultIsNil() {
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.incorrectData,
                                                    response: FakeAlamofireData.responseOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
            XCTAssertNil(_dict)
            XCTAssertNotNil(_error)
        }
    }
    
    func testGivenGettingDictionnary_WhenError_ThenResultIsNil() {
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseOK, error: FakeAlamofireData.error)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
        }
    }
    
    func testGivenGettingDictionnary_WhenNoData_ThenResultIsNil() {
        let fakeNetworkService = FakeNetworkRequest(data: nil, response: FakeAlamofireData.responseOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
        }
    }
    
    func testGivenGettingDictionnary_WhenIncorrectResponse_ThenResultIsNil() {
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseNotOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
        }
    }
    
    // MARK: - Get Recipe Objetcs
    func testGivenGettingRecipesObject_WhenCorrectDictionnary_ThenRecipesAreNotNil() {
        let alamofireService = AlamofireNetworkRequest.shared
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
            let recipes = alamofireService.getRecipeObjects(from: _dict)
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?.count, 2)
        }
    }
    
    func testGivenGettingRecipeObjects_WhenIncorrectDictionnary_ThenRecipesAreNil() {
        let alamofireService = AlamofireNetworkRequest.shared
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.incorrectData, response: FakeAlamofireData.responseOK, error: nil)
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
            let recipes = alamofireService.getRecipeObjects(from: _dict)
            XCTAssertNil(recipes)
        }
    }
}
