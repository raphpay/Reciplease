//
//  RecipeDetailsVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    // MARK: - Views
    let recipeImage = RecipeDetailsImageView()
    
    // MARK: - Actions
    @objc func addToFavorites() {
        print("addToFavorites")
    }

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private methods
    private func configureViewController() {
        view.backgroundColor = CustomColors.background.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.star, style: .done, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem?.tintColor = CustomColors.background.color
        view.addSubview(recipeImage)
        
        recipeImage.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        recipeImage.height(250)
    }
}
