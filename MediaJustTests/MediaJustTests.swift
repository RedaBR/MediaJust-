//
//  MediaJustTests.swift
//  MediaJustTests
//
//  Created by Reda on 05/07/2022.
//

import XCTest
// MARK: - Test Media Just
@testable import MediaJust
class MediaJustTests: XCTestCase {
    func testGetMediaShouldPostFailedCallbackIfError() {
        // Given
        let media = MediaService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let searchModel = SearchViewModel()
        // When
        searchModel.getResult()
            media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    func testGetMediaShouldPostFailedCallbackIfNoData() {
        // Given
        let media = MediaService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
        // Then
            XCTAssertNil(data)
            XCTAssertFalse(success)
            XCTAssertNil(error)
        }
    }
    func testGetMediaShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let media = MediaService(session: URLSessionFake(data: FakeResponseData().correctMediaData, response: FakeResponseData().responseKO, error: nil))
        // When
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, _) in
        // Then
            XCTAssertNotNil(data)
            XCTAssertTrue(success)
        }
    }
    func testGetMediaShouldPostFailedCallbackIfIncorrectData() {
        // Given
let media = MediaService(session: URLSessionFake(data: FakeResponseData().incorrectData, response: FakeResponseData().responseOK, error: nil))
        // When
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, _) in
        // Then
            XCTAssertNil(data)
            XCTAssertFalse(success)
        }
    }
    func testMediaShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
let media = MediaService(session: URLSessionFake(data: FakeResponseData().correctMediaData, response: FakeResponseData().responseOK, error: nil))
        // When
        media.getMedia(categories: "general", languages: "fr", keyWords: "") { (data, success, error) in
            let resultModel = ResultViewModel.shared
            resultModel.addResult(result: data!)
        // Then
            XCTAssertTrue(resultModel.listResult.count == 1)
            XCTAssertNotNil(data)
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }
    }
}
