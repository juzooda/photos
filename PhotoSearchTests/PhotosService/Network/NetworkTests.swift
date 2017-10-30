//
//  NetworkTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class NetworkTests: XCTestCase {
    
    let subject: Network = Network()
    
    func testExample() {
        let url = URL(string:"http://www.google.com")!
        let ex = expectation(description: "Completion is called")
        subject.dataTask(with: url) { (data, url, error) in
            ex.fulfill()
        }.resume()
        waitForExpectations(timeout: 2, handler: nil)
    }
}
