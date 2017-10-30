//
//  FlickrServiceTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class FlickrServiceTests: XCTestCase {
    
    var subject: FlickrService!
    let urlSessionMock = URLSessionProtocolMock()
    
    override func setUp() {
        subject = FlickrService(urlSession: urlSessionMock)
        XCTAssertNotNil(subject)
    }
    
    func testFetchPhotos() {
        urlSessionMock.withError = false
        let ex = expectation(description: "fetchPhotos completion block")
        _ = subject.fetchPhotos(search: "Anything") { (photoModel, error) in
            ex.fulfill()
            XCTAssertNotNil(photoModel)
            XCTAssertNil(error)
            XCTAssertEqual(photoModel!.page, 1)
            XCTAssertEqual(photoModel!.pages, 2053)
            XCTAssertEqual(photoModel!.perpage, 100)
            XCTAssertEqual(photoModel!.total, "205230")
            XCTAssertEqual(photoModel!.photo.count, 34)
            let firstPhoto = photoModel!.photo.first!
            XCTAssertEqual(firstPhoto.farm, 5)
            XCTAssertEqual(firstPhoto.id, "37955399912")
            XCTAssertEqual(firstPhoto.isfamily, 0)
            XCTAssertEqual(firstPhoto.isfriend, 0)
            XCTAssertEqual(firstPhoto.ispublic, 1)
            XCTAssertEqual(firstPhoto.title, "IMG_6820 (Large)")
            XCTAssertEqual(firstPhoto.owner, "149569383@N04")
            XCTAssertEqual(firstPhoto.secret, "73182ef257")
            XCTAssertEqual(firstPhoto.server, "4451")
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchPhotosError() {
        urlSessionMock.withError = true
        let ex = expectation(description: "fetchPhotos completion block with error")
        _ = subject.fetchPhotos(search: "Anything") { (photoModel, error) in
            ex.fulfill()
            XCTAssertNotNil(error)
            XCTAssertNil(photoModel)
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
