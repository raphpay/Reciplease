//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
//    private var shouldShowEmptyState = false
    let tableVC     = TableViewController()
    let emptyVC     = EmptyStateVC()
    
    var recipes: [Recipe] = []

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes.removeAll()
        let favorites = RecipeDataModel.all
        
        if favorites.isEmpty {
            addChildVC(vc: emptyVC)
        } else {
            for dataModel in favorites {
                guard let recipe = dataModel.transformToObject() else { return }
                recipes.append(recipe)
            }
            tableVC.recipes = recipes
            tableVC.tableView.reloadData()
            addChildVC(vc: tableVC)
        }
    

    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = CustomColor.background
        title = "Favorites"
    }
    
    private func addChildVC(vc: UIViewController) {
        tableVC.willMove(toParent: nil)
        tableVC.view.removeFromSuperview()
        tableVC.removeFromParent()
        
        emptyVC.willMove(toParent: nil)
        emptyVC.view.removeFromSuperview()
        emptyVC.removeFromParent()
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: self)
    }
}
