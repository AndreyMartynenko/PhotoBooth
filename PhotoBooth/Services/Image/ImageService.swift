//
//  ImageService.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ImageService {
    
    static var shared: ImageService = ImageService()
    
    func image(withLocalIdentifier localIdentifier: String) -> UIImage? {
        guard let asset = asset(withLocalIdentifier: localIdentifier) else { return nil }
        
        var image: UIImage?
        
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        
        PHImageManager.default().requestImageData(for: asset, options: options) { data, _, _, _ in
            if let data = data {
                image = UIImage(data: data)
            }
        }
        
        return image
    }
    
    func imageExists(withLocalIdentifier localIdentifier: String) -> Bool {
        return asset(withLocalIdentifier: localIdentifier) != nil
    }
    
}

// MARK: - Private methods
private extension ImageService {
    
    func asset(withLocalIdentifier localIdentifier: String) -> PHAsset? {
        return PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject
    }
    
}
