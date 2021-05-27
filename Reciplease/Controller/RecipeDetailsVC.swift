//
//  RecipeDetailsVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    let recipeImage = RecipeDetailsImageView()

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private methods
    private func configureViewController() {
        view.backgroundColor = CustomColors.background.color
        view.addSubview(recipeImage)
        
        recipeImage.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        recipeImage.height(250)
    }
}
