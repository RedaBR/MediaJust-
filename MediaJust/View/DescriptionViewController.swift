//
//  DescriptionViewController.swift
//  MediaJust
//
//  Created by Reda on 24/09/2022.
//

import UIKit
import WebKit
// MARK: - Descriptions Result 
class DescriptionViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var titl: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var viewTitle: UIView!
    var isFav = false
    @IBAction func buttonFav(_ sender: UIButton) {
        // Verifiate if articl already in fav
            if isFav == true {
            presentAlert(with: "Already in favorites")
            }
        // Instantiate Article for init viewContext
            let article = Article(context: CoreDataStack.sharedInstance.viewContext)
            article.url = properties.urlModel
            article.title = properties.titleModel
            do {
        // Saving in CoreData and marking with if to avoid adding the same article
                try CoreDataStack.sharedInstance.viewContext.save()
                isFav = true
            } catch {
                presentAlert(with: error.localizedDescription)
            }
        sender.imageView?.image = UIImage(named: "heart.fill")
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
        viewTitle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewTitle.layer.shadowRadius = 2.0
        viewTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewTitle.layer.shadowOpacity = 2.0
    }
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
