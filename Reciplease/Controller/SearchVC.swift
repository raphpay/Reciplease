//
//  SearchVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit
import TinyConstraints

class SearchVC: UIViewController {
    
    let padding = CGFloat(16)
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
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
    let searchButton  = Button(backgroundColor: CustomColors.green.color, title: "Search for recipes")
    lazy var topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let titleLabel = TitleLabel(text: "What's in your fridge ?", textColor: .black)
    let ingredientsTextField = IngredientsTextField()
    let addButton = Button(backgroundColor: CustomColors.green.color, title: "Add")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
    }
    
    private func configureViewController() {
        view.backgroundColor = CustomColors.background.color
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        view.addSubview(searchButton)
        
        scrollView.edgesToSuperview(excluding: .bottom, isActive: true, usingSafeArea: true)
        scrollView.bottomToTop(of: searchButton, offset: -padding)
        scrollView.addSubview(containerView)
        
        searchButton.height(75)
        searchButton.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding) + .bottom(10), usingSafeArea: true)
        setupContainer(containerView)
    }
    
    private func setupContainer(_ container: UIView) {
        container.addSubview(topContainerView)
        container.addSubview(bottomContainerView)
        setupTopContainer()
        setupBottomContainer()
    }
    
    private func setupTopContainer() {
        topContainerView.edgesToSuperview(excluding: .bottom, insets: .left(padding) + .right(padding))
        topContainerView.height(120)
        
        topContainerView.addSubview(titleLabel)
        topContainerView.addSubview(ingredientsTextField)
        topContainerView.addSubview(addButton)
        
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .top(5))
        
        ingredientsTextField.bottomToSuperview(offset: -30)
        ingredientsTextField.leftToSuperview(offset: 10)
        ingredientsTextField.rightToLeft(of: addButton, offset: -5)
        ingredientsTextField.height(25)
        
        addButton.rightToSuperview(offset: -10)
        addButton.bottomToSuperview(offset: -30)
        addButton.height(30)
        addButton.width(80)
    }
    private func setupBottomContainer() {
        bottomContainerView.topToBottom(of: topContainerView)
        bottomContainerView.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding))
    }
}

