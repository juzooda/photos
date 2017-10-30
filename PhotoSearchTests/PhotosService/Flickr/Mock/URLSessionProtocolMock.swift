//
//  URLSessionProtocolMock.swift
//  PhotoSearchTests
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation
@testable import PhotoSearch

class URLSessionProtocolMock: URLSessionProtocol {
    
    var withError = false
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if withError {
            completionHandler(nil, nil, errorMock())
        }else {
            let data = PayloadLoader.open(payloadName: "fotosMock", ofType: "json")
            completionHandler(data, nil, nil)
        }
        
        return dataTaskMock()
    }
}

func errorMock() -> Error {
    return NSError(domain: "", code: -1001, userInfo: nil)
}

func dataTaskMock() -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: URL(string:"http://booble.com")!)
}
