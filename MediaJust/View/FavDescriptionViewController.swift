//
//  FavDescriptionViewController.swift
//  MediaJust
//
//  Created by Reda on 02/10/2022.
//

import UIKit
import WebKit
// MARK: - Descriptions Favorites
class FavDescriptionViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var titleFavDescript: UILabel!
    @IBOutlet weak var webViewFavDescript: WKWebView!
    @IBAction func deleteFav(_ sender: UIButton) {
       deleteFavorites()
        CoreDataStack.sharedInstance.delete(articleToDelete: article)
        sender.imageView?.image = UIImage(named: "heart")
    }
    let properties = ResultViewModel.shared
    var article = Article()

    func deleteFavorites () {
        CoreDataStack.sharedInstance.getPropertieWithTitle(title: properties.titleModel) { (articleToDelete) in
            article = articleToDelete.first!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webViewFavDescript.uiDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleFavDescript.text = properties.titleModel
        let url = URL(string: properties.urlModel)
        let request = URLRequest(url: url!)
        webViewFavDescript.load(request)
    }
}
