//
//  Images.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit

enum Images: String {
    case emptyState = "Empty-State"
}

enum Icon: String {
    case star = "icon-star"
    case bolt = "icon-bolt"
    case clock = "icon-deskclock"
    case search = "icon-magnifyingglass"
}

enum CustomColors: String {
    case background = "Background"
    case openClassrooms = "OpenClassrooms"
    case green = "Green"
    
    var red: CGFloat {
        switch self {
        case .background:
            return 48
        case .openClassrooms:
            return 106
        case .green:
            return 117
        }
    }
    
    var blue: CGFloat {
        switch self {
        case .background:
            return 45
        case .openClassrooms:
            return 67
        case .green:
            return 158
        }
    }
    
    var green: CGFloat {
        switch self {
        case .background:
            return 44
        case .openClassrooms:
            return 225
        case .green:
            return 112
        }
    }
}


