//
//  SearchViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit
// MARK: - Search
class SearchViewController: UIViewController, UITextFieldDelegate {
// Outlets
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var languagesPickerView: UIPickerView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewCategoriesTitle: UIView!
    @IBOutlet weak var viewLanguagesTitle: UIView!
    @IBOutlet weak var viewKeyTitle: UIView!
    @IBOutlet weak var keyWords: UITextField!
    @IBOutlet weak var viewCategories: UIView!
    
    @IBOutlet weak var viewLanguages: UIView!
    @IBAction func searchButton(_ sender: UIButton) {
        if let text = keyWords.text {
            viewModel.keyWord = text
        }
// Method view model for call network
        viewModel.getResult()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        keyWords.delegate = self
        viewModel.delegate = self
// Customize views with shadows
        viewTitle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewTitle.layer.shadowRadius = 2.0
        viewTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewTitle.layer.shadowOpacity = 2.0
        viewCategoriesTitle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewCategoriesTitle.layer.shadowRadius = 2.0
        viewCategoriesTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewCategoriesTitle.layer.shadowOpacity = 2.0
        viewLanguagesTitle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewLanguagesTitle.layer.shadowRadius = 2.0
        viewLanguagesTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewLanguagesTitle.layer.shadowOpacity = 2.0
        viewKeyTitle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewKeyTitle.layer.shadowRadius = 2.0
        viewKeyTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewKeyTitle.layer.shadowOpacity = 2.0
        viewCategories.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewCategories.layer.shadowRadius = 2.0
        viewCategories.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewCategories.layer.shadowOpacity = 2.0
        viewLanguages.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewLanguages.layer.shadowRadius = 2.0
        viewLanguages.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewLanguages.layer.shadowOpacity = 2.0
    }
    var viewModel = SearchViewModel()
    var resultViewModel = ResultViewModel.shared
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - Protocol SearchViewDelegate for communicate with model
extension SearchViewController: SearchViewDelegate {
// Protocol method implementation
    func didReceivResult(infos: MediaInfos) {
// Asynchronous functions in threads
        DispatchQueue.main.async { [self] in
            resultViewModel.clearList()
            self.resultViewModel.addResult(result: infos)
// Instantiate ResultViewController for pushing
            let vCtrlResult = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewID") as? ResultViewController
            self.navigationController?.pushViewController(vCtrlResult!, animated: true)
        }
    }
}

// MARK: - Cunstomise pickerView
extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoriesPickerView {
            return  viewModel.categories.count
        } else if pickerView == languagesPickerView {
            return viewModel.languages.count
    }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoriesPickerView {
            return viewModel.categories[row]
        }
        else if pickerView == languagesPickerView {
            return viewModel.languages[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoriesPickerView {
            let categorieText = viewModel.categories[row]
            viewModel.categorySelected = categorieText
        } else if pickerView == languagesPickerView {
            let languagesText = viewModel.languages[row]
            viewModel.languageSelected = languagesText
        }
    }
}
