//
//  RecipeDetailsVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit
import SafariServices
import TinyConstraints

class RecipeDetailsVC: UIViewController {
    
    // MARK: - Properties
    lazy var contentViewSize    = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    var showDirections: Bool    = false
    let padding                 = CGFloat(16)
    var recipe: Recipe?
    
    // MARK: - Views
    lazy var recipeImage = RecipeDetailsImageView(recipe: recipe)
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: .zero)
        v.backgroundColor = CustomColor.background
        v.frame = self.view.bounds
        v.contentSize = contentViewSize
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = CustomColor.background
        v.frame.size = contentViewSize
        return v
    }()
    
    #warning("Add action")
    #warning("Change color")
    lazy var favoriteButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(Icon.star, for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return b
    }()
    
    let informationTitle    = Label(text: "Ingredients", fontSize: 22, bold: true)
    let informationTextView = TextView(fontSize: 18)
    let directionButton     = Button(backgroundColor: CustomColor.green, title: "Get directions")
    
    
    
    // MARK: - Actions
    @objc func addToFavorites() {
        guard let recipe = recipe else { return }
        RecipeService.shared.addToFavorites(recipe: recipe) { success, _error in
            
            guard success,
                  _error == nil else {
                self.presentAlert(title: RecipleaseError.title.rawValue, message: _error!.rawValue)
                return
            }
            
            // TODO: Show an alert when ok too
            self.showFavoritesAlert()
        }
    }
    
    @objc func directionButtonTapped() {
        guard let recipe = recipe,
              let url = recipe.url else {
            presentAlert(title: "Oups", message: "Couldn't load the recipe's directions.\nPlease try again later")
            return
        }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safari = SFSafariViewController(url: url, configuration: config)
        self.present(safari, animated: true)
    }
    

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setTextView()
    }
    
    
    // MARK: - Private methods
    private func setUpViewController() {
        title = "Reciplease"
        view.backgroundColor = CustomColor.background
        
        view.addSubview(scrollView)
        view.addSubview(directionButton)
        
        scrollView.addSubview(containerView)
        
        scrollView.edgesToSuperview(excluding: .bottom)
        scrollView.bottomToTop(of: directionButton)
        
        setupContainerView()
        
        directionButton.edgesToSuperview(excluding: .top,
                                      insets: .left(padding) + .right(padding) + .bottom(padding),
                                      usingSafeArea: true)
        directionButton.height(60)
        directionButton.addTarget(self, action: #selector(directionButtonTapped), for: .touchUpInside)
    }
    
    
    private func setupContainerView() {
        containerView.addSubview(favoriteButton)
        containerView.addSubview(recipeImage)
        containerView.addSubview(informationTitle)
        containerView.addSubview(informationTextView)
        
        favoriteButton.topToSuperview()
        favoriteButton.rightToSuperview(offset: -20)
        favoriteButton.height(44)
        favoriteButton.width(44)
        
        recipeImage.topToBottom(of: favoriteButton, offset: 10)
        recipeImage.leftToSuperview()
        recipeImage.rightToSuperview()
        recipeImage.height(250)
        
        informationTitle.topToBottom(of: recipeImage)
        informationTitle.leftToSuperview(offset: padding)
        informationTitle.rightToSuperview(offset: -padding)
        
        informationTextView.topToBottom(of: informationTitle)
        informationTextView.leftToSuperview(offset: padding)
        informationTextView.rightToSuperview(offset: -padding)
        informationTextView.bottomToSuperview()
    }
    
    
    private func setTextView() {
        guard let recipe = recipe,
              let ingredients = recipe.ingredients else { return }
        if informationTextView.text == TextView.placeholder {
            informationTextView.text = ""
        }
        for object in ingredients {
            informationTextView.text += "\n\(object)"
        }
    }
}
