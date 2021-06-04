//
//  UIViewController+Ext.swift
//  OpenContact
//
//  Created by Raphaël Payet on 21/05/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

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
}
