//
//  WebViewController.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var webViewPresenter = WebVewViewControllerPresenter()
    var articles:Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewPresenter.delegate = self
        webview.allowsBackForwardNavigationGestures = true
        webview.navigationDelegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        setNavTitle()
        webViewPresenter.loadWebView(articles: articles)
    }

    private func setNavTitle() {
        if let article = articles, let source = article.source {
            self.navigationItem.title = source.name
        }
    }
    
    @IBAction func dismissPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

extension WebViewController: WebViewProtocol {
    func loadWebView(request: URLRequest) {
        webview.load(request)
    }
    
    func loadWebViewNotAvailable() {
        displayAlert(title: "Error", message: "This web page is not available", titleAlert: "OK")
    }
    
    //MARK - Alert Message
    private func displayAlert(title:String, message:String,titleAlert:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleAlert, style: .default, handler: nil))
        self.present(alert, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


