//
//  PhotoSearchViewModel.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

protocol PhotosViewModelProtocol: class {
    func fetchPhotos(page: Int)
}

class PhotosViewModel: PhotosViewModelProtocol {
    
    let photoService: FlickrServiceProtocol
    let searchInput: String
    weak var view: PhotosViewProtocol!
    
    var photos: [PhotoModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view.update(dataSource: self.photos)
            }
        }
    }
    
    init(searchInput: String, photoService: FlickrServiceProtocol, view: PhotosViewProtocol) {
        self.searchInput = searchInput
        self.photoService = photoService
        self.view = view
    }
    
    func fetchPhotos(page: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.photoService.fetchPhotos(search: self.searchInput) { [weak self] (photoModel, error) in
                guard let photoModel = photoModel, !photoModel.photo.isEmpty else {
                    return
                }
                self?.photos = photoModel.photo
            }
        }
    }
}
