//
//  FakeResponseData.swift
//  MediaJustTests
//
//  Created by Reda on 12/10/2022.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    var correctMediaData: Data {
// identifying the bundle that contains the FakeResponseData class file
        let bundle = Bundle(for: FakeResponseData.self)
// identification of the url of the file which contains the data in json imported from postman
        let urlData = bundle.url(forResource: "MediaData", withExtension: "json")!
// Retrieval of data contained at the url via the Data initiator
        let data = try? Data(contentsOf: urlData)
        return data!
    }
// Encoding of a String value the method return a Data type value
    let incorrectData =  "erreur".data(using: .utf8)
    // MARK: - Response
   // Creation of 2 instances of HTTPURLResponse to test cases of error related to bad code
let responseOK = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
let responseKO = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    // MARK: - Error
    class DataError: Error {}
    // Access To Error
    static let error = DataError()
}
