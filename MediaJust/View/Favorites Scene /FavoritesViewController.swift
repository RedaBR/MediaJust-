//
//  FavoritesViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit
// MARK: - Search
class FavoritesViewController: UIViewController {
    @IBOutlet weak var favList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backUpList.removeAll()

        favList.delegate = self
        favList.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            backUpList.removeAll()
            getFetch()
    }
//    list of entities Core Data for custom cell
    var backUpList: [Article] = []
    var resultViewModel = ResultViewModel.shared
    func getFetch () {
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            favList.reloadData()
        }
    }
    
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backUpList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = favList
        var cell = UITableViewCell()
        if let customCell = list?.dequeueReusableCell(withIdentifier: "CustomFav") as? CustomFavTableViewCell {
            let result = backUpList[indexPath.row]
            customCell.title.text = result.title
            cell = customCell
        }
        return cell
    }
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = backUpList[indexPath.row]
        let vCtrlFav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavListID") as?FavDescriptionViewController
        vCtrlFav?.properties.titleModel = result.title!
        vCtrlFav?.properties.urlModel = result.url!
        self.navigationController!.pushViewController(vCtrlFav!, animated: true)
    }
}
