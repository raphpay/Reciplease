//
//  SearchVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit
import TinyConstraints

class SearchVC: UIViewController {
    // TODO: Refactor the views inside a big view: maybe use protocols ?
    // MARK: - Properties
    let padding = CGFloat(16)
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    let mockRecipes = ["Carry", "Burger", "Frites", "Dessert"]
    
    // MARK: - Views
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
        return view
    }()
    
    lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let questionLabel = Label(text: "What's in your fridge ?", textColor: CustomColors.green.color, bold: true)
    let ingredientsTextField = IngredientsTextField()
    let addButton: UIButton = {
        let b = UIButton()
        b.setImage(Icon.plus, for: .normal)
        return b
    }()

    let bottomContainerTitle = Label(text: "Your ingredients", alignment: .left, bold: true)
    let clearButton = Button(backgroundColor: CustomColors.gray.color, title: "Clear")
    let ingredientsTextView = TextView()
    
    // MARK: - Actions
    @objc func searchRecipes() {
        let tableVC = TableViewController()
        tableVC.recipes = Recipe.mockRecipes
        navigationController?.pushViewController(tableVC, animated: true)
    }
    
    @objc func addIngredient() {
        guard let text = ingredientsTextField.text else { return }
        addIngredientToTextView(text: text)
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTextField()
        setupViews()
        view.backgroundColor = UIColor(named: "Background")
        // TODO: Change colors in here
    }
    
    
    // MARK: - Private methods
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
        
        scrollView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        scrollView.bottomToTop(of: searchButton, offset: -padding)
        scrollView.addSubview(containerView)
        
        searchButton.height(60)
        searchButton.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding) + .bottom(10), usingSafeArea: true)
        searchButton.addTarget(self, action: #selector(searchRecipes), for: .touchUpInside)
        
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
        topContainerView.height(80)
        
        topContainerView.addSubview(questionLabel)
        topContainerView.addSubview(ingredientsTextField)
        topContainerView.addSubview(addButton)
        
        questionLabel.edgesToSuperview(excluding: .bottom, insets: .top(5))
        
        ingredientsTextField.topToBottom(of: questionLabel, offset: 10)
        ingredientsTextField.leftToSuperview()
        ingredientsTextField.rightToLeft(of: addButton, offset: -5)
        ingredientsTextField.height(35)
        
        addButton.centerY(to: ingredientsTextField)
        addButton.rightToSuperview()
        addButton.height(44)
        addButton.width(44)
        
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
    }
    
    private func setupBottomContainer() {
        bottomContainerView.topToBottom(of: topContainerView, offset: padding)
        bottomContainerView.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding))
        
        bottomContainerView.addSubview(bottomContainerTitle)
        bottomContainerView.addSubview(clearButton)
        bottomContainerView.addSubview(ingredientsTextView)
        
        bottomContainerTitle.edgesToSuperview(excluding: .bottom)
        
        clearButton.topToSuperview()
        clearButton.rightToSuperview(offset : -10)
        clearButton.height(30)
        clearButton.width(80)
        
        ingredientsTextView.topToBottom(of: bottomContainerTitle, offset: 5)
        ingredientsTextView.edgesToSuperview(excluding: .top)
    }
}

