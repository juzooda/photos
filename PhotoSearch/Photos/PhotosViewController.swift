//
//  PhotoSearchViewController.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import UIKit

protocol PhotosViewProtocol: class {
    func update(dataSource: [PhotoModel])
    func updateActivityIndicatorState(active: Bool)
}

class PhotosViewController: UIViewController, PhotosViewProtocol {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PhotosViewModelProtocol!
    var dataSource = [PhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchPhotos()
    }
    
    func update(dataSource: [PhotoModel]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func updateActivityIndicatorState(active: Bool) {
        active ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCellId", for: indexPath) as! PhotoCollectionViewCell
        return item
    }
}

extension PhotosViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewContentHeight = scrollView.contentSize.height
        let scrollViewContentPositionY = scrollView.contentOffset.y + collectionView.bounds.size.height
        if scrollViewContentHeight == scrollViewContentPositionY {
            viewModel.fetchPhotos()
        }
    }
}
