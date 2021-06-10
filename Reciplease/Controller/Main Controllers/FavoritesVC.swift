//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private var shouldShowEmptyState = false
    let tableVC     = TableViewController()
    let emptyVC     = EmptyStateVC()

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let favorites = RecipeService.shared.favorites
        if favorites.isEmpty {
            shouldShowEmptyState = true
            addChildVC(vc: emptyVC)
        } else {
            shouldShowEmptyState = false
            tableVC.recipes = favorites
            addChildVC(vc: tableVC)
        }
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = CustomColor.background
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
