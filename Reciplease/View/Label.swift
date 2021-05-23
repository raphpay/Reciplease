//
//  TitleLabel.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String = "",
         textColor: UIColor = .white,
         alignment: NSTextAlignment = .left,
         fontSize: CGFloat = 30) {
        super.init(frame: .zero)
        self.text           = text
        self.textColor      = textColor
        self.textAlignment  = alignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

