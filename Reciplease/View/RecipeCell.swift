//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    static let reuseID = "RecipeCell"
    
    let cellTitle = TitleLabel(text: "Hello World", fontSize: 20)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        backgroundColor = CustomColors.background.color
        addSubview(cellTitle)
        cellTitle.edgesToSuperview()
    }
    
    // TODO: Configure with a recipe object
    func set() {
        
    }
}
