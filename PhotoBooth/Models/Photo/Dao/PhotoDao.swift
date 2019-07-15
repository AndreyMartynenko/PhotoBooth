//
//  PhotoDao.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoDao: Object {
    
    @objc dynamic var localIdentifier: String!
    @objc dynamic var title: String?
    @objc dynamic var timestamp: String!
    
    convenience init(withPhoto photo: PhotoModel) {
        self.init()
        
        localIdentifier = photo.localIdentifier
        title = photo.title
        timestamp = photo.timestamp
    }
    
}
