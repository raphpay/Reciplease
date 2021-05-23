//
//  IngredientsTextField.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class IngredientsTextField: UITextField {
    
    let bottomLine: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(bottomLine)
        
        bottomLine.topToBottom(of: self, offset: 2)
        bottomLine.height(1)
        bottomLine.leftToSuperview()
        bottomLine.rightToSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
//        autocorrectionType          = .no
        returnKeyType               = .continue
        placeholder                 = "Lemon, cheese, sausages..."
    }

}
