//
//  TextView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class TextView: UITextView {
    
    static let placeholder = "Nothing in the fridge for the moment.\nPlease enter some ingredients !"
    var fontSize = CGFloat(20)
    var alignment = NSTextAlignment.left
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment: NSTextAlignment = .left, fontSize: CGFloat = 20) {
        super.init(frame: .zero, textContainer: .none)
        contentInsetAdjustmentBehavior  = .automatic
        self.alignment                  = alignment
        self.fontSize                   = fontSize
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isEditable      = false
        isSelectable    = true
        backgroundColor = .clear
        textColor       = .white
        textAlignment   = alignment
        text            = TextView.placeholder
        font            = UIFont.systemFont(ofSize: fontSize)
    }
}
