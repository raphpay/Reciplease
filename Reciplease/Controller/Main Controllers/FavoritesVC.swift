//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Objects
    let tableVC     = TableViewController()
    let emptyVC     = EmptyStateVC()
    let coreDataStack = CoreDataStack.shared
    
    // MARK: - Properties
    var recipes: [Recipe] = []
    
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes.removeAll()
        
        let favorites = RecipeService(managedObjectContext: coreDataStack.viewContext,
                                           coreDataStack: coreDataStack).getRecipes()
        
        if let recipes = favorites,
           !recipes.isEmpty {
            // TODO: Add table vc
            print("====================\n recipes \(recipes) \(recipes.isEmpty) \n====================")
            print("====================\n TODO: add table vc \n====================")
        } else {
            addChildVC(emptyVC)
        }
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = CustomColor.background
        title = "Favorites"
    }
    
    private func addChildVC(_ vc: UIViewController) {
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
