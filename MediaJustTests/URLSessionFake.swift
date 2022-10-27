//
//  URLSessionFake.swift
//  MediaJustTests
//
//  Created by Reda on 12/10/2022.
//

import Foundation
// MARK: - URL Session Fake
class URLSessionFake: URLSession {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
// Initializer to be able to associate them with the desired values
    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
// Override of the dataTaske function necessary to manage the response during our network call
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
// Associate the parameters of the closure that manages the response to our false properties
    let task = URLFakeSessionDataTask()
    task.data = data
    task.urlResponse = response
    task.responseError = error
    return task
    }
}
// MARK: - URL Session Data Tak Fake
// Creation of a fake class URLSessionDataTask"Fake" of type real class URLSessionDataTask
class URLFakeSessionDataTask: URLSessionDataTask {
    var callBack: ((Data?, HTTPURLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: HTTPURLResponse?
    var responseError: Error?
// launch of the task with our false properties
    override func resume () {
        callBack?(data, urlResponse, responseError)
    }
}
