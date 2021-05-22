//
//  SearchVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    
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
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: 10).isActive = true
        scrollView.addSubview(containerView)
        
        searchButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95).isActive = true
        
        setupContainer(containerView)
    }
    
    private func setupScrollView() {
        
        
        
        
        
    }
    
    public func setupContainer(_ container: UIView) {
        
    }


}

