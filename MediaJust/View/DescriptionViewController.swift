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
                
                             // contents could not be loaded
            
            
        
            // the URL was bad!
        
        
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            let textData : NSData = NSData(contentsOf: textUrl)!
//
//        DispatchQueue.main.async {
//
//            let textResult = String(data: textData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//            self.text.text = textResult as String?
//        }
//        }
            
    

//        DispatchQueue.global(qos: .userInitiated).async {
//        let imageData: NSData = NSData(contentsOf: imageUrl)!
//        // When from background thread, UI needs to be updated on main_queue
//        DispatchQueue.main.async {
//         let image = UIImage(data: imageData as Data)
//           self.mainImg.image = image
//    }
//    }
}
