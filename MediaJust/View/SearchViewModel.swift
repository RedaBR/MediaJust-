//
//  SearchViewModel.swift
//  MediaJust
//
//  Created by Reda on 15/09/2022.
//

import Foundation
class SearchViewModel {
    
    var categories = ["general",
                      "business",
                      "entertainment",
                      "health",
                      "science",
                      "sports",
                      "technology"]
    
    
    var countries = ["Belgique","France","Etats-Unis","Suéde","Suisse","Italie","Allemagne","Argentine"]
    

    func getResult (categories:String, countries:String, keyWords:String){
            MediaService.shared.getMedia(categories: categories, countries: countries, keyWords: keyWords) { (info, success, error) in
                if success == false {
                    SearchViewController().presentAlert(with: "z")
                }
            }
    }
    
}
