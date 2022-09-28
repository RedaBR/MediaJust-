//
//  ResultViewController.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultList.delegate = self
        resultList.dataSource = self
        
    }
    var descript = DescriptionViewController()
    var resultViewModel = ResultViewModel.shared
}

extension ResultViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultViewModel.listResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = resultList
        var cell = UITableViewCell()
        
        let customCell = list?.dequeueReusableCell(withIdentifier: "CustomCellResult") as? CustomTableViewCell
        let result = resultViewModel.listResult[indexPath.row]
        customCell?.title.text = result.title
        cell = customCell!
        
        return cell
    }
    
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let result = resultViewModel.listResult[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DescriptionID") as? DescriptionViewController
        
        vc?.properties.titleModel = result.title!
        vc?.properties.urlModel = result.url!
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
}
