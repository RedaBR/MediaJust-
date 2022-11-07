//
//  SearchViewController.swift
//  MediaJust
//
//  Created by Reda on 05/07/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var categoriesTitle: UILabel!
    @IBOutlet weak var languagesTitle: UILabel!
    @IBOutlet weak var keywordsTitle: UILabel!
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
    override func viewDidLoad() {
        categoriesTitle.text = R.string.localizable.categories()
        languagesTitle.text = R.string.localizable.languages()
        keywordsTitle.text = R.string.localizable.keywords()
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
// MARK: - UItext Field Delegate
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
// MARK: - Protocol SearchViewDelegate for communicate with model
extension SearchViewController: SearchViewDelegate {

    func didReceivResult(infos: MediaInfos) {

        DispatchQueue.main.async { [self] in
            resultViewModel.clearList()
            self.resultViewModel.addResult(result: infos)

            let vCtrlResult = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewID") as? ResultViewController
            self.navigationController?.pushViewController(vCtrlResult!, animated: true)
        }
    }
}

// MARK: - Cunstomise pickerView
extension SearchViewController: UIPickerViewDataSource{
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
}
// MARK: - PickerView did select
extension SearchViewController :  UIPickerViewDelegate {
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
