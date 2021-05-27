//
//  Icon.swift
//  Reciplease
//
//  Created by Raphaël Payet on 24/05/2021.
//

import UIKit

class IconView: UIImageView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: UIImage) {
        super.init(frame: .zero)
        self.image = image
    }
    
    
    private func configure() {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }

}
