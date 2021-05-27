//
//  TextView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class TextView: UITextView {
    
    var textFont = UIFont.systemFont(ofSize: 30)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment: NSTextAlignment = .left, fontSize: CGFloat = 30) {
        super.init(frame: .zero, textContainer: .none)
        contentInsetAdjustmentBehavior = .automatic
        textAlignment                  = alignment
        font                           = UIFont.systemFont(ofSize: fontSize)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isEditable      = false
        isSelectable    = true
        backgroundColor = .clear
        textColor       = .white
//        font            = textFont
        text = "- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n"
    }
}
