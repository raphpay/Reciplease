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
    // MARK: - Views
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
    
    let topContainerTitle = Label(text: "What's in your fridge ?", textColor: .black, alignment: .center, fontSize: 20)
    let ingredientsTextField = IngredientsTextField()
    let addButton = Button(backgroundColor: CustomColors.green.color, title: "Add")

    let bottomContainerTitle = Label(text: "Your ingredients", alignment: .left)
    let clearButton = Button(backgroundColor: CustomColors.gray.color, title: "Clear")

    // TODO: Find how to refactor this
    lazy var ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment                  = .left
        textView.textColor                      = .white
        textView.font                           = UIFont.systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable      = false
        textView.isSelectable    = true
        textView.backgroundColor = .clear
        textView.text = "- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n- Apple\n"
        return textView
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
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
        
        topContainerView.addSubview(topContainerTitle)
        topContainerView.addSubview(ingredientsTextField)
        topContainerView.addSubview(addButton)
        
        topContainerTitle.edgesToSuperview(excluding: .bottom, insets: .top(5))
        
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

