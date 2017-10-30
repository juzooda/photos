//
//  PhotosViewControllerTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class PhotosViewControllerTests: XCTestCase {
    
    var photosViewController: PhotosViewController!
    let viewModelMock = PhotosViewModelMock()
    
    override func setUp() {
        super.setUp()
        let mainBundle = Bundle(for: PhotosViewController.self)
        photosViewController = UIStoryboard(name: "Main", bundle: mainBundle).instantiateViewController(withIdentifier: "ResultsViewController") as! PhotosViewController
        photosViewController.viewModel = viewModelMock
        viewModelMock.view = photosViewController
        XCTAssertNotNil(photosViewController.view)
    }
    
    func testUpdateView() {
        let updateExpectation = expectation(description: "updateExpectation")
        viewModelMock.expectation = updateExpectation
        photosViewController.viewDidLoad()
        XCTAssertEqual(photosViewController.dataSource.count, 1)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
