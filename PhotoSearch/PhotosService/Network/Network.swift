//
//  Network.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with: URL, completionHandler: @escaping(_ : Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> URLSessionDataTask
}

class Network: URLSessionProtocol {
    let session = URLSession.shared
    func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: with, completionHandler: completionHandler)
    }
}
