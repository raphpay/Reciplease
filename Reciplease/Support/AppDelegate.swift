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
        let homeViewController = TabBarController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }
}

