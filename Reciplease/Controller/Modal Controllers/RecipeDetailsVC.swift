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
    
    let informationTitle    = Label(text: "Ingredients", fontSize: 22, bold: true)
    let informationTextView = TextView(fontSize: 16)
    let directionButton        = Button(backgroundColor: CustomColor.green, title: "Get directions")
    
    
    // MARK: - Actions
    @objc func addToFavorites() {
        RecipeService.shared.addToFavorites(recipe: recipe) { success, _error in
            guard success,
                  _error == nil else {
                self.presentAlert(title: RecipleaseError.title.rawValue, message: _error!.rawValue)
                return
            }
        }
    }
    
    @objc func directionButtonTapped() {
        guard let recipe = recipe,
              let url = recipe.url else {
            presentAlert(title: "Oups", message: "Couldn't load the recipe's directions.\nPlease try again later")
            return
        }
        // TODO: Remove the direction VC if this is validated
        UIApplication.shared.open(url)
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.star, style: .done, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem?.tintColor = CustomColor.background
        
        view.addSubview(recipeImage)
        view.addSubview(scrollView)
        view.addSubview(directionButton)
        
        scrollView.addSubview(containerView)
        recipeImage.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        recipeImage.height(250)
        
        scrollView.bottomToTop(of: directionButton)
        scrollView.leftToSuperview()
        scrollView.rightToSuperview()
        scrollView.topToBottom(of: recipeImage)
        setupContainerView()
        
        directionButton.edgesToSuperview(excluding: .top,
                                      insets: .left(padding) + .right(padding) + .bottom(padding),
                                      usingSafeArea: true)
        directionButton.height(60)
        directionButton.addTarget(self, action: #selector(directionButtonTapped), for: .touchUpInside)
    }
    
    
    private func setupContainerView() {
        containerView.addSubview(informationTitle)
        containerView.addSubview(informationTextView)
        
        informationTitle.edgesToSuperview(excluding: .bottom, insets: .left(padding) + .right(padding) + .top(padding))
        informationTextView.edgesToSuperview(excluding: .top, insets: .left(padding) + .right(padding))
        informationTextView.topToBottom(of: informationTitle)
    }
    
    
    private func setTextView() {
        guard let recipe = recipe,
              let ingredients = recipe.ingredients else { return }
        for object in ingredients {
            guard let ingredient = object as? Ingredient,
                  let text = ingredient.text else { return }
            informationTextView.text += "\n\(text)"
        }
    }
}
