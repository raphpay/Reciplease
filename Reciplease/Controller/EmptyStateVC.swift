//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit
import TinyConstraints

class EmptyStateVC: UIViewController {
    
    let emptyStateImage = BackgroundImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        view.addSubview(emptyStateImage)
        emptyStateImage.edgesToSuperview()
    }
}
