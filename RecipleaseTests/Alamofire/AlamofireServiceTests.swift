
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
    let service = NetworkRequestService()
    let fakeService = NetworkRequestService()
    
    // MARK: - Get response
    func testGivenGettingDictionnary_WhenDataAndResponseAreCorrect_ThenResultIsNotNil() {
        fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.correctData,
                                                 response: FakeAlamofireData.responseOK, error: nil)
        let expectation = XCTestExpectation(description: "Success when getting recipes")
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
            XCTAssertNotNil(_dict)
            XCTAssertNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenGettingDictionnary_WhenDataIsIncorrect_ThenResultIsNil() {
        fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.incorrectData,
                                                 response: FakeAlamofireData.responseOK, error: nil)
        let expectation = XCTestExpectation(description: "Incorrect data when getting recipes")
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
            XCTAssertNil(_dict)
            XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenGettingDictionnary_WhenError_ThenResultIsNil() {
        fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseOK, error: FakeAlamofireData.error)
        let expectation = XCTestExpectation(description: "Error when getting recipes")
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
          expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenGettingDictionnary_WhenNoData_ThenResultIsNil() {
        fakeService.session = FakeNetworkRequest(data: nil, response: FakeAlamofireData.responseOK, error: nil)
        let expectation = XCTestExpectation(description: "No data when getting recipes")
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenGettingDictionnary_WhenIncorrectResponse_ThenResultIsNil() {
        let fakeNetworkService = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseNotOK, error: nil)
        let expectation = XCTestExpectation(description: "Incorrect response when getting recipes")
        fakeNetworkService.getResponse(from: fakeURL) { _dict, _error in
          XCTAssertNil(_dict)
          XCTAssertNotNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    // MARK: - Fetch Image
    
    func testGivenFetchingImage_WhenCorrectDataAndCorrectResponse_ThenImageDataIsReturned() {
            fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.correctImageData,
                                                     response: FakeAlamofireData.responseOK,
                                                     error: nil)

            let expectation = XCTestExpectation(description: "Success fetching image")
            fakeService.session.fetchImage(from: fakeURL) { _data, _error in
                XCTAssertNotNil(_data)
                XCTAssertNil(_error)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

        func testGivenFetchingImage_WhenError_ThenImageDataIsNotReturned() {
            fakeService.session = FakeNetworkRequest(data: nil, response: nil, error: FakeAlamofireData.error)

            let expectation = XCTestExpectation(description: "Error fetching image")
            fakeService.session.fetchImage(from: fakeURL) { _data, _error in
                XCTAssertNil(_data)
                XCTAssertNotNil(_error)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

        func testGivenFetchingImage_WhenNoData_ThenImageDataIsReturned() {
            fakeService.session = FakeNetworkRequest(data: nil, response: FakeAlamofireData.responseOK,
                                                     error: nil)

            let expectation = XCTestExpectation(description: "No data fetching image")
            fakeService.session.fetchImage(from: fakeURL) { _data, _error in
                XCTAssertNil(_data)
                XCTAssertNotNil(_error)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

        func testGivenFetchingImage_WhenIncorrectData_ThenImageDataIsReturned() {
            fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.incorrectData, response: FakeAlamofireData.responseOK,
                                                     error: nil)

            let expectation = XCTestExpectation(description: "Incorrect data fetching image")
            fakeService.session.fetchImage(from: fakeURL) { _data, _error in
                XCTAssertNil(_data)
                XCTAssertNotNil(_error)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }
    
    // MARK: - Create URL
    func testGivenIngredientAreRiceAndChicken_WhenCreatingURL_ThenURLIsNotNil() {
        let alamofireService = AlamofireService.shared
        let url = alamofireService.createURL(with: FakeAlamofireData.ingredients)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, FakeAlamofireData.apiURLString)
    }
    
    func testGivenIngredientsAreEmpty_WhenCreatingURL_ThenURLIsNil() {
        let alamofireService = AlamofireService.shared
        let url = alamofireService.createURL(with: [])
        XCTAssertNil(url)
    }
    
    
    
    
    // MARK: - Get Recipe Objetcs
    func testGivenGettingRecipesObject_WhenCorrectDictionnary_ThenRecipesAreNotNil() {
        fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.correctData, response: FakeAlamofireData.responseOK, error: nil)
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
            let recipes = self.fakeService.session.getRecipeObjects(from: _dict)
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?.count, 2)
        }
    }
    
    func testGivenGettingRecipeObjects_WhenIncorrectDictionnary_ThenRecipesAreNil() {
        fakeService.session = FakeNetworkRequest(data: FakeAlamofireData.incorrectData, response: FakeAlamofireData.responseOK, error: nil)
        fakeService.session.getResponse(from: fakeURL) { _dict, _error in
            let recipes = self.fakeService.session.getRecipeObjects(from: _dict)
            XCTAssertNil(recipes)
        }
    }
}
