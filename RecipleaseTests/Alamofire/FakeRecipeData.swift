//
//  FakeRecipeData.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 02/07/2021.
//

import Foundation

class FakeRecipeData {
    // Data from bundle
    static var translateCorrectData: Data  {
        let bundle = Bundle(for: FakeRecipeData.self)
        let url = bundle.url(forResource: "FakeRecipe", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    // erreur encodée
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    
    // We put a random URL because we only need the HTTP status code
    // reponse ok
    static let responseOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                            statusCode: 200,
                                            httpVersion: nil, headerFields: nil)
    
    // reponse not ok
    static let responseNotOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                               statusCode: 500,
                                               httpVersion: nil, headerFields: nil)
    // On simule le fait qu'il y a une erreur
    class CurrencyError: Error {}
    static let error = CurrencyError()
}
