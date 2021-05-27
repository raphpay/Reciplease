//
//  EmptyState.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit
import TinyConstraints

class BackgroundImage: UIImageView {
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        image = Images.emptyState
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

}
