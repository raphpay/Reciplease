//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit
import TinyConstraints

class RecipeCell: UITableViewCell {
    
    static let reuseID  = "RecipeCell"
    let containerHeight = CGFloat(200)
    let padding         = CGFloat(5)
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.pizza
        return imageView
    }()
    
    let cellTitle = Label(text: "Pizza", fontSize: 20, bold: true)
    let cellDescription = Label(text: "Mozzarella, Basilic, Tomato", fontSize: 16)
    
    let infoView = InfoView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TODO: Refactor the banner process
    private func setupViews() {
        backgroundColor = CustomColor.background
        configureContainerView()
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        
        containerView.edgesToSuperview(excluding: .bottom, insets: .left(16) + .right(16))
        containerView.height(containerHeight)
        
        containerView.addSubview(recipeImage)
        containerView.addSubview(cellTitle)
        containerView.addSubview(cellDescription)
        recipeImage.addSubview(infoView)
        
        recipeImage.edgesToSuperview(excluding: .bottom)
        recipeImage.height(containerHeight - 40)
        
        cellTitle.topToBottom(of: recipeImage, offset: padding)
        cellTitle.leftToSuperview()
        cellTitle.rightToSuperview()
        cellDescription.topToBottom(of: cellTitle)
        
        infoView.bottomToSuperview(offset: -padding)
        infoView.leftToSuperview(offset: padding)
    }
    
    
    func set(recipe: RecipeObject) {
        guard let label = recipe.label,
              let cuisineType = recipe.cuisineType,
              let _ = recipe.imageURL else { return }
        
        cellTitle.text = label
        cellDescription.text = cuisineType
        
        
        
        #warning("Fetch image data")
        infoView.set(recipe: recipe)
    }
    
    
}
