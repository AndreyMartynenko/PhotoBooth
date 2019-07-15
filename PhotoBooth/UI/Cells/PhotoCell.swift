//
//  PhotoCell.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    func update(withPhoto photo: PhotoModel) {
        photoImageView.image = image(fromAsset: PHAsset.fetchAssets(withLocalIdentifiers: [photo.localIdentifier], options: nil).firstObject)
    }
    
}

private extension PhotoCell {
    
    func image(fromAsset asset: PHAsset?) -> UIImage? {
        guard let asset = asset else { return nil }
        
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
    
}
