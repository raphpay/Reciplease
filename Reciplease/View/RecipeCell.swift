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
    
    let infoView = InfoView(calories: 200, time: 50)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TODO: Refactor the banner process
    private func setupViews() {
        backgroundColor = CustomColors.background.color
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
        cellDescription.topToBottom(of: cellTitle)
        
        infoView.bottomToSuperview(offset: -padding)
        infoView.leftToSuperview(offset: padding)
    }
    
    // TODO: Configure with a recipe object
    func set(title: String) {
        cellTitle.text = title
    }
    
    
}
