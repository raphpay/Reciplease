//
//  RecipeDetailsImageView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class RecipeDetailsImageView: UIView {
    
    let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.pizza
        return imageView
    }()
    
    let recipeTitle = Label(text: "", alignment: .center, fontSize: 30)
    
    let shadowView: UIView = {
        let v = UIView()
        v.backgroundColor   = .black
        v.layer.opacity     = 0.5
        return v
    }()
    
    let infoView = InfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(recipe: Recipe) {
        super.init(frame: .zero)
        recipeTitle.text = recipe.label
        infoView.set(recipe: recipe)
        configure()
    }
    
    private func configure() {
        addSubview(recipeImage)
        addSubview(shadowView)
        addSubview(recipeTitle)
        addSubview(infoView)
        
        recipeImage.edgesToSuperview()
        
        shadowView.edgesToSuperview(excluding: .top)
        shadowView.height(50)
        
        recipeTitle.edgesToSuperview(excluding: .top, insets: .bottom(10))
        
        infoView.topToSuperview(offset: 10)
        infoView.rightToSuperview(offset: -10)
    }
    
}
