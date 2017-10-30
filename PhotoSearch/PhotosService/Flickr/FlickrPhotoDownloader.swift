//
//  FlickrPhotoDownloader.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 30/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setFlickrPhoto(model: PhotoModel) {
        let url = FlickrEndpoint.photoUrl(farm: model.farm, server: model.server, id: model.id, secret: model.secret)
        self.kf.setImage(with: url)
    }
}
