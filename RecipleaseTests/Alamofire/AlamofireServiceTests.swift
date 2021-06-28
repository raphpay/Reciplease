
//
//  AlamofireServiceTests.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import XCTest
@testable import Reciplease

class AlamofireServiceTests: XCTestCase {
    var alamofireService: AlamofireService!
    
    override func setUp() {
        super.setUp()
        alamofireService = AlamofireService()
    }
    
    override func tearDown() {
        super.tearDown()
        alamofireService = nil
    }
    
    // MARK: - Get data
//    func testGivenGettingData_WhenURLIsOK_ThenDataIsNotNilAndErrorIsNil(){
//        alamofireService.getDataFrom(url: FakeAlamofireService.url) { _data, _error in
//            XCTAssertNotNil(_data)
//            XCTAssertNil(_error)
//        }
//    }
//
//    func testGivenGettingData_WhenURLIsNotOk_ThenDataIsNilAndErrorIsNotNil() {
//        alamofireService.getDataFrom(url: URL(string: "")) { _data, _error in
//            XCTAssertNil(_data)
//            XCTAssertNotNil(_error)
//        }
//    }
    
    func testGivenCallbackFailed_WhenNoDataAndIncorrectResponse_ThenErrorIsNotNil(){
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
    
    func testGivenCallbackSucceed_WhenCorrectDataAndResponse_ThenRecipesAreNotNil(){
    }
}
