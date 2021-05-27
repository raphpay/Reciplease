//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private var shouldShowEmptyState = false
    let tableVC = TableViewController()
    let emptyVC = EmptyStateVC()
    
    let mockRecipes = ["Pizza", "Pasta", "Salad"]

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        tableVC.recipes = mockRecipes
        addChildVC(vc: tableVC)
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        view.backgroundColor = CustomColors.background.color
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
