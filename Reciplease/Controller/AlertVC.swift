//
//  AlertVC.swift
//  OpenContact
//
//  Created by Raphaël Payet on 21/05/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView   = UIView()
    let titleLabel: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 20)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let messageLabel: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.purple
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor       = .white
        containerView.layer.cornerRadius    = 16
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

