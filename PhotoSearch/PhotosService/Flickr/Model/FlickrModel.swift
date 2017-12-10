//
//  FlickrModel.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

struct FlickrModel: Codable {
    let photos: FlickrPhotosModel
    let stat: String
}

struct FlickrPhotosModel: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrPhotoModel]
}

struct FlickrPhotoModel: Codable, PhotoModel {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    var url: URL {
        return FlickrEndpoint.photoUrl(farm: farm, server: server, id: id, secret: secret)
    }
}
