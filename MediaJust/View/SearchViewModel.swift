//
//  SearchViewModel.swift
//  MediaJust
//
//  Created by Reda on 15/09/2022.
//

import Foundation

protocol SearchViewDelegate : AnyObject {
    func didReceivResult (infos:MediaInfos)
    
    
}

class SearchViewModel {
    
    weak var delegate :SearchViewDelegate?
    
    var categories = ["general",
                      "business",
                      "entertainment",
                      "health",
                      "science",
                      "sports",
                      "technology"]
    
    
   
    
    var categorySelected = ""
    
  
    
    var keyWord = ""
    
    
    
    
    
    func getResult (){
        MediaService.shared.getMedia(categories: categorySelected,keyWords: keyWord) { [self] (info, success, error) in
            if success  {
                delegate?.didReceivResult(infos: info!)
                
            } else {
                
            }
        }
    }
    
    
}
