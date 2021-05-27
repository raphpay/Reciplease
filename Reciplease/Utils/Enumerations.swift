//
//  Images.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit

enum Images {
    static let emptyState = UIImage(named: "Empty-State")
    static let pizza = UIImage(named: "pizza")
}

enum Icon {
    static let star                 = UIImage(named: "icon-star")!
    static let search               = UIImage(named: "icon-magnifyingglass")!
    static let plus                 = UIImage(named: "plus")!
    static let searchPlaceholder    = UIImage(named: "icon-magnifyingglas-placeholder")!
    
    case bolt, clock
    
    var image: UIImage {
        switch self {
        case .bolt:
            return UIImage(named: "icon-bolt")!
        case .clock:
            return UIImage(named: "icon-deskclock")!
        }
    }
}

enum CustomColor {
    static let background = UIColor(named: "Background")!
    static let openclassrooms = UIColor(named: "OpenClassrooms")!
    static let gray = UIColor(named: "Gray")!
    static let green = UIColor(named: "Green")!
    static let placeholder = UIColor(named: "Placeholder")!
    static let textfield = UIColor(named: "TextFieldBackground")!
}
