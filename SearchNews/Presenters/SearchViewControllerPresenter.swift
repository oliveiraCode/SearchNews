//
//  SearchViewControllerPresenter.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//


import Alamofire

protocol SearchProtocol {
    func newsData(articles:Articles)
    func newsDataNotAvailable()
}

class SearchViewControllerPresenter {
    
    var delegate: SearchProtocol?
    
    private func setupURL(search:String) -> String{
        return ("\(NewsAPI.url)apiKey=\(NewsAPI.key)&q=\(search)").addPercentEncodingURL()
    }
    
    
    //MARK - Get data JSON
    func getNewsData(search:String){
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(setupURL(search: search),
                               method: .get,
                               parameters: nil,
                               encoding: JSONEncoding.default,
                               headers: nil).validate().responseJSON { response in
                                
                                switch(response.result) {
                                case .success:
                                    guard let dataFromJson = response.data else {return}
                                    do {
                                        let news = try JSONDecoder().decode(News.self, from: dataFromJson)
                                        if let article = news.articles.first{
                                            self.delegate?.newsData(articles: article)
                                        }else {
                                            self.delegate?.newsDataNotAvailable()
                                        }
                                    }catch {}
                                    break
                                case .failure:
                                    self.delegate?.newsDataNotAvailable()
                                    break
                                }
        }
    }
    
}
