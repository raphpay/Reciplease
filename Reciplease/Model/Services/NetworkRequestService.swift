//
//  NetworkRequestService.swift
//  Reciplease
//
//  Created by Raphaël Payet on 12/07/2021.
//

import Foundation

class NetworkRequestService {
    static let shared = NetworkRequestService()
    init(session : NetworkRequest = AlamofireService.shared) {
        self.session = session
    }

    var session: NetworkRequest = AlamofireService.shared
}
