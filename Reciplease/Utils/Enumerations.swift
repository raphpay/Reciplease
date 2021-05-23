//
//  Images.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit

enum Images: String {
    case emptyState = "Empty-State"
    
    var image: UIImage {
        switch self {
        case .emptyState:
            return UIImage(named: Images.emptyState.rawValue)!
        }
    }
}

enum Icon: String {
    case star = "icon-star"
    case bolt = "icon-bolt"
    case clock = "icon-deskclock"
    case search = "icon-magnifyingglass"
}

enum CustomColors: String {
    case background     = "Background"
    case openClassrooms = "OpenClassrooms"
    case green          = "Green"
    case gray           = "Gray"
    
    private var red: CGFloat {
        switch self {
        case .background:
            return 48
        case .openClassrooms:
            return 106
        case .green:
            return 117
        case .gray:
            return 129
        }
    }
    
    private var blue: CGFloat {
        switch self {
        case .background:
            return 45
        case .openClassrooms:
            return 67
        case .green:
            return 158
        case .gray:
            return 129
        }
    }
    
    private var green: CGFloat {
        switch self {
        case .background:
            return 44
        case .openClassrooms:
            return 225
        case .green:
            return 112
        case .gray:
            return 129
        }
    }
    
    var color: UIColor {
        switch self {
        case .background:
            if #available(iOS 11.0, *) {
                return UIColor(named: CustomColors.background.rawValue)!
            } else {
                return UIColor(red: CustomColors.background.red,
                                               green: CustomColors.background.green,
                                               blue: CustomColors.background.blue,
                                               alpha: 1)
            }
        case .openClassrooms:
            if #available(iOS 11.0, *) {
                return UIColor(named: CustomColors.openClassrooms.rawValue)!
            } else {
                return UIColor(red: CustomColors.openClassrooms.red,
                                               green: CustomColors.openClassrooms.green,
                                               blue: CustomColors.openClassrooms.blue,
                                               alpha: 1)
            }
        case .green:
            if #available(iOS 11.0, *) {
                return UIColor(named: CustomColors.green.rawValue)!
            } else {
                return UIColor(red: CustomColors.green.red,
                                               green: CustomColors.green.green,
                                               blue: CustomColors.green.blue,
                                               alpha: 1)
            }
        case .gray:
            if #available(iOS 11.0, *) {
                return UIColor(named: CustomColors.gray.rawValue)!
            } else {
                return UIColor(red: CustomColors.gray.red,
                                               green: CustomColors.gray.green,
                                               blue: CustomColors.gray.blue,
                                               alpha: 1)
            }
        }
    }
}


