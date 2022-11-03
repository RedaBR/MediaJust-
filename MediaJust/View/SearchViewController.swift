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
    @IBOutlet weak var categoriesTitle: UILabel!
    @IBOutlet weak var languagesTitle: UILabel!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var languagesPickerView: UIPickerView!

    @IBOutlet weak var keyWords: UITextField!
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
        categoriesTitle.text = R.string.localizable.categories()
        languagesTitle.text = R.string.localizable.languages()
        super.viewDidLoad()
        keyWords.delegate = self
        viewModel.delegate = self

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
        if pickerView == categoriesPickerView { return viewModel.categories[row]} else if pickerView == languagesPickerView { let language = viewModel.languages[row]
            return viewModel.displayLanguage[language]
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
