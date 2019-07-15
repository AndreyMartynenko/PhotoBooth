//
//  PhotoGalleryViewController.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

class PhotoGalleryViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var photoService: PhotoService = PhotoService()
    private var dataSource: [PhotoModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
    }
    
}

// MARK: - Configuration
private extension PhotoGalleryViewController {
    
    func configureData() {
        dataSource = photoService.getPhotos()
        
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource implementation
extension PhotoGalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        cell.update(withPhoto: dataSource[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate implementation
extension PhotoGalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = UIViewController.instantiate(withClass: FullscreenViewController.self) else { return }
        
        viewController.photo = dataSource[indexPath.row].image
        viewController.modalTransitionStyle = .crossDissolve
        
        present(viewController, animated: true, completion: nil)
    }
    
}
