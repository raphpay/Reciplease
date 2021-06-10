//
//  DirectionVC.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit
import WebKit
import TinyConstraints

class DirectionVC: UIViewController {
    
    // MARK: - Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    var webView: WKWebView!
    var recipe: Recipe?

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Directions"
        
        guard let recipe = recipe,
              let url = recipe.url else {
            // TODO: Setup an empty controller
            print("no url or recipe")
            return
        }
        print(url)
//        let appleURL = URL(string: "https://www.apple.com/fr")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.navigationDelegate = self
        view = webView
    }
}

extension DirectionVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // TODO: Setup an empty controller
        guard let recipe = recipe,
              let url = recipe.url else { return }
        UIApplication.shared.open(url)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("ok")
    }
}
