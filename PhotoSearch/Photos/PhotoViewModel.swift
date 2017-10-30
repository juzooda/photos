//
//  PhotoSearchViewModel.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import Foundation

protocol PhotosViewModelProtocol: class {
    func fetchPhotos()
}

class PhotosViewModel: PhotosViewModelProtocol {
    
    let photoService: FlickrServiceProtocol
    weak var view: PhotosViewProtocol!
    let searchInput: String
    var currentPage: Int
    
    var loadingPhoto: Bool{
        didSet {
            DispatchQueue.main.async {
                self.view.updateActivityIndicatorState(active: self.loadingPhoto)
            }
        }
    }
    
    
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
        self.currentPage = 0
        self.loadingPhoto = false
    }
    
    func fetchPhotos() {
        DispatchQueue.global(qos: .userInitiated).async {
            if !self.loadingPhoto {
                self.currentPage += 1
                self.loadingPhoto = true
                self.photoService.fetchPhotos(search: self.searchInput, page: 1) { [weak self] (photoModel, error) in
                    guard let photoModel = photoModel, !photoModel.photo.isEmpty else {
                        return
                    }
                    self?.photos.append(contentsOf: photoModel.photo)
                    self?.loadingPhoto = false
                }
            }
        }
    }
}
