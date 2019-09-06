//
//  ViewController.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var searchPresenter = SearchViewControllerPresenter()
    var articles:Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPresenter.delegate = self
        setupUI()
    }
    
    private func setupUI(){
        btnSearch.setBorder(borderWidth: 1, borderColor: .black)
        btnSearch.setRadius(cornerRadius: 10, maskToBounds: true)
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        search(loaging: true)
        searchPresenter.getNewsData(search: tfSearch.text ?? "")
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowWebView",
            let navController = segue.destination as? UINavigationController,
            let destController = navController.topViewController as? WebViewController {
                destController.articles = self.articles
        }
    }
    
    private func search(loaging:Bool){
        if loaging {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = loaging
    }
    
    
}

extension SearchViewController:SearchProtocol{
    func newsData(articles: Articles) {
        search(loaging: false)
        self.articles = articles
        performSegue(withIdentifier: "segueShowWebView", sender: nil)
    }
    
    func newsDataNotAvailable() {
        search(loaging: false)
        displayAlert(title: "Warning", message: "Information not found", titleAlert: "OK")
    }
    
    //MARK - Alert Message
    private func displayAlert(title:String, message:String,titleAlert:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

