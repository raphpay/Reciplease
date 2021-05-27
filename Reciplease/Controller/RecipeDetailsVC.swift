//
//  RecipeDetailsVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit
import TinyConstraints

class RecipeDetailsVC: UIViewController {
    
    // MARK: - Properties
    lazy var contentViewSize    = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    var showDirections: Bool    = false
    let padding                 = CGFloat(16)
    
    // MARK: - Views
    let recipeImage = RecipeDetailsImageView()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: .zero)
        v.backgroundColor = CustomColors.background.color
        v.frame = self.view.bounds
        v.contentSize = contentViewSize
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = CustomColors.background.color
        v.frame.size = contentViewSize
        return v
    }()
    
    let informationTitle    = Label(text: "Ingredients", fontSize: 22, bold: true)
    let informationTextView = TextView(fontSize: 16)
    let switchButton        = Button(backgroundColor: CustomColors.green.color, title: "Get directions")
    
    // MARK: - Actions
    @objc func addToFavorites() {
        print("addToFavorites")
    }
    
    @objc func switchButtonTapped() {
        navigationController?.pushViewController(DirectionVC(), animated: true)
    }

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private methods
    private func configureViewController() {
        title = "Reciplease"
        view.backgroundColor = CustomColors.background.color
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.star, style: .done, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem?.tintColor = CustomColors.background.color
        
        view.addSubview(recipeImage)
        view.addSubview(scrollView)
        view.addSubview(switchButton)
        
        scrollView.addSubview(containerView)
        recipeImage.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        recipeImage.height(250)
        
        scrollView.bottomToTop(of: switchButton)
        scrollView.leftToSuperview()
        scrollView.rightToSuperview()
        scrollView.topToBottom(of: recipeImage)
        setupContainerView()
        
        switchButton.edgesToSuperview(excluding: .top,
                                      insets: .left(padding) + .right(padding) + .bottom(padding),
                                      usingSafeArea: true)
        switchButton.height(60)
        switchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
    }
    
    private func setupContainerView() {
        containerView.addSubview(informationTitle)
        containerView.addSubview(informationTextView)
        
        informationTitle.edgesToSuperview(excluding: .bottom, insets: .left(padding) + .right(padding))
        informationTextView.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding))
        informationTextView.topToBottom(of: informationTitle)
    }
}
