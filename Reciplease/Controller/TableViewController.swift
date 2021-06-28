//
//  TableViewController.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    var recipes: [RecipeObject] = []
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.backgroundColor = CustomColor.background
        
        title = "Recipes"
        
        tableView.backgroundColor = CustomColor.background
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID, for: indexPath) as? RecipeCell else {
            fatalError("Cannot dequeue cell for index path: \(indexPath)")
        }
        let recipe = recipes[indexPath.row]
        cell.set(recipe: recipe)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRecipe = recipes[indexPath.row]
        let destinationVC = RecipeDetailsVC()
        destinationVC.recipe = selectedRecipe
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
