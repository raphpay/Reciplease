//
//  FakeNetworkRequest.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 12/06/2021.
//

import Foundation
import Alamofire

class FakeAFSession: Session {
    var request: DataRequest?
    
    init(request: DataRequest) {
        self.request = request
    }
}
