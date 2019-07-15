//
//  FullscreenViewController.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

class FullscreenViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var photo: UIImage?
    var photoTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
}

// MARK: - Configuration
private extension FullscreenViewController {
    
    func configureView() {
        imageView.image = photo
        titleLabel.text = photoTitle
    }
    
}

// MARK: - Actions
private extension FullscreenViewController {
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
