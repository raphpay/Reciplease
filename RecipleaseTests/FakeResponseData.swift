//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 24/06/2021.
//

import Foundation

class FakeResponseRecipeData {
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseRecipeData.self)
        let url = bundle.url(forResource: "FakeRecipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let recipeIncorrectData = "erreur".data(using: .utf8)!
    
    // We put a random URL because we only need the HTTP status code
    static let responseOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                            statusCode: 200,
                                            httpVersion: nil, headerFields: nil)
    
    static let responseNotOK = HTTPURLResponse(url: URL(string: "https://apple.com")!,
                                               statusCode: 500,
                                               httpVersion: nil, headerFields: nil)
    // On simule le fait qu'il y a une erreur
    class RecipeError: Error {}
    static let error = RecipeError()
}
