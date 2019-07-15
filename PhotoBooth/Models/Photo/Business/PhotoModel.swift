//
//  PhotoModel.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation

struct PhotoModel {
    var localIdentifier: String!
    var title: String?
    var timestamp: String!
    
    init(withDao dao: PhotoDao) {
        localIdentifier = dao.localIdentifier
        title = dao.title
        timestamp = dao.timestamp
    }
    
}
