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
    func setPhoto(model: PhotoModel) {
        self.kf.setImage(with: model.url)
    }
}
