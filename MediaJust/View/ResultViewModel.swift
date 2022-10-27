//
//  ResultViewModel.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import Foundation
// MARK: - Result view Model
class ResultViewModel {

    private init() {}
// Variable for customise result
    var titleModel = ""
    var urlModel = ""
// Pattern singleton
    static let shared = ResultViewModel()
// Clean the list before adding the new result
    func clearList () {
        listResult.removeAll()
    }
    func addResult (result: MediaInfos) {
// Loop that goes through all the data objects and adds them to the list to customize cell result
    for properties in result.data ?? [] {
    listResult.append(properties)
    }
   }
//    List for customise cell result 
    var listResult: [Datum] = []
}
