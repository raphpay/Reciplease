//
//  PositionVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit
import TinyConstraints

class PositionVC: UIViewController {
    
    let topView: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let scrollView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    let button: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(topView)
        view.addSubview(scrollView)
        view.addSubview(button)
        
        topView.edgesToSuperview(excluding: .bottom, insets: .left(16) + .right(16), usingSafeArea: true)
        topView.height(100)
        
        scrollView.leftToSuperview(offset: 16)
        scrollView.rightToSuperview(offset: -16)
        scrollView.topToBottom(of: topView, offset: 16)
        scrollView.bottomToTop(of: button, offset: -16)
        
        button.bottomToSuperview(offset: -16, usingSafeArea: true)
        button.leftToSuperview(offset: 16)
        button.rightToSuperview(offset: -16)
        button.height(75)
    }
}
