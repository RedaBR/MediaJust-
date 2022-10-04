//
//  FavoritesViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favList.delegate = self
        favList.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        backUpList.removeAll()
        getFetch()
    }
    
    var backUpList : [Article] = []
    var resultViewModel = ResultViewModel.shared
    
    func getFetch () {
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            favList.reloadData()
        }
    }
}

extension FavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = favList
        var cell = UITableViewCell()
        let customCell = list?.dequeueReusableCell(withIdentifier: "CustomFav") as! CustomFavTableViewCell?
        let result = backUpList[indexPath.row]
        customCell?.title.text = result.title
        cell = customCell!
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let result = backUpList[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavListID") as?FavDescriptionViewController
        
        vc?.properties.titleModel = result.title!
        vc?.properties.urlModel = result.url!
        self.navigationController!.pushViewController(vc!, animated: true)
    }
}
