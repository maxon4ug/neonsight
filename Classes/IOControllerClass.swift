//
//  IOController.swift
//  Neonsight
//
//  Created by Max Surgai on 05.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit
import AVFoundation

class IOController {
    
    // MARK: - Properties
    
    
    
    // MARK: - Methods
    
    class func exportImage(image: UIImage, sender: ViewController) {
        
        let activityViewController = UIActivityViewController(activityItems: [ image ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender.view
        //        activityViewController.excludedActivityTypes = [ .airDrop ]
        //        activityViewController.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
        //
        //        }
        sender.present(activityViewController, animated: true, completion: {
            sender.changeCameraButton.alpha = 0.3
        })
    }
    
    
    //
    class func importImage(sender: ViewController) {
        sender.imagePicker.allowsEditing = false
        sender.imagePicker.sourceType = .photoLibrary
        /*
         UIImagePickerControllerSourceType.PhotoLibrary
         UIImagePickerControllerSourceType.Camera
         UIImagePickerControllerSourceType.SavedPhotosAlbum
         */
        sender.present(sender.imagePicker, animated: true, completion: nil)
    }
    
}
