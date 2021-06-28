//
//  AlamofireService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 26/06/2021.
//

import Foundation
import Alamofire

public enum NetworkRequestError: Error {
    case statusCode(Int)
    case serializationError(Error?)
}

public protocol NetworkRequest {
//    func getDataFrom(url : URL?, completion: @escaping (_ data: Data?,_ error: RecipleaseError?) -> Void)
    func get<DataType: Codable>(with dict: [String: Any], completion: @escaping (DataType?, Error?) -> Void)
}


class AlamofireService: NetworkRequest {
//    func getDataFrom(url: URL?, completion: @escaping (_ data: Data?,_ error: RecipleaseError?) -> Void) {
//        guard let url = url else {
//            completion(nil, .invalidURL)
//            return
//        }
//        
//        AF.request(url).validate().responseData { response in
//            guard let data = response.data else {
//                completion(nil, .invalidResponse)
//                return
//            }
//            
//            completion(data, nil)
//        }
//    }
    
    func get<DataType>(with dict: [String : Any], completion: @escaping (DataType?, Error?) -> Void) where DataType : Decodable, DataType : Encodable {
        //
    }
}



