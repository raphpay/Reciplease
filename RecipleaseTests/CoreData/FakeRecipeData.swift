//
//  FakeRecipeData.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 25/06/2021.
//

import Foundation
import Reciplease

class FakeRecipeData {
    static var url : URL {
        return URL(string: "https://www.apple.com")!
    }
    
    static var imageURL: URL {
        return URL(string: "https://www.openclassrooms.com")!
    }
}
