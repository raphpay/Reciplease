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
    var recipe: RecipeObject?   = nil
    let coreDataStack           = CoreDataStack.shared
    lazy var recipeService      = RecipeDataModelService(managedObjectContext: coreDataStack.viewContext,
                                                coreDataStack: coreDataStack)
    
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
    
    lazy var starButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return b
    }()
    
    let informationTitle    = Label(text: "Ingredients", fontSize: 22, bold: true)
    let informationTextView = TextView(fontSize: 18)
    let directionButton     = Button(backgroundColor: CustomColor.green, title: "Get directions")
    
    
    
    // MARK: - Actions
    @objc func toggleFavorite() {
        guard let recipe = recipe else { return }
        if recipeService.isInFavorites(recipe: recipe) {
            recipeService.removeRecipeFromFavorites(recipe)
            setStarImage(favorite: false)
        } else {
            let _ = recipeService.addRecipeToFavorite(recipe)
            setStarImage(favorite: true)
        }
    }
    
    @objc func directionButtonTapped() {}
    

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setTextView()
        guard let recipe = recipe else { return }
        setStarImage(favorite: recipeService.isInFavorites(recipe: recipe))
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
        containerView.addSubview(starButton)
        containerView.addSubview(recipeImage)
        containerView.addSubview(informationTitle)
        containerView.addSubview(informationTextView)
        
        starButton.topToSuperview()
        starButton.rightToSuperview(offset: -20)
        starButton.height(44)
        starButton.width(44)
        
        recipeImage.topToBottom(of: starButton, offset: 10)
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
    
    private func setStarImage(favorite: Bool) {
        starButton.setImage(favorite ? Icon.favoriteStar : Icon.notFavoriteStar, for: .normal)
    }
}
