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
//    func get<DataType: Codable>(with dict: [String: Any], completion: @escaping (DataType?, Error?) -> Void)
    func request(url : URL, completion: @escaping (_ result: AFDataResponse<Any>?) -> Void)
}


class AlamofireNetworkRequest: NetworkRequest {
    func request(url: URL, completion: @escaping (AFDataResponse<Any>?) -> Void) {
        AF.request(url).responseJSON { response in
            completion(response)
        }
    }
    
    
    
    
    
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
    
//    AFDataResponse a trouver
    
}
