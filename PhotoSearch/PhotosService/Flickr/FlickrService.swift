//
//  FlickrService.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

typealias FlickrCompletion = (_ photoModel: FlickrPhotosModel?, _ error: Error?) -> Void

protocol FlickrServiceProtocol {
    @discardableResult
    func fetchPhotos(search: String, page: Int, completion: @escaping FlickrCompletion) -> URLSessionDataTask
}

class FlickrService: FlickrServiceProtocol {
    
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = Network()) {
        self.urlSession = urlSession
    }
    
    func fetchPhotos(search: String, page: Int, completion: @escaping FlickrCompletion) -> URLSessionDataTask {
        let searchUrl = FlickrEndpoint.searchPhotosUrl(input: search, page: page)
        let dataTask = urlSession.dataTask(with: searchUrl) { (data, response, error) in
            guard
                let data = data,
                let model = try? JSONDecoder().decode(FlickrModel.self, from: data) else {
                completion(nil, error)
                return
            }
            
            completion(model.photos, nil)
        }
        
        dataTask.resume()
        return dataTask
    }
}
