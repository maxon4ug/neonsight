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
    static var gestureDemention = 0 // 1 - horizontal, 2 - vertical
    
    //vetical
    static var startY: CGFloat!
    static var maxY: CGFloat!
    static var minY: CGFloat!
    static var cellSize: CGFloat!
    static let headerSize: CGFloat = 30.0
    static var currentCell = 0
    
    //horizontal
    static var startX: CGFloat!
    static var lastX: CGFloat!
    static var changeValue: Int!
    static var setValue = 0
    
    //doubletap
    static var tapCount = 0
    static var tapTime = Date()
    
    static let step = (UIScreen.main.bounds.width / 2.0) / 60.0
    static var selectedEditToolNum = 0
    static var newSelectedEditToolNum = 0
    static var editName = "Exposure"
    static let maxValue = 100
    static let minValue = -100
    
    
    // MARK: - Methods
    
    class func setupGestureRecognizer(sender: ViewController) {
        viewController = sender
        //
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.delaysTouchesBegan = true
        longPress.minimumPressDuration = 0.0
        longPress.delegate = sender
        sender.cameraView.addGestureRecognizer(longPress)
        //
        cellSize = viewController.editPanelTableView.rectForRow(at: (viewController.editPanelTableView.indexPathsForVisibleRows?.first)!).height
        maxY = (UIScreen.main.bounds.height / 2.0) - (cellSize / 2.0) - headerSize
        minY = (UIScreen.main.bounds.height / 2.0) + (cellSize / 2.0) + headerSize - sender.editPanelListView.frame.height
        updateEditNavBarValue()
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
                
                    if abs(Int32((startX - location.x) / step)) > 5 {
                        startX = location.x
                        gestureDemention = 1 //horizontal
                    } else if abs(Int32((startY - location.y) / step)) > 5 {
                        startX = location.y
                        gestureDemention = 2 //vertical
                        updateEditPanelPosition(y: maxY - (CGFloat(selectedEditToolNum) * cellSize))
                        updateSelectedCell()
                        UIView.animate(withDuration: 0.2) {
                            viewController.editNabBarView.alpha = 0.0
                        }
                        UIView.animate(withDuration: 0.2) {
                            viewController.editPanelView.alpha = 1.0
                        }
                    }
                
//                if abs(Int32(startX - location.x)) > abs(Int32(startY - location.y)) {
//                    gestureDemention = 1 //horizontal
//                } else {
//                    gestureDemention = 2 //vertical
//                    updateEditPanelPosition(y: maxY - (CGFloat(selectedEditToolNum) * cellSize))
//                    updateSelectedCell()
//                    UIView.animate(withDuration: 0.2) {
//                        viewController.editNabBarView.alpha = 0.0
//                    }
//                    UIView.animate(withDuration: 0.2) {
//                        viewController.editPanelView.alpha = 1.0
//                    }
//
//                }
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
                updateEditNavBarValue(newValue: currentValue)
            } else {
                //vertical
                let shift = (location.y - startY)
                var editPanelListViewCurrentPosition = maxY - (CGFloat(selectedEditToolNum) * cellSize) + shift
                if editPanelListViewCurrentPosition > maxY {
                    editPanelListViewCurrentPosition = maxY
                    startY = location.y
                    selectedEditToolNum = 0
                } else if editPanelListViewCurrentPosition < minY {
                    editPanelListViewCurrentPosition = minY
                    startY = location.y
                    selectedEditToolNum = viewController.editToolList.count - 2
                }
                updateEditPanelPosition(y: editPanelListViewCurrentPosition)
                updateSelectedCell()
            }
        }
        else {
            if gestureDemention == 1 {
                let currentValue = changeValue + setValue
                if currentValue >= maxValue {
                    setValue = maxValue
                } else if currentValue <= minValue {
                    setValue = minValue
                } else {
                    setValue = currentValue
                }
                viewController.editToolValueList[selectedEditToolNum] = setValue
                //
                updateEditPanelSelectView()
            } else if gestureDemention == 2 {
                //vertical
                selectedEditToolNum = newSelectedEditToolNum
                updateEditNavBarValue()
                UIView.animate(withDuration: 0.2) {
                    viewController.editNabBarView.alpha = 1.0
                }
                UIView.animate(withDuration: 0.2) {
                    viewController.editPanelView.alpha = 0.0
                }
            } else {
                tapCount += 1
                if tapCount == 1 {
                    tapTime = Date()
                } else {
                    if Date().timeIntervalSince(tapTime) <= 0.3  {
                        let defaultValue = 0
                        setValue = defaultValue
                        viewController.editToolValueList[selectedEditToolNum] = defaultValue
                        updateEditNavBarValue()
                    }
                    tapCount = 0
                }
            }
            gestureDemention = 0
            viewController.editPanelTableView.reloadData()
        }
    }
    
    //
    class func getChangeValue(shift: CGFloat, maxValue: Int, minValue: Int) -> Int {
        let percentage = (shift / step)
        let value = CGFloat(maxValue) / 100 * percentage
        return Int(value)
    }
    
    //
    class func updateEditNavBarValue(newValue: Int = setValue) {
        if selectedEditToolNum != 1 {
            viewController.editNavBarLabel.text = "\(newValue > 0 ? editName + " +" : editName + " ")\(newValue)"
        } else {
            viewController.editNavBarLabel.text = "\(editName) \(newValue)"
        }
        updateValueGradientView(newValue: newValue)
    }
    
    //
    class func updateEditPanelPosition(y: CGFloat) {
        viewController.editPanelListView.frame = CGRect(x: (UIScreen.main.bounds.width - viewController.editPanelListView.frame.width) / 2.0, y: y, width: viewController.editPanelListView.frame.width, height: viewController.editPanelListView.frame.height)
    }
    
    //
    class func updateSelectedCell() {
        for cellIndexPath in viewController.editPanelTableView.indexPathsForVisibleRows! {
            let cell = viewController.editPanelTableView.cellForRow(at: cellIndexPath) as! EditPanelTableViewCell
            let cellPosition = viewController.editPanelTableView.convert(cell.layer.position, to: viewController.view)
            if cellPosition.y <= (UIScreen.main.bounds.height / 2.0 + cellSize / 2.0) && cellPosition.y >= (UIScreen.main.bounds.height / 2.0 - cellSize / 2.0) {
                guard currentCell != cellIndexPath.row else { return }
                currentCell = cellIndexPath.row
                setSelectedEditTool(num: cellIndexPath.row)
            }
        }
    }
    
    //
    class func setSelectedEditTool(num: Int) {
        newSelectedEditToolNum = num
        setValue = viewController.editToolValueList[num]
        editName = viewController.editToolList[num]
        updateEditPanelSelectView()
        //        maxValue =
        //        minValue
    }
    
    //
    class func updateEditPanelSelectView() {
        viewController.editPanelSelectNameLabel.fadeTransition(0.2)
        viewController.editPanelSelectValueLabel.fadeTransition(0.2)
        viewController.editPanelSelectNameLabel.text = viewController.editToolList[newSelectedEditToolNum]
        if newSelectedEditToolNum != 1 {
            viewController.editPanelSelectValueLabel.text = "\(setValue > 0 ? "+" : "")\(setValue)"
        } else {
            viewController.editPanelSelectValueLabel.text = "\(setValue)"
        }
    }
    
    //
    class func updateValueGradientView(newValue: Int = setValue) {
        let percentage = CGFloat(newValue) / CGFloat(maxValue)
        if newValue > 0 {
            viewController.editNavBarValueGradientMaskView.frame = CGRect(x: UIScreen.main.bounds.width / 2.0, y: 0, width: UIScreen.main.bounds.width / 2.0 * percentage, height: viewController.editNavBarValueGradientMaskView.frame.height)
        } else {
            viewController.editNavBarValueGradientMaskView.frame = CGRect(x: (UIScreen.main.bounds.width / 2.0), y: 0, width: UIScreen.main.bounds.width / 2.0 * percentage, height: viewController.editNavBarValueGradientMaskView.frame.height)
        }
        viewController.editNavBarValueGradientView.layer.mask = viewController.editNavBarValueGradientMaskView.layer
    }
}

