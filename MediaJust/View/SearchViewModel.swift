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
}
// MARK: - Search view model
class SearchViewModel {
// instantiate protocol
    weak var delegate: SearchViewDelegate?
// objects for picker view
    var categories = ["general",
                      "business",
                      "entertainment",
                      "health",
                      "science",
                      "sports",
                      "technology"]
    var languages = ["fr", "en", "es", "pt", "it", "de", "ar"]
    var displayLanguage = ["fr": "French", "en": "English", "es": "Espagnol", "pt": "Portugues", "it": "Italian", "de": "Deutsch", "ar": "Arabe"]
    var categorySelected = ""
    var languageSelected = ""
    var keyWord = ""
//    function for call network and if success call a method of protocol
    func getResult () {
        MediaService.shared.getMedia(categories: categorySelected, languages: languageSelected, keyWords: keyWord) { [self] (info, success, _) in
            if success {
                delegate?.didReceivResult(infos: info!)
            } else {
            }
        }
    }
}
