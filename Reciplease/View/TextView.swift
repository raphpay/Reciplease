//
//  TextView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class TextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment: NSTextAlignment = .left, fontSize: CGFloat = 30) {
        super.init(frame: .zero, textContainer: .none)
        self.contentInsetAdjustmentBehavior = .automatic
        self.textAlignment                  = alignment
        self.textColor                      = .white
        self.font                           = UIFont.systemFont(ofSize: fontSize)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isEditable      = false
        isSelectable    = true
        backgroundColor = .clear
        text = "- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n"
    }
}
