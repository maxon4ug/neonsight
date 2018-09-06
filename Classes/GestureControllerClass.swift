//
//  GestureControllerClass.swift
//  Neonsight
//
//  Created by Max Surgai on 06.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class GestureController {
    
    // MARK: - Properties
    
    static var viewController: ViewController!
    
    static var startX = CGFloat(0.0)
    static var startY = CGFloat(0.0)
    static var gestureDemention = 0 // 1 - horizontal, 2 - vertical
    static var lastX = UIScreen.main.bounds.width / 2.0
    static var changeValue = 0
    static var setValue = 0
    static let step = UIScreen.main.bounds.width / 120.0
    static var editName = "Exposure"
    static let maxValue = 100
    static let minValue = -100
    
    // MARK: - Methods
    
    class func setupGestureRecognizer(sender: ViewController) {
        GestureController.viewController = sender
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.delaysTouchesBegan = true
        longPress.minimumPressDuration = 0.0
        longPress.delegate = sender
        sender.cameraView.addGestureRecognizer(longPress)
        
    }
    
    //
    @objc class func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.began {
            GestureController.startX = gesture.location(in: viewController.cameraView).x
            GestureController.startY = gesture.location(in: viewController.cameraView).y
            GestureController.lastX = gesture.location(in: viewController.cameraView).x
        } else if gesture.state == UIGestureRecognizerState.changed {
            let location = gesture.location(in: viewController.cameraView)
            if GestureController.gestureDemention == 0 {
                if abs(Int32(GestureController.startX - location.x)) > abs(Int32(GestureController.startY - location.y)) {
                    GestureController.gestureDemention = 1 //horizontal
                } else {
                    GestureController.gestureDemention = 2 //vertical
                }
            } else if GestureController.gestureDemention == 1 {
                //horizontal
                let shift = (location.x - GestureController.startX)
                GestureController.changeValue = GestureController.getChangeValue(shift: shift, maxValue: maxValue, minValue: minValue)
                var currentValue = GestureController.changeValue + GestureController.setValue
                if currentValue >= GestureController.maxValue {
                    currentValue = GestureController.maxValue
                    GestureController.changeValue = 0
                    GestureController.setValue = GestureController.maxValue
                    if location.x > GestureController.lastX {
                        GestureController.lastX = location.x
                        GestureController.startX = location.x
                    }
                } else if currentValue <= GestureController.minValue {
                    currentValue = GestureController.minValue
                    GestureController.changeValue = 0
                    GestureController.setValue = minValue
                    if location.x < GestureController.lastX {
                        GestureController.lastX = location.x
                        GestureController.startX = location.x
                    }
                }
                
                GestureController.viewController.editNavBarLabel.text = "\(currentValue > 0 ? GestureController.editName + " +" : GestureController.editName + " ")\(currentValue)"
                
            } else {
                //vertical
                
            }
        }
        else {
            let shift = (gesture.location(in: viewController.cameraView).x - GestureController.startX)
            GestureController.setValue += GestureController.getChangeValue(shift: shift, maxValue: 100, minValue: 100)
            GestureController.gestureDemention = 0
            if GestureController.setValue >= GestureController.maxValue {
                GestureController.lastX = 0.0
            } else {
                GestureController.lastX = UIScreen.main.bounds.width
            }
        }
    }
    
    
    class func getChangeValue(shift: CGFloat, maxValue: Int, minValue: Int) -> Int {
        let percentage = (shift / GestureController.step)
        let value = CGFloat(maxValue) / 100 * percentage
        return Int(value)
    }
    
}



