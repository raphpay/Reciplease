//
//  UIViewController+Ext.swift
//  OpenContact
//
//  Created by Raphaël Payet on 21/05/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

fileprivate var favoriteTextContainer: UIView = {
    let v = UIView()
    v.backgroundColor       = .black
    v.layer.cornerRadius    = 10
    return v
}()

fileprivate var favoriteText = Label(text: "Added to favorites !", alignment: .center, fontSize: 20)

extension UIViewController {
    
    func presentCustomAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentAlert(title: String? = "Oups !",
                      message: String? = "An error occured. Please try again later",
                      preferredStyle: UIAlertController.Style? = UIAlertController.Style.alert,
                      action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        if let action = action {
            alertController.addAction(action)
        } else {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        }
        self.present(alertController, animated: true)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = CustomColor.background
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
            var activityIndicator: UIActivityIndicatorView
            if #available(iOS 13.0, *) {
                activityIndicator = UIActivityIndicatorView(style: .white)
            } else {
                activityIndicator = UIActivityIndicatorView()
            }
            containerView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerInSuperview()
            
            activityIndicator.startAnimating()
        }
    }
    
    func dismissLoadingView() {
        containerView.removeFromSuperview()
        containerView = nil
    }
    
    func showFavoritesAlert() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        view.addSubview(favoriteTextContainer)
        
        favoriteTextContainer.centerInSuperview()
        favoriteTextContainer.height(50)
        favoriteTextContainer.width(200)
        
        favoriteTextContainer.addSubview(favoriteText)
        favoriteText.edgesToSuperview()
        
        containerView.backgroundColor = CustomColor.background
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.25, delay: 1.5) {
                    containerView.removeFromSuperview()
                    favoriteTextContainer.removeFromSuperview()
                    favoriteText.removeFromSuperview()
                    containerView = nil
                }
            }
        }

    }
}
