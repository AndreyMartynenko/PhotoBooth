//
//  AbstractDataService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import RealmSwift

/*
 AbstractDataService class should implement AbstractDataServiceProtocol written in generic way in order to not expose
 'safeWrite' method and to encasulate all the common logic.
 
 Similar methods to the following should be created and implemented for rest of db methods such as: 'update', 'delete' and 'fetch':
 
 func persist<T: Persistable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
 
 */

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
