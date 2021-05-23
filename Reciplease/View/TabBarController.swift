//
//  TabBarController.swift
//  Reciplease
//
//  Created by Raphaël Payet on 23/05/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private var shouldShowEmptyState = false

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
    }
    
    private func createTabBarController() {
        let searchVC = createNavC(vc: SearchVC(),
                                  tabBarTitle: "Search",
                                  image: UIImage(named: Icon.search.rawValue)!)
        let favoritesVC = createNavC(vc: shouldShowEmptyState ? EmptyStateVC() : TableViewController(),
                                     title: "Recipes",
                                     tabBarTitle: "Favorites",
                                     image: UIImage(named: Icon.star.rawValue)!,
                                     tag: 1)
        viewControllers = [searchVC, favoritesVC]
        UITabBar.appearance().tintColor = CustomColors.openClassrooms.color
    }
    
    private func createNavC(vc: UIViewController,
                            title: String = "Reciplease",
                            tabBarTitle: String = "Reciplease",
                            image: UIImage = UIImage(named: Icon.star.rawValue)!,
                            tag: Int = 0) -> UINavigationController {
        vc.title = title
        vc.tabBarItem = UITabBarItem(title: tabBarTitle,
                                           image: image,
                                           tag: tag)
        let navC = UINavigationController(rootViewController: vc)
        return navC
    }

}
