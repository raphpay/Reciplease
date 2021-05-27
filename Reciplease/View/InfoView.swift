//
//  InfoView.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit
import TinyConstraints

class InfoView: UIView {
    
    // MARK: - Properties
    var calories: Int = 0
    var cookTime: Int = 0
    
    // MARK: - Views

    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColors.background.color
        v.layer.cornerRadius = 5
        return v
    }()
    
    let caloriesView = DetailsInfoView(icon: .bolt, text: "kCal")
    let timeView = DetailsInfoView(icon: .clock, text: "min")
    
    let padding = CGFloat(6)
    let height  = CGFloat(60)
    let width   = CGFloat(95)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // TODO: To be checked with API
    init(calories: Int, time: Int) {
        super.init(frame: .zero)
        self.calories = calories
        self.cookTime = time
        configure()
    }
    
    
    private func configure() {
        addSubview(containerView)
        containerView.addSubview(caloriesView)
        containerView.addSubview(timeView)
        
        containerView.edgesToSuperview()
        
        caloriesView.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: padding, left: padding, bottom: 0, right: padding))
        
        timeView.edgesToSuperview(excluding: .top, insets: TinyEdgeInsets(top: 0, left: padding, bottom: padding, right: padding))
        
        containerView.height(height)
        containerView.width(width)
        
        caloriesView.label.text = "\(calories)kCal"
        timeView.label.text = "\(cookTime)min"
    }

    func set(recipe: Recipe) {
        self.calories = recipe.calories
        self.cookTime = recipe.cookTime
        caloriesView.label.text = "\(recipe.calories)kCal"
        timeView.label.text = "\(recipe.cookTime)min"
    }
}
