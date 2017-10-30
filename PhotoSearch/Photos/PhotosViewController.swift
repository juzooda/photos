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
}

class PhotosViewController: UIViewController, PhotosViewProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PhotosViewModelProtocol!
    var dataSource = [PhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchPhotos(page: 0)
    }
    
    func update(dataSource: [PhotoModel]) {
        self.dataSource = dataSource
        collectionView.reloadData()
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
