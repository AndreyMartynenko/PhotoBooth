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
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var inputContainerViewBottomConstraint: NSLayoutConstraint!
    
    var photo: UIImage?
    
    private var photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopObservingKeyboardNotifications()
    }
    
}

// MARK: - Configuration
private extension PhotoViewController {
    
    func configureView() {
        photoImageView.image = photo
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func updateInputViewConstraints(isAppearing: Bool, height: CGFloat, duration: Double, curve: NSNumber) {
        inputContainerViewBottomConstraint.constant = inputViewHeight(withParentView: view, isKeyboardAppearing: isAppearing, keyboardHeight: height)
        
        UIView.animate(withDuration: duration, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(truncating: curve))], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func inputViewHeight(withParentView parentView: UIView, isKeyboardAppearing: Bool, keyboardHeight: CGFloat) -> CGFloat {
        var height = keyboardHeight
        if #available(iOS 11.0, *) {
            height -= parentView.safeAreaInsets.bottom
        }
        
        return -1 * (isKeyboardAppearing ? height : 0)
    }
    
}

// MARK: - Keyboard observers
private extension PhotoViewController {
    
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(processKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(processKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopObservingKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func processKeyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let isAppearing = notification.name == UIResponder.keyboardWillShowNotification
        let height = keyboardFrame.height
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber ?? 0
        
        updateInputViewConstraints(isAppearing: isAppearing, height: height, duration: duration, curve: curve)
    }
    
}

// MARK: - Actions
private extension PhotoViewController {
    
    @IBAction private func cancelButtonTapped(_ sender: UIButton) {
        titleTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func savePhotoButtonTapped(_ sender: UIButton) {
        guard let image = photoImageView.image else { return }
        
        titleTextField.resignFirstResponder()
        
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)
            self.savePhoto(withIdentifier: creationRequest.placeholderForCreatedAsset?.localIdentifier)
            
        }) { (result, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func viewTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
}

// MARK: - Private methods
private extension PhotoViewController {
    
    func savePhoto(withIdentifier localIdentifier: String?) {
        guard let localIdentifier = localIdentifier else { return }
        
        DispatchQueue.main.async {
            self.photoService.savePhoto(withIdentifier: localIdentifier, title: self.titleTextField.text)
        }
    }
    
}
