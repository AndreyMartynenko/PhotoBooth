//
//  NibView.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

class NibView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
}

// MARK: - Private methods
private extension NibView {
    
    func xibSetup() {
        backgroundColor = .clear
        guard let nibView = loadFromNib() else { return }
        
        view = nibView
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // adding custom subview on top of the view
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
    }
    
}
