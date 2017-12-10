//
//  PhotoViewModelTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class PhotoViewModelTests: XCTestCase {
    
    let serviceMock = FlickrServiceMock()
    let viewMock = PhotoViewMock()
    var subject: PhotosViewModel!
    
    override func setUp() {
        super.setUp()
        subject = PhotosViewModel(searchInput: "Dogs", flickrPhotoService: serviceMock, view: viewMock)
        XCTAssertNotNil(subject)
    }
    
    func testFetch() {
        let callService = expectation(description: "callService")
        let updateView = expectation(description: "callService")
        serviceMock.expectation = callService
        viewMock.updateExpectation = updateView
        subject.fetchPhotos()
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchError() {
        let callService = expectation(description: "callService")
        serviceMock.expectation = callService
        serviceMock.withError = true
        subject.fetchPhotos()
        waitForExpectations(timeout: 2, handler: nil)
    }
}
