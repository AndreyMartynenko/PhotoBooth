//
//  ErrorView.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

class ErrorView: NibView {
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alpha = 0
        errorLabel.text = nil
    }
    
    func show(withTitle title: String) {
        errorLabel.text = title
        
        alpha = 1
        superview?.bringSubviewToFront(self)
    }
    
    func hide() {
        superview?.sendSubviewToBack(self)
        alpha = 0
    }
    
}
