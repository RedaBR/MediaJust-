//
//  FakeResponseData.swift
//  MediaJustTests
//
//  Created by Reda on 12/10/2022.
//

import Foundation

class FakeResponseData {
    
    var correctMediaData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let urlData = bundle.url(forResource:"MediaData" , withExtension: "json")!
        let data = try? Data(contentsOf: urlData)
        
        return data!
    }
     
    let incorrectData =  "erreur".data(using:.utf8)
    
    let responseOK = HTTPURLResponse(url: URL(string:"http://googl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responseKO = HTTPURLResponse(url: URL(string:"http://googl.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class DataError : Error {}
    static let error = DataError()
}
