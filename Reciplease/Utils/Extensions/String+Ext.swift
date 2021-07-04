//
//  String+Ext.swift
//  Reciplease
//
//  Created by Raphaël Payet on 04/07/2021.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
