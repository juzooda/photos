//
//  FlickrPhotoDownloaderTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class FlickrPhotoDownloaderTests: XCTestCase {
    
    func testExtension() {
        let imageView = UIImageView()
        let model = photoModelMock()
        imageView.setPhoto(model: model)
    }
}
