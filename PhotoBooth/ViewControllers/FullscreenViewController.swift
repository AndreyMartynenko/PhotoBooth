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
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
}

// MARK: - Configuration
private extension FullscreenViewController {
    
    func configureView() {
        imageView.image = photo
    }
    
}

// MARK: - Actions
private extension FullscreenViewController {
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
