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
    
    static var startX: CGFloat!
    static var startY: CGFloat!
    static var gestureDemention = 0 // 1 - horizontal, 2 - vertical
    static var lastX: CGFloat!
    static var lastY = (UIScreen.main.bounds.height / 2.0) - 51.0
    static var changeValue: Int!
    static var setValue = 0
    static let step = CGFloat(3.2)
    static var editName = "Exposure"
    static let maxValue = 100
    static let minValue = -100
    
    
    
    // MARK: - Methods
    
    class func setupGestureRecognizer(sender: ViewController) {
        viewController = sender
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.delaysTouchesBegan = true
        longPress.minimumPressDuration = 0.0
        longPress.delegate = sender
        sender.cameraView.addGestureRecognizer(longPress)
        
    }
    
    //
    @objc class func handleLongPress(gesture: UILongPressGestureRecognizer) {
        guard UIController.activeTab == 2 else {
            return
        }
        if gesture.state == UIGestureRecognizerState.began {
            startX = gesture.location(in: viewController.cameraView).x
            startY = gesture.location(in: viewController.cameraView).y
            lastX = gesture.location(in: viewController.cameraView).x
        } else if gesture.state == UIGestureRecognizerState.changed {
            let location = gesture.location(in: viewController.cameraView)
            if gestureDemention == 0 {
                if abs(Int32(startX - location.x)) > abs(Int32(startY - location.y)) {
                    gestureDemention = 1 //horizontal
                } else {
                    gestureDemention = 2 //vertical
                    UIView.animate(withDuration: 0.2) {
                        viewController.editNabBarView.alpha = 0.0
                    }
                    UIView.animate(withDuration: 0.2) {
                        viewController.editPanelView.alpha = 1.0
                    }
                    UIView.animate(withDuration: 0.2) {
                        viewController.editPanelSelectView.alpha = 1.0
                    }
                }
            } else if gestureDemention == 1 {
                //horizontal
                let shift = (location.x - startX)
                changeValue = getChangeValue(shift: shift, maxValue: maxValue, minValue: minValue)
                var currentValue = changeValue + setValue
                if currentValue >= maxValue {
                    currentValue = maxValue
                    changeValue = 0
                    setValue = maxValue
                    if location.x > lastX {
                        lastX = location.x
                        startX = location.x
                    }
                } else if currentValue <= minValue {
                    currentValue = minValue
                    changeValue = 0
                    setValue = minValue
                    if location.x < lastX {
                        lastX = location.x
                        startX = location.x
                    }
                }
                
                viewController.editNavBarLabel.text = "\(currentValue > 0 ? editName + " +" : editName + " ")\(currentValue)"
                
            } else {
                //vertical
                let shift = (location.y - startY)
                //                changeValue = getChangeValue(shift: shift, maxValue: maxValue, minValue: minValue)
                viewController.editPanelView.frame = CGRect(x: (UIScreen.main.bounds.width - viewController.editPanelView.frame.width) / 2.0, y: lastY + shift, width: viewController.editPanelView.frame.width, height: viewController.editPanelView.frame.height)
                
                
                let rectOfCellInTableView = viewController.editPanelTableView.rectForRow(at: (viewController.editPanelTableView.indexPathsForVisibleRows?.last)!)
                let rectOfCellInSuperview = viewController.editPanelTableView.convert(rectOfCellInTableView, to: viewController.view)
            }
        }
        else {
            if gestureDemention == 1 {
                let shift = (gesture.location(in: viewController.cameraView).x - startX)
                setValue += getChangeValue(shift: shift, maxValue: 100, minValue: 100)
                if setValue >= maxValue {
                    lastX = 0.0
                } else {
                    lastX = UIScreen.main.bounds.width
                }
            } else {
                //vertical
                UIView.animate(withDuration: 0.2) {
                    viewController.editNabBarView.alpha = 1.0
                }
                UIView.animate(withDuration: 0.2) {
                    viewController.editPanelView.alpha = 0.0
                }
                UIView.animate(withDuration: 0.2) {
                    viewController.editPanelSelectView.alpha = 0.0
                }
            }
            gestureDemention = 0
        }
    }
    
    
    class func getChangeValue(shift: CGFloat, maxValue: Int, minValue: Int) -> Int {
        let percentage = (shift / step)
        let value = CGFloat(maxValue) / 100 * percentage
        return Int(value)
    }
    
}




