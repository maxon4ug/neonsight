//
//  UIImagePickerControllerExtensions.swift
//  Neonsight
//
//  Created by Max Surgai on 10.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return nil
    }
    
    open override var prefersStatusBarHidden: Bool {
        return true
    }
}
