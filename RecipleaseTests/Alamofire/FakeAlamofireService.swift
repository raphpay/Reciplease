//
//  FakeAlamofireService.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation
import UIKit
import Reciplease


class FakeNetworkRequest : NetworkRequest {
    
    
    
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    static let shared = FakeNetworkRequest()
    private init() {
        self.data       = nil
        self.response   = nil
        self.error      = nil
    }
    
    
    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data       = data
        self.response   = response
        self.error      = error
    }
    
    
    
    func getResponse(from url: URL?, completion: @escaping ([String : Any]?, NetworkRequestError?) -> Void) {
        guard error == nil else {
            completion(nil, .serializationError(error!))
            return
        }
        
        guard let data = data else {
            completion(nil, .incorrectData)
            return
        }
        
        guard let response = response,
              response.statusCode == 200 else {
            completion(nil, .incorrectResponse)
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else {
            completion(nil, .incorrectData)
            return
        }
        
        completion(json, nil)
    }
    
    func fetchImage(from url: URL?, completion: @escaping (UIImage?, NetworkRequestError?) -> Void) {
        guard error == nil else {
            completion(nil, .serializationError(error!))
            return
        }

        guard let response = response,
              response.statusCode == 200 else {
            completion(nil, .incorrectResponse)
            return
        }

        guard let data = data else {
            completion(nil, .incorrectData)
            return
        }

        guard let image = UIImage(data: data) else {
            completion(nil, .incorrectData)
            return
        }

        completion(image, nil)
    }
}
