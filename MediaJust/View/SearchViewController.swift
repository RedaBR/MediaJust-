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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
var viewModel = SearchViewModel()
    
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}
extension SearchViewController : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoriesPickerView {
            return  viewModel.categories.count
        } else if pickerView == countriesPickerView {
            return viewModel.countries.count
        }
      return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoriesPickerView{
            return viewModel.categories[row]
        } else if pickerView == countriesPickerView {
            return viewModel.countries[row]
        }
            return ""
    }
}



