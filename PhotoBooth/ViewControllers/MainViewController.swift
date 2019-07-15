//
//  MainViewController.swift
//  PhotoBooth
//
//  Created by Martynenko Andriy on 15.07.19.
//  Copyright © 2019 Martynenko Andriy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet private weak var previewView: UIView!
    @IBOutlet private weak var capturedImageView: UIImageView!
    
    private var captureSession: AVCaptureSession!
    private var captureOutput: AVCapturePhotoOutput!
    
    private var currentCaptureDevice: AVCaptureDevice?
    
    private var photoSettings: AVCapturePhotoSettings {
        let photoSettings: AVCapturePhotoSettings
        if #available(iOS 11.0, *) {
            photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        } else {
            photoSettings = AVCapturePhotoSettings()
            if let previewPixelFormatType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
                photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelFormatType]
            }
        }
        
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.flashMode = .off
        photoSettings.isHighResolutionPhotoEnabled = true
        
        return photoSettings
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        captureOutput = AVCapturePhotoOutput()
        captureSession = AVCaptureSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        captureSession.stopRunning()
    }
    
}

// MARK: - Configuration
private extension MainViewController {
    
    func configureView() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
    }
    
    func configureCaptureSession() {
        captureSession.beginConfiguration()
        
        captureSession.sessionPreset = .photo
        
        guard configureCaptureInput(at: .front) && configureCaptureOutput() else {
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.commitConfiguration()
    }
    
    @discardableResult
    func configureCaptureInput(at position: AVCaptureDevice.Position) -> Bool {
        if let currentCaptureInput = captureSession.inputs.first {
            captureSession.removeInput(currentCaptureInput)
        }
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else { return false }
        guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else { return false }
        guard captureSession.canAddInput(captureInput) else { return false }
        
        currentCaptureDevice = captureDevice
        captureSession.addInput(captureInput)
        
        return true
    }
    
    func configureCaptureOutput() -> Bool {
        guard captureSession.canAddOutput(captureOutput) else { return false }
        
        captureOutput.isHighResolutionCaptureEnabled = true
        captureOutput.isLivePhotoCaptureEnabled = captureOutput.isLivePhotoCaptureSupported
        captureOutput.connection(with: .video)?.videoOrientation = .landscapeRight
        
        captureSession.addOutput(captureOutput)
        
        return true
    }
    
}

// MARK: - Actions
private extension MainViewController {
    
    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        captureOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        view.bringSubviewToFront(previewView)
    }
    
}

extension MainViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        guard error == nil else { return }
        guard let sampleBuffer = photoSampleBuffer else { return }
        guard let previewBuffer = previewPhotoSampleBuffer else { return }
        guard let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) else { return }
        
        updateImage(UIImage(data: dataImage))
    }
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else { return }
        guard let dataImage = photo.fileDataRepresentation() else { return }
        
        updateImage(UIImage(data: dataImage))
    }
    
    private func updateImage(_ image: UIImage?) {
        capturedImageView.image = image
        view.bringSubviewToFront(capturedImageView)
    }
    
}