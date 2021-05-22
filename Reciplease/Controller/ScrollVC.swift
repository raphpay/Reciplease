//
//  ScrollVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 22/05/2021.
//

import UIKit

class ScrollVC: UIViewController {
    //TODO: Save this code
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.frame.size = contentViewSize
        return v
    }()
    
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = "Scroll Top"
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Scroll Bottom"
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.addSubview(containerView)
        
        setupContainer(containerView)
        super.viewDidLoad()
        
    }
    public func setupContainer(_ container: UIView) {
        container.addSubview(labelOne)
        container.addSubview(labelTwo)
        
        labelOne.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        labelOne.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        labelOne.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        labelTwo.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        labelTwo.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        labelTwo.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
}
