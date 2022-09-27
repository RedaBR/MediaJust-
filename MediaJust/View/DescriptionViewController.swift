//
//  DescriptionViewController.swift
//  MediaJust
//
//  Created by Reda on 24/09/2022.
//

import UIKit
import WebKit

class DescriptionViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var titl: UILabel!
  
    @IBOutlet weak var webView: WKWebView!
    
    
    @IBAction func buttonFav(_ sender: UIButton) {
        let article = Article(context: CoreDataStack.sharedInstance.viewContext)
        article.url = properties.urlModel
        article.title = properties.titleModel
        
    }
    
    let properties = ResultViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titl.text = properties.titleModel
        let url = URL(string: properties.urlModel)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
}
