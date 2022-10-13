//
//  MediaJustTests.swift
//  MediaJustTests
//
//  Created by Reda on 05/07/2022.
//

import XCTest

@testable import MediaJust

class MediaJustTests: XCTestCase {

    func testGetMediaShouldPostFailedCallbackIfError() {
        // Given
        let media = MediaService(session:URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
    }
    
    func testGetMediaShouldPostFailedCallbackIfNoData() {
        
        let media = MediaService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            XCTAssertNil(data)
            XCTAssertFalse(success)
            XCTAssertNil(error)
        }
        
    }
    
    func testGetMediaShouldPostFailedCallbackIfIncorrectResponse() {
        let media = MediaService(session: URLSessionFake(data: FakeResponseData().correctMediaData, response: FakeResponseData().responseKO, error: nil))
        
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            XCTAssertNotNil(data)
            XCTAssertTrue(success)
        }
    }
    
    func testGetMediaShouldPostFailedCallbackIfIncorrectData() {
        
        let media = MediaService(session: URLSessionFake(data: FakeResponseData().incorrectData, response: FakeResponseData().responseOK, error: nil))
        
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            XCTAssertNil(data)
            XCTAssertFalse(success)
        }
    }
    
    func testMediaShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let media = MediaService(session: URLSessionFake(data: FakeResponseData().correctMediaData, response: FakeResponseData().responseOK, error: nil))
        
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            XCTAssertNotNil(data)
            XCTAssertTrue(success)
        }
        
    }
    
}
