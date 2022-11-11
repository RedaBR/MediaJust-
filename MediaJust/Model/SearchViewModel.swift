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
    var displayLanguage = ["fr": R.string.localizable.french(), "en":  R.string.localizable.english(), "es":  R.string.localizable.espagnol(), "pt":  R.string.localizable.portugues(), "it":  R.string.localizable.italian(), "de":  R.string.localizable.deutsch(), "ar": R.string.localizable.arabe()]
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
