//
//  PhotoService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import Photos

class PhotoService {
    
    private var dataService = PhotoDataService()
    
    func savePhoto(withIdentifier identifier: String, title: String?) {
        DispatchQueue.main.async {
            try? self.dataService.persist(photo: PhotoModel(localIdentifier: identifier, title: title, timestamp: Date().description))
        }
    }
    
    func getPhotos() -> [PhotoModel] {
        guard let dbPhotos = dataService.getPhotos() else { return [] }
        
        var photos: [PhotoModel] = []
        
        dbPhotos.forEach { (photo) in
            if PHAsset.fetchAssets(withLocalIdentifiers: [photo.localIdentifier], options: nil).firstObject != nil {
                photos.append(photo)
            } else {
                let predicate = NSPredicate(format: "localIdentifier = %@", photo.localIdentifier)
                try? self.dataService.deletePhotos(withPredicate: predicate)
            }
        }
        
        return photos
    }
    
}
