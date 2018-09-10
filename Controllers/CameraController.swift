//
//  CameraController.swift
//  Neonsight
//
//  Created by Max Surgai on 04.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

class CameraController {
    
    
    // MARK: - Properties
    
    static var camera: Camera!
    
    
    
    // MARK: - Methods
    
    class func startCameraSession(sender: ViewController) {
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            
            do {
                CameraController.camera = try Camera(sessionPreset:.high)
                let filter = RGBAdjustment()
                CameraController.camera --> filter --> sender.cameraView
                CameraController.camera.startCapture()
            } catch {
                fatalError("Could not initialize rendering pipeline: \(error)")
            }

        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (authorized) in
                DispatchQueue.main.async {
                    if authorized {
                        CameraController.startCameraSession(sender: sender)
                    }
                }
            })
        }
        
    }
    
//
//    static var imageOutput: AVCapturePhotoOutput!
//    static var previewLayer: AVCaptureVideoPreviewLayer!
//    static let sampleBufferQueue = DispatchQueue.global(qos: .userInteractive)
//    static var cameraPosition: AVCaptureDevice.Position = .back
//
//    // MARK: - Methods
//
//    // FUNC - Change cam
//
//    class func changeCamera() {
//        do {
//            let currentCameraInput: AVCaptureInput = CameraController.captureSession.inputs[0]
//            CameraController.captureSession.removeInput(currentCameraInput)
//            var newCamera: AVCaptureDevice
//            if CameraController.cameraPosition == .back {
//                newCamera = CameraController.findCamera(position: .front)!
//                CameraController.cameraPosition = .front
//            } else {
//                newCamera = CameraController.findCamera(position: .back)!
//                CameraController.cameraPosition = .back
//            }
//            let newInput = try AVCaptureDeviceInput(device: newCamera)
//            CameraController.captureSession.addInput(newInput)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    // FUNCTION - Find Camera
//
//    class public func findCamera(position:AVCaptureDevice.Position) -> AVCaptureDevice? {
//        let deviceTypes: [AVCaptureDevice.DeviceType] = [
//            .builtInDualCamera,
//            .builtInTelephotoCamera,
//            .builtInWideAngleCamera
//        ]
//
//        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
//                                                         mediaType: .video,
//                                                         position: position)
//
//        return discovery.devices.first
//    }
//
//
//    // FUNCTION - Setup capture session
//
//    class func setupCaptureSession(forVideo isVideoSession: Bool, sender: AVCaptureVideoDataOutputSampleBufferDelegate) {
//        guard CameraController.captureSession.inputs.isEmpty else { return }
//        guard let camera = CameraController.findCamera(position: .back) else {
//            print("No camera found")
//            return
//        }
//
//        do {
////            let connection = AVCaptureConnection(connectionWithMediaType: .photo)
//            try camera.lockForConfiguration()
//            camera.activeVideoMinFrameDuration = CMTimeMake(1, 15)
//            camera.activeVideoMaxFrameDuration = CMTimeMake(1, 15)
//            camera.unlockForConfiguration()
//
//            let input = try AVCaptureDeviceInput(device: camera)
//            CameraController.captureSession.addInput(input)
//            if isVideoSession == true {
//                let output = AVCaptureVideoDataOutput()
//                output.alwaysDiscardsLateVideoFrames = true
//                output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: Int(kCVPixelFormatType_32BGRA)]
//                output.setSampleBufferDelegate(sender, queue: CameraController.sampleBufferQueue)
//                CameraController.captureSession.addOutput(output)
//                CameraController.captureSession.startRunning()
//            } else {
//                CameraController.imageOutput = AVCapturePhotoOutput()
//
//                CameraController.captureSession.addOutput(CameraController.imageOutput)
//                CameraController.setupLivePreview(sender: sender as! ViewController)
////                CameraController.captureSession.startRunning()
//            }
//
//            //            DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
//            //                self.captureSession.startRunning()
//            //                DispatchQueue.main.async {
//            //                    self.previewLayer.frame = self.cameraView.bounds
//            //                }
//            //            }
//
//        } catch let e {
//            print("Error creating capture session: \(e)")
//            return
//        }
//    }
//
//    // FUNCTION - Live preview of cam
//
//    static func setupLivePreview(sender: ViewController) {
//
//        CameraController.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        CameraController.previewLayer.videoGravity = .resizeAspect
//        CameraController.previewLayer.connection?.videoOrientation = .portrait
//        sender.cameraImageView.layer.addSublayer(CameraController.previewLayer)
//
//        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
//            CameraController.captureSession.startRunning()
//            DispatchQueue.main.async {
//                CameraController.previewLayer.frame = sender.cameraImageView.bounds
//            }
//        }
//    }
//
//    // FUNC - Share photo
//

}
