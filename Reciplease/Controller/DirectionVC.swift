//
//  DirectionVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit
import TinyConstraints

class DirectionVC: UIViewController {
    
    // MARK: - Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    // MARK: - Views
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: .zero)
        v.backgroundColor = CustomColors.background.color
        v.frame = self.view.bounds
        v.contentSize = contentViewSize
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = CustomColors.background.color
        v.frame.size = contentViewSize
        return v
    }()
    
    let textView = TextView()
    
    let topView = UIView()
    let secondView = UIView()

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Directions"
        setupScrollView()
    }
    
    
    // MARK: - Private methods
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(textView)
        scrollView.edgesToSuperview()
        textView.edgesToSuperview(insets: .left(16) + .right(16))
    }
}
