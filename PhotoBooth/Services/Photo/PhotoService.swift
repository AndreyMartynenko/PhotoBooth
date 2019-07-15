//
//  PhotoService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation

class PhotoService {
    
    private var photoDataService = PhotoDataService()
    
    func savePhoto(withIdentifier identifier: String, title: String?) {
        let photo = PhotoModel(localIdentifier: identifier, title: title, timestamp: Date().description)
        
        try? photoDataService.persist(photo: photo)
    }
    
    func getPhotos() -> [PhotoModel]? {
        return photoDataService.getPhotos()
    }
    
}
