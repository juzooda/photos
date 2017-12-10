//
//  FlickrServiceMock.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import XCTest
@testable import PhotoSearch

class FlickrServiceMock: FlickrServiceProtocol {
    
    var expectation: XCTestExpectation?
    var withError: Bool = false
    
    func fetchPhotos(search: String, page: Int, completion: @escaping FlickrCompletion) -> URLSessionDataTask {
        expectation?.fulfill()
        if withError {
            completion(nil, errorMock())
        }else {
            completion(fotosModelMock(), nil)
        }
        
        return dataTaskMock()
    }
}

func fotosModelMock() -> FlickrPhotosModel {
    return FlickrPhotosModel(
        page: 0,
        pages: 1,
        perpage: 100,
        total: "100",
        photo: [photoModelMock()]
    )
}

func photoModelMock() -> FlickrPhotoModel {
     return FlickrPhotoModel(
        id: "1234",
        owner: "Rafael",
        secret: "Goldfinger",
        server: "Extra fast",
        farm: 0,
        title: "James Bond",
        ispublic: 0,
        isfriend: 0,
        isfamily: 0
    )
}
