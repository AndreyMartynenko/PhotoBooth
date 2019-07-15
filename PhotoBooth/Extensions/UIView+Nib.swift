//
//  UIView+Nib.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /** Loads instance from nib with the same name. */
    func loadFromNib() -> UIView? {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return nil }
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
