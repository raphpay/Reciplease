//
//  FakeAlamofireData.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 02/07/2021.
//

import Foundation

class FakeAlamofireData {
    // Data from bundle
    
    
    static var correctData: Data  {
        let bundle = Bundle(for: FakeAlamofireData.self)
        let url = bundle.url(forResource: "FakeRecipe", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static var correctImageData: Data {
        let bundle = Bundle(for: FakeAlamofireData.self)
        let url = bundle.url(forResource: "rice", withExtension: "jpg")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!

    // We put a random URL because we only need the HTTP status code
    static let responseOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                            statusCode: 200,
                                            httpVersion: nil, headerFields: nil)

    static let responseNotOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                               statusCode: 500,
                                               httpVersion: nil, headerFields: nil)
    
    static let ingredients  = ["Rice", "Chicken"]
    static let apiURLString = "https://api.edamam.com/search?&app_id=08b5ed9a&app_key=ad5b86fa2c4478bfc7c55184d216b14a&to=10&q=Rice,Chicken,"
    static let appleURL     = URL(string: "https://apple.com")!
    // On simule le fait qu'il y a une erreur
    class AlamofireError: Error {}
    static let error = AlamofireError()
}
