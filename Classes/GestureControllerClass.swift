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
    static let halfCellSize: CGFloat = 55.0 / 2.0
    static let headerSize: CGFloat = 30.0
    
    //horizontal
    static var startX: CGFloat!
    static var lastX: CGFloat!
    static var changeValue: Int!
    static var setValue = 0
    
    static let step = CGFloat(3.2)
    static var selectedEditToolNum = 0
    static var newSelectedEditToolNum = 0
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
        cellSize = viewController.editPanelTableView.rectForRow(at: (viewController.editPanelTableView.indexPathsForVisibleRows?.first)!).height
        maxY = (UIScreen.main.bounds.height / 2.0) - (cellSize / 2.0) - headerSize
        minY = (UIScreen.main.bounds.height / 2.0) + halfCellSize + headerSize - sender.editPanelListView.frame.height
//        viewController.editPanelListView.frame = CGRect(x: (UIScreen.main.bounds.width - viewController.editPanelListView.frame.width) / 2.0, y: maxY, width: viewController.editPanelListView.frame.width, height: viewController.editPanelListView.frame.height)
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
                    updateEditPanelPosition(y: maxY - (CGFloat(selectedEditToolNum) * cellSize))
                    updateSelectedCell()
                    UIView.animate(withDuration: 0.2) {
                        viewController.editNabBarView.alpha = 0.0
                    }
                    UIView.animate(withDuration: 0.2) {
                        viewController.editPanelView.alpha = 1.0
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
                let shift = (gesture.location(in: viewController.cameraView).x - startX)
                let currentValue = setValue + getChangeValue(shift: shift, maxValue: 100, minValue: 100)
                if currentValue >= maxValue {
                    setValue = maxValue
                } else if currentValue <= minValue {
                    setValue = minValue
                } else {
                    setValue = currentValue
                }
                viewController.editToolValueList[selectedEditToolNum] = setValue
                updateEditPanelSelectedValue()
            } else {
                //vertical
                UIView.animate(withDuration: 0.2) {
                    viewController.editNabBarView.alpha = 1.0
                }
                UIView.animate(withDuration: 0.2) {
                    viewController.editPanelView.alpha = 0.0
                }
                selectedEditToolNum = newSelectedEditToolNum
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
    class func setSelectedEditTool(num: Int) {
        newSelectedEditToolNum = num
        setValue = viewController.editToolValueList[num]
        viewController.editPanelSelectNameLabel.text = viewController.editToolList[num]
        updateEditPanelSelectedValue()
        editName = viewController.editToolList[num]
    }
    
    //
    class func updateEditPanelSelectedValue() {
        if newSelectedEditToolNum != 1 {
            viewController.editNavBarLabel.text = "\(setValue > 0 ? editName + " +" : editName + " ")\(setValue)"
            viewController.editPanelSelectValueLabel.text = "\(setValue > 0 ? "+" : "")\(setValue)"
        } else {
            viewController.editNavBarLabel.text = "\(editName) \(setValue)"
            viewController.editPanelSelectValueLabel.text = "\(setValue)"
        }
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
                setSelectedEditTool(num: cellIndexPath.row)
                cell.nameLabel.alpha = 0.0
                cell.valueLabel.alpha = 0.0
            } else {
                cell.nameLabel.alpha = 0.8
                cell.valueLabel.alpha = 0.8
            }
        }
    }
}
