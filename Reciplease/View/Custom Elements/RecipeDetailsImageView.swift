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
    
    init(recipe: Recipe?) {
        super.init(frame: .zero)
        configure()
        if let recipe = recipe {
            recipeTitle.text = recipe.label
            infoView.set(recipe: recipe)
            guard let imageURL = recipe.imageURL else { return }
            RecipeService.shared.fetchImageData(from: imageURL) { _data, success, _error in
                guard success,
                      _error == nil,
                      let data = _data else {
                    self.recipeImage.backgroundColor = CustomColor.gray
                    self.recipeImage.image = nil
                    return
                }
                self.recipeImage.image = UIImage(data: data)
            }
        } else {
            recipeTitle.text = Recipe.fakeRecipe.label
            infoView.set(recipe: Recipe.fakeRecipe)
        }
    }
    
    private func configure() {
        addSubview(recipeImage)
        addSubview(shadowView)
        addSubview(recipeTitle)
        addSubview(infoView)
        
        recipeImage.edgesToSuperview()
        
        recipeTitle.edgesToSuperview(excluding: .top)
        shadowView.edges(to: recipeTitle)
        
        infoView.topToSuperview(offset: 10)
        infoView.rightToSuperview(offset: -10)
    }
    
}
