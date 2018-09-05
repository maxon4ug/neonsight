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
    
    
    class func export(image: UIImage, sender: UIViewController) {
        
        let activityViewController = UIActivityViewController(activityItems: [ image ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender.view
        //        activityViewController.excludedActivityTypes = [ .airDrop ]
        //        activityViewController.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
        //
        //        }
        sender.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
