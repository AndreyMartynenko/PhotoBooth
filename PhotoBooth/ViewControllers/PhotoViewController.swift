//
//  PhotoViewController.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
}

// MARK: - Configuration
private extension PhotoViewController {
    
    func configureView() {
        photoImageView.image = photo
    }
    
}

// MARK: - Actions
private extension PhotoViewController {
    
    @IBAction private func cancelPhotoButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func savePhotoButtonTapped(_ sender: UIButton) {
        guard let image = photoImageView.image else { return }
        
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)
            let identifier = creationRequest.placeholderForCreatedAsset?.localIdentifier
            
            print("____identifier: \(identifier ?? "blah")")
        }) { (result, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
