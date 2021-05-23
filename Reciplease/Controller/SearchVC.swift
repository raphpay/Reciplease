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
    // TODO : Refactor color process
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: CustomColors.background.rawValue)
        } else {
            view.backgroundColor = UIColor(red: CustomColors.background.red,
                                           green: CustomColors.background.green,
                                           blue: CustomColors.background.blue,
                                           alpha: 1)
        }
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: CustomColors.background.rawValue)
        } else {
            view.backgroundColor = UIColor(red: CustomColors.background.red,
                                           green: CustomColors.background.green,
                                           blue: CustomColors.background.blue,
                                           alpha: 1)
        }
        v.frame.size = contentViewSize
        return v
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search for recipes", for: .normal)
        button.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            button.backgroundColor = UIColor(named: CustomColors.green.rawValue)
        } else {
            button.backgroundColor = UIColor(red: CustomColors.green.red,
                                           green: CustomColors.green.green,
                                           blue: CustomColors.green.blue,
                                           alpha: 1)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    // TODO: To be refactored
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's in your fridge ?"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var ingredientsTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Lemon, cheese, sausages"
        return textField
    }()
    
    lazy var textFieldLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        if #available(iOS 11.0, *) {
            button.backgroundColor = UIColor(named: CustomColors.green.rawValue)
        } else {
            button.backgroundColor = UIColor(red: CustomColors.green.red,
                                           green: CustomColors.green.green,
                                           blue: CustomColors.green.blue,
                                           alpha: 1)
        }
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
    }
    
    private func configureViewController() {
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: CustomColors.background.rawValue)
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            view.backgroundColor = UIColor(red: CustomColors.background.red,
                                           green: CustomColors.background.green,
                                           blue: CustomColors.background.blue,
                                           alpha: 1)
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
        topContainerView.addSubview(textFieldLine)
        topContainerView.addSubview(addButton)
        
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .top(5))
        
        ingredientsTextField.bottomToSuperview(offset: -30)
        ingredientsTextField.leftToSuperview(offset: 10)
        ingredientsTextField.rightToLeft(of: addButton, offset: -5)
        ingredientsTextField.height(25)
        
        textFieldLine.topToBottom(of: ingredientsTextField, offset: 2)
        textFieldLine.height(1)
        textFieldLine.leftToSuperview(offset: 10)
        textFieldLine.rightToLeft(of: addButton,offset: -5)
        
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

