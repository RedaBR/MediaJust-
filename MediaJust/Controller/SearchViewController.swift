//
//  SearchViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    
    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    @IBOutlet weak var KeyWords: UITextField!
    
    var categories = ["general",
                      "business",
                      "entertainment",
                      "health",
                      "science",
                      "sports",
                      "technology"]
    
    
    var countries = ["Belgique","France","Etats-Unis","Suéde","Suisse","Italie","Allemagne","Argentine"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
extension SearchViewController : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoriesPickerView {
            return  categories.count
        } else if pickerView == countriesPickerView {
            return countries.count
        }
      return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoriesPickerView{
            return categories[row]
        } else if pickerView == countriesPickerView {
            return countries[row]
        }
            return ""
    }
}



