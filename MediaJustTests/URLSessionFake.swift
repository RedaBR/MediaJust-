//
//  URLSessionFake.swift
//  MediaJustTests
//
//  Created by Reda on 12/10/2022.
//

import Foundation

class URLSessionFake : URLSession {
    
    var data : Data?
    var response : HTTPURLResponse?
    var error : Error?
    
    init(data:Data?, response:HTTPURLResponse?, error:Error?){
        self.data = data
        self.response = response
        self.error = error 
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLFakeSessionDataTask()
        task.data = data
        task.urlResponse = response
        task.responseError = error
        
        return task
    }
}

class URLFakeSessionDataTask : URLSessionDataTask {
    var callBack : ((Data?,HTTPURLResponse?,Error?)->Void)?
    
    var data : Data?
    var urlResponse : HTTPURLResponse?
    var responseError : Error?
    
    override func resume () {
        callBack?(data,urlResponse,responseError)
    }
}
