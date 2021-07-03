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
        imageView.image = nil
        imageView.backgroundColor = CustomColor.gray
        return imageView
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView()
        ac.translatesAutoresizingMaskIntoConstraints = false
        return ac
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
    
    init(recipe: RecipeObject?) {
        super.init(frame: .zero)
        configure()
        set(recipe: recipe)
    }
    
    private func configure() {
        addSubview(recipeImage)
        addSubview(activityIndicator)
        addSubview(shadowView)
        addSubview(recipeTitle)
        addSubview(infoView)
        
        recipeImage.edgesToSuperview()
        
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
        
        recipeTitle.edgesToSuperview(excluding: .top)
        shadowView.edges(to: recipeTitle)
        
        infoView.topToSuperview(offset: 10)
        infoView.rightToSuperview(offset: -10)
    }
    
    private func set(recipe: RecipeObject?) {
        if let recipe = recipe {
            recipeTitle.text = recipe.label
            infoView.set(recipe: recipe)
            guard let imageURL = recipe.imageURL else { return }
            AlamofireNetworkRequest.shared.fetchImage(from: imageURL) { _data, _error in
                self.activityIndicator.stopAnimating()
                guard _error == nil else { return }
                guard let data = _data else { return }
                DispatchQueue.main.async {
                    self.recipeImage.image = UIImage(data: data)
                }
            }
        } else {
            recipeTitle.text = RecipeObject.mockRecipe.label
            infoView.set(recipe: RecipeObject.mockRecipe)
        }
    }
    
}
