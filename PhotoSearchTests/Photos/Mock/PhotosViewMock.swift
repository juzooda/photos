//
//  PhotosViewMock.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class PhotoViewMock: PhotosViewProtocol {
    
    var updateExpectation: XCTestExpectation?
    var updateActivityIndicatorStateExpectation: XCTestExpectation?
    
    func update(dataSource: [PhotoModel]) {
        updateExpectation?.fulfill()
    }
    
    func updateActivityIndicatorState(active: Bool) {
        updateActivityIndicatorStateExpectation?.fulfill()
    }
}
