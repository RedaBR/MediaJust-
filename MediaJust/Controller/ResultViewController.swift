//
//  ResultViewController.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import UIKit
// MARK: - Result
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
// MARK: - Customise cell result
extension ResultViewController: UITableViewDataSource {
// Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultViewModel.listResult.count
    }
// Customise reusable cell of list resut
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = resultList
        var cell = UITableViewCell()
// use metode of UITableView for customise a reusable cell
        let customCell = list?.dequeueReusableCell(withIdentifier: "CustomCellResult") as? CustomTableViewCell
// Associate object list result of model  with row
        let result = resultViewModel.listResult[indexPath.row]
// Custom properties of list result with model properties
        customCell?.title.text = result.title
        cell = customCell!

        return cell
    }

}
extension ResultViewController :  UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
// Identifiate a row selected
        let result = resultViewModel.listResult[indexPath.row]
// Instantiate DescriptionViewController for pushing
        let vCtrlDescription = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DescriptionID") as? DescriptionViewController
//  Associate properties of model result with result list
        vCtrlDescription?.properties.titleModel = result.title!
        vCtrlDescription?.properties.urlModel = result.url!
        self.navigationController!.pushViewController(vCtrlDescription!, animated: true)
    }
}
