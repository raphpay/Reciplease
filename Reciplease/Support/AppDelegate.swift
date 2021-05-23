//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Raphaël Payet on 05/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = createTabBarController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let searchVC = createNavC(tabBarTitle: "Search", image: UIImage(named: Icon.search.rawValue)!)
        let favoritesVC = createNavC(tabBarTitle: "Favorites",
                                     image: UIImage(named: Icon.star.rawValue)!,
                                     tag: 1)
        tabBarController.viewControllers = [searchVC, favoritesVC]
        tabBarController.tabBar.tintColor = CustomColors.openClassrooms.color
        return tabBarController
    }
    
    private func createNavC(title: String = "Reciplease",
                            tabBarTitle: String = "Reciplease",
                            image: UIImage = UIImage(named: Icon.star.rawValue)!,
                            tag: Int = 0) -> UINavigationController {
        let vc = SearchVC()
        vc.title = title
        vc.tabBarItem = UITabBarItem(title: tabBarTitle,
                                           image: image,
                                           tag: tag)
        let navC = UINavigationController(rootViewController: vc)
        return navC
    }

}

