//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit
import TinyConstraints

class RecipeCell: UITableViewCell {
    
    static let reuseID = "RecipeCell"
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = CustomColors.background.color
        v.layer.cornerRadius = 5
        return v
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Images.pizza
        return imageView
    }()
    
    let shadowView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.layer.opacity = 0.5
        return v
    }()
    
    let cellTitle = Label(text: "Hello World", fontSize: 20)
    let cellDescription = Label(text: "Description", fontSize: 16)
    
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
        
        containerView.addSubview(backgroundImage)
        containerView.addSubview(shadowView)
        containerView.addSubview(cellTitle)
        containerView.addSubview(cellDescription)
        
        containerView.topToSuperview(offset: 15)
        containerView.bottomToSuperview(offset: -15)
        containerView.leftToSuperview(offset: 16)
        containerView.rightToSuperview(offset: -16)
        
        backgroundImage.edgesToSuperview()
        
        shadowView.edgesToSuperview(excluding: .top)
        shadowView.height(50)
        
        cellDescription.edgesToSuperview(excluding: .top, insets: .left(5) + .right(5))
        cellTitle.bottomToTop(of: cellDescription)
        cellTitle.leftToSuperview(offset: 5)
        cellTitle.rightToSuperview(offset: -5)
        
        configureInfoView()
    }
    
    // TODO: Refactor with info from recipe
    private func configureInfoView() {
        containerView.addSubview(infoView)
        
        infoView.topToSuperview(offset: 5)
        infoView.rightToSuperview(offset: -5)
        infoView.height(60)
        infoView.width(95)
    }
    
    // TODO: Configure with a recipe object
    func set() {
        
    }
}
