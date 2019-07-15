//
//  PhotoDataService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation

class PhotoDataService: AbstractDataService {
    
    func persist(photo: PhotoModel) throws {
        try safeWrite {
            realm?.add(PhotoDao(withPhoto: photo))
        }
    }
    
    func getPhotos() -> [PhotoModel]? {
        return realm?.objects(PhotoDao.self).compactMap { PhotoModel(withDao: $0) }
    }
    
    func deletePhotos(withPredicate predicate: NSPredicate? = nil) throws {
        try safeWrite {
            var objects = realm?.objects(PhotoDao.self)
            
            if let predicate = predicate {
                objects = objects?.filter(predicate)
            }
            
            objects?.forEach { realm?.delete($0) }
        }
    }
    
}
