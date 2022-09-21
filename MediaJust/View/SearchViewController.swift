//
//  SearchViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    
    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    @IBOutlet weak var KeyWords: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        if let text = KeyWords.text {
            viewModel.keyWord = text
        }
        viewModel.getResult()
    }
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyWords.delegate = self
        viewModel.delegate = self

    }
    
    var viewModel = SearchViewModel()
 

    
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}
extension SearchViewController : SearchViewDelegate {
    func didReceivResult(infos: MediaInfos) {
        
            self.presentAlert(with: "Found \(infos.data?.count) infos")
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoriesPickerView{
            let categorieText = viewModel.categories[row]
            viewModel.categorySelected = categorieText
        }
        else if pickerView == countriesPickerView {
            let countriesText = viewModel.countries[row]
            viewModel.countrySelected = countriesText
        }
    }
}



