//
//  PhotoService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation

class PhotoService {
    
    private var dataService = PhotoDataService()
    
    func savePhoto(withIdentifier identifier: String, title: String?) {
        try? dataService.persist(photo: PhotoModel(localIdentifier: identifier, title: title, timestamp: Date().description))
    }
    
    func getPhotos() -> [PhotoModel] {
        guard let dbPhotos = dataService.getPhotos() else { return [] }
        
        var photos: [PhotoModel] = []
        
        dbPhotos.forEach { (photo) in
            if ImageService.shared.imageExists(withLocalIdentifier: photo.localIdentifier) {
                photos.append(photo)
            } else {
                let predicate = NSPredicate(format: "localIdentifier = %@", photo.localIdentifier)
                try? self.dataService.deletePhotos(withPredicate: predicate)
            }
        }
        
        return photos
    }
    
}
