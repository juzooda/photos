//
//  FlickrEndpointTests.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class FlickrEndpointTests: XCTestCase {
    
    func testSearchPhotosUrlAssembly() {
        let kittensSearch = FlickrEndpoint.searchPhotosUrl(input: "kittens", page: 2)
        XCTAssertEqual(kittensSearch.absoluteString, "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=kittens&page=2")
        
        let emptySearch = FlickrEndpoint.searchPhotosUrl(input: "", page: 1)
        XCTAssertEqual(emptySearch.absoluteString, "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=&page=1")
    }
    
    func testPhotosUrlAssembly() {
        let kittensSearch = FlickrEndpoint.photoUrl(farm: 1, server: "570", id: "23451156376", secret: "8983a8ebc7")
        XCTAssertEqual(kittensSearch.absoluteString, "https://farm1.static.flickr.com/570/23451156376_8983a8ebc7.jpg")
    }
}
