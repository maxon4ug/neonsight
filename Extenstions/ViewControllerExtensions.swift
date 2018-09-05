//
//  ViewControllerExtensions.swift
//  Neonsight
//
//  Created by Max Surgai on 04.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        //        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        //        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        //        let uiImage = UIImage(ciImage: ciImage)
        //        DispatchQueue.main.sync {
        //            for filterImageView in self.filtersImageViewList {
        //                filterImageView.image = uiImage
        //            }
        //        }
        
        connection.videoOrientation = .portrait
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let ciImage = CIImage(cvImageBuffer: pixelBuffer!)
        //            let pixelBufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer!))
        //            let pixelBufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer!))
        //            let imageRect: CGRect = CGRect(x: 0, y: 0, width: pixelBufferWidth, height: pixelBufferHeight)
        //            let cgimage = self.ciContext.createCGImage(ciImage, from: imageRect)
        
        let bwFilter = CIFilter(name: "CIColorControls")!
        bwFilter.setValuesForKeys([kCIInputImageKey:ciImage, kCIInputBrightnessKey:NSNumber(value: 0.0), kCIInputContrastKey:NSNumber(value: 1.1), kCIInputSaturationKey:NSNumber(value: 0.0)])
        let bwFilterOutput = (bwFilter.outputImage)!
        
        // Adjust exposure
        let exposureFilter = CIFilter(name: "CIExposureAdjust")!
        exposureFilter.setValuesForKeys([kCIInputImageKey:bwFilterOutput, kCIInputEVKey:NSNumber(value: 1.7)])
        
//        let cgImage = self.ciContext.createCGImage(exposureFilter.outputImage!, from: ciImage.extent)!
//        let image = UIImage(cgImage: cgImage)
//        DispatchQueue.main.async {
//            self.cameraImageView.image = image
//        }
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        //        guard  let ciImage = CIImage(data: imageData) else { return }
        //        let comicEffect = CIFilter(name: "CIComicEffect")
        //        comicEffect!.setValue(ciImage, forKey: kCIInputImageKey)
        //        let cgImage = self.ciContext.createCGImage(comicEffect!.outputImage!, from: ciImage.extent)!
        let image = UIImage(data: imageData)
        CameraController.sharePhoto(sender: self, image: image!)
    }
}

