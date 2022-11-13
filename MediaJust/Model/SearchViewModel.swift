//
//  SearchViewModel.swift
//  MediaJust
//
//  Created by Reda on 15/09/2022.
//

import Foundation
// MARK: - Protocol SearchViewDelegate
protocol SearchViewDelegate: AnyObject {
    func didReceivResult (infos: MediaInfos)
    func presentAlert ()
}
// MARK: - Search view model
class SearchViewModel {
    // instantiate protocol
    weak var delegate: SearchViewDelegate?
    var categories = ["general",
                      "business",
                      "entertainment",
                      "health",
                      "science",
                      "sports",
                      "technology"]
    var languages = ["fr", "en", "es", "pt", "it", "de", "ar"]
    var displayLanguage = ["fr": NSLocalizedString("French", comment: ""), "en":  NSLocalizedString("English", comment: ""), "es":NSLocalizedString("Espagnol", comment: ""), "pt":  NSLocalizedString("Portugues", comment: ""), "it":  NSLocalizedString("Italian", comment: ""), "de":  NSLocalizedString("Deutsch", comment: ""), "ar":NSLocalizedString("Arabic", comment: "")]
    var categorySelected = ""
    var languageSelected = ""
    var keyWord = ""
    // function for call network and if success call a method of protocol
    func getResult () {
        MediaService.shared.getMedia(categories: categorySelected, languages: languageSelected, keyWords: keyWord) { [self] (info, success, _) in
            if success {
                delegate?.didReceivResult(infos: info!)
            } else {
                delegate?.presentAlert()
            }
        }
    }
}
