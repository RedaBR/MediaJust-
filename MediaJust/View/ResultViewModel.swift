//
//  ResultViewModel.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import Foundation

class ResultViewModel {
    
    private init() { }
    
    var titleModel = ""
    var urlModel = ""
    
    static let shared = ResultViewModel()
    func clearList () {
        listResult.removeAll()
    }
   func addResult (result:MediaInfos) {
    for i in result.data ?? []{
        listResult.append(i)
    }
    
   }
    
    var listResult : [Datum] = []
}
