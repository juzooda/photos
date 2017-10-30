//
//  PhotoSearchViewController.swift
//  PhotoSearch
//
//  Created by Rafael Oda on 28/10/2017.
//  Copyright © 2017 Rafael Oda. All rights reserved.
//

import UIKit
import Kingfisher

protocol PhotosViewProtocol: class {
    func update(dataSource: [PhotoModel])
    func updateActivityIndicatorState(active: Bool)
}

class PhotosViewController: UIViewController, PhotosViewProtocol {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PhotosViewModelProtocol!
    var dataSource = [PhotoModel]()
    
    //MARK: UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPhotos()
    }
    
    //MARK: View Model Updates
    
    func update(dataSource: [PhotoModel]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func updateActivityIndicatorState(active: Bool) {
        active ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    //MARK: Transition Landscape/Portrait
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCellId", for: indexPath) as! PhotoCollectionViewCell
        let model = dataSource[indexPath.row]
        item.imageView.setFlickrPhoto(model: model)
        return item
    }
}

//MARK: - UICollectionViewDelegateFlowLayout - Cell size calculation

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let spacing = flowLayout?.minimumInteritemSpacing ?? 0
        let availableSize = width - (spacing * 2)
        let verticeSize = availableSize/3.0
        return CGSize(width: verticeSize, height: verticeSize)
    }
}

//MARK: - UIScrollViewDelegate - Fetch photos on the bottom.

extension PhotosViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewContentHeight = scrollView.contentSize.height
        let scrollViewContentPositionY = scrollView.contentOffset.y + collectionView.bounds.size.height
        if scrollViewContentHeight == scrollViewContentPositionY {
            viewModel.fetchPhotos()
        }
    }
}
