//
//  IngredientsTextField.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class IngredientsTextField: UITextField {
    
    let searchIcon = IconView(image: Icon.searchPlaceholder)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        layer.cornerRadius          = 5
        backgroundColor             = CustomColors.textField.color
        returnKeyType               = .done
        textColor                   = .white
        attributedPlaceholder       = NSAttributedString(string: "Lemon, cheese, sausages...",
                                                         attributes: [NSAttributedString.Key.foregroundColor: CustomColors.placeholder.color])
        
        addSubview(searchIcon)
        searchIcon.centerYToSuperview()
        searchIcon.leftToSuperview(offset: 10)
        searchIcon.width(18)
        searchIcon.height(18)
    }
    

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0))
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0))
    }
}
