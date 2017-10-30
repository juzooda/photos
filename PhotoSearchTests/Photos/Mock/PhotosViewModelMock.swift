//
//  PhotosViewModelMock.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class PhotosViewModelMock: PhotosViewModelProtocol {
    var expectation: XCTestExpectation?
    weak var view: PhotosViewProtocol!
    
    func fetchPhotos() {
        expectation?.fulfill()
        view.updateActivityIndicatorState(active: true)
        view.update(dataSource: [photoModelMock()])
    }
}
