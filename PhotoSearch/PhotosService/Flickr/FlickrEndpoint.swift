//
//  FlickrEndpoint.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

private let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
private let searchMethod = "flickr.photos.search"
private let format = "json"
private let searchBaseUrl = "https://api.flickr.com/services/rest/?method=%@&api_key=%@&format=%@&nojsoncallback=1&safe_search=1&text=%@&page=%@"
private let photoBaseUrl = "https://farm%@.static.flickr.com/%@/%@_%@.jpg"

struct FlickrEndpoint {
    static func searchPhotosUrl(input: String, page: Int) -> URL {
        let encodedString = input.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let formattedUrl = String(format: searchBaseUrl, searchMethod, apiKey, format, encodedString, "\(page)")
        return URL(string: formattedUrl)!
    }
    
    static func photoUrl(farm: Int, server: String, id: String, secret: String) -> URL {
        let formattedUrl = String(format: photoBaseUrl, "\(farm)", server, id, secret)
        let encodedString = formattedUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        return URL(string: encodedString)!
    }
}

