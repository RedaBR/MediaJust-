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
    
    override func viewDidAppear(_ animated: Bool) {
        backUpList.removeAll()
        getFetch()
    }
    
    var backUpList : [Article] = []
    
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
    
    
    
}
