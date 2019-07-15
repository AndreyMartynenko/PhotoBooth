//
//  UIViewController+Instantiation.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiate<T: UIViewController>(withClass className: T.Type, storyboardName: String? = nil) -> T? {
        return storyboard(forClass: className, storyboardName: storyboardName)?.instantiateViewController(withIdentifier: String(describing: className.self)) as? T
    }
    
    static func instantiateAsInitial(withClass className: UIViewController.Type, storyboardName: String? = nil) -> UIViewController? {
        return storyboard(forClass: className, storyboardName: storyboardName)?.instantiateInitialViewController()
    }
    
}

// MARK: - Private methods
private extension UIViewController {
    
    static func storyboard(forClass className: UIViewController.Type, storyboardName: String? = nil) -> UIStoryboard? {
        let className = String(describing: className.self)
        let storyboardName = storyboardName ?? className
        
        guard Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil else { return nil }
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
}
