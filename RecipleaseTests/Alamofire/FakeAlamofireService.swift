//
//  FakeAlamofireService.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation
import Reciplease

struct FakeNetworkRequest : NetworkRequest {
    
    
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    static var url: URL {
        return URL(string: "https://www.apple.com")!
    }
    
//    func get<DataType>(with dict: [String : Any], completion: @escaping (DataType?, Error?) -> Void) where DataType : Decodable, DataType : Encodable {
//        guard let response = response, response.statusCode == 200 else {
//            return completion(nil, NetworkRequestError.statusCode(self.response?.statusCode ?? -1))
//        }
//        guard let data = data else {
//            return completion(nil, error)
//        }
//
//        do {
//            completion(try JSONDecoder().decode(DataType.self, from: data), nil)
//        } catch {
//            completion(nil, NetworkRequestError.serializationError(error))
//        }
//    }
    
    func request(url : URL, completion: (_ result: AFDataResponse<Any>?) -> Void) {
        guard let response = FakeRecipeData.responseOK else {
//            completion(nil)
            return
        }
        
        // Ici completion de DataResponse
        
        
        
        // il faut passer data, reponse et error
//        completion(DataResponse(request: URL, response: fakeResponse, data: Data, result: ))
    }
}
