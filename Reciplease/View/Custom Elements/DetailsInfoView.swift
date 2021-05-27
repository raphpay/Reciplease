//
//  DetailsInfoView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit
import TinyConstraints

class DetailsInfoView: UIView {

    let iconView = IconView()
    let label = Label(textColor: .white, alignment: .right, fontSize: 14)


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(icon: Icon, text: String) {
        super.init(frame: .zero)
        iconView.image = icon.image
        label.text = text
        configure()
    }
    
    
    private func configure() {
        addSubview(iconView)
        addSubview(label)
        
        iconView.topToSuperview()
        iconView.leftToSuperview()
        iconView.height(16)
        iconView.width(16)
        
        label.edgesToSuperview(excluding: .left)
    }

}
