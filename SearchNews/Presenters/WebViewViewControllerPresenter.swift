//
//  WebViewViewControllerPresenter.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import Foundation

protocol WebViewProtocol {
    func loadWebView(request:URLRequest)
    func loadWebViewNotAvailable()
}

class WebVewViewControllerPresenter {
    
    var delegate: WebViewProtocol?
    
    func loadWebView(articles: Articles?) {
        if let article = articles, let url = getURL(articles: article){
            let request = URLRequest(url: url)
            delegate?.loadWebView(request: request)
        } else {
            delegate?.loadWebViewNotAvailable()
        }
    }
    
    private func getURL(articles: Articles) -> URL?{
        if let urlArticle = articles.url, let url = URL(string: urlArticle) {
            return url
        }
        return nil
    }
}
