//
//  AbstractDataService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import RealmSwift

class AbstractDataService {
    
    var realm: Realm?
    
    init() {
        realm = try? Realm()
    }
    
    func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = realm else { throw NSError() }
        
        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
    
}
