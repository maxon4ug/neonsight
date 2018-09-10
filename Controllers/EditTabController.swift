//
//  EditTabControllerClass.swift
//  Neonsight
//
//  Created by Max Surgai on 06.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class EditTabController {
    
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
    static var setX = UIScreen.main.bounds.width / 2.0
    static var changeValue: Int!
    
    //doubletap
    static var tapTime = Date(timeIntervalSince1970: 0)
    
    static let step = (UIScreen.main.bounds.width / 2.0) / 70.0
    static var selectedEditToolNum = 0
    static var newSelectedEditToolNum = 0
    
    static let editToolList = [
        EditTool(name: "Exposure", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Contrast", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Brightness", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Details", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Contrast", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Brightness", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Details", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Contrast", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "Brightness", value: 0, maxValue: 100, minValue: -100),
        EditTool(name: "empty", value: 0, maxValue: 0, minValue: 0)
    ]
    
    
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
        setSelectedEditTool(num: 0)
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
            } else if gestureDemention == 1 {
                //horizontal
                let shift = (location.x - startX)
                changeValue = getChangeValue(shift: shift)
                var currentValue = changeValue + Int(editToolList[selectedEditToolNum].value)
                if currentValue >= Int(editToolList[newSelectedEditToolNum].maxValue) {
                    currentValue = Int(editToolList[newSelectedEditToolNum].maxValue)
                    changeValue = 0
                    editToolList[selectedEditToolNum].value = editToolList[newSelectedEditToolNum].maxValue
                    if location.x > lastX {
                        lastX = location.x
                        startX = location.x
                    }
                } else if currentValue <= Int(editToolList[newSelectedEditToolNum].minValue) {
                    currentValue = Int(editToolList[newSelectedEditToolNum].minValue)
                    changeValue = 0
                    editToolList[selectedEditToolNum].value = editToolList[newSelectedEditToolNum].minValue
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
                    selectedEditToolNum = editToolList.count - 3
                }
                updateEditPanelPosition(y: editPanelListViewCurrentPosition)
                updateSelectedCell()
            }
        }
        else {
            if gestureDemention == 1 {
                let currentValue = changeValue + Int(editToolList[selectedEditToolNum].value)
                if currentValue >= Int(editToolList[newSelectedEditToolNum].maxValue) {
                    editToolList[selectedEditToolNum].value = editToolList[newSelectedEditToolNum].maxValue
                } else if currentValue <= Int(editToolList[newSelectedEditToolNum].minValue) {
                    editToolList[selectedEditToolNum].value = editToolList[newSelectedEditToolNum].minValue
                } else {
                    editToolList[selectedEditToolNum].value = Double(currentValue)
                }
                //
                updateEditPanelSelectView()
            } else if gestureDemention == 2 {
                //vertical
                setSelectedEditTool(num: newSelectedEditToolNum)
                UIView.animate(withDuration: 0.2) {
                    viewController.editNabBarView.alpha = 1.0
                }
                UIView.animate(withDuration: 0.2) {
                    viewController.editPanelView.alpha = 0.0
                }
            } else {
                if Date().timeIntervalSince(tapTime) <= 0.3  {
                    editToolList[selectedEditToolNum].clearValue()
                    updateEditNavBarValue()
                }
                tapTime = Date()
            }
            gestureDemention = 0
            viewController.editPanelTableView.reloadData()
        }
    }
    
    //
    class func getChangeValue(shift: CGFloat) -> Int {
        let percentage = (shift / step)
        let value = CGFloat(editToolList[newSelectedEditToolNum].maxValue / 100.0) * percentage
        return Int(value)
    }
    
    //
    class func updateEditNavBarValue(newValue: Int = Int(editToolList[selectedEditToolNum].value)) {
        viewController.editNavBarLabel.fadeTransition(0.1)
        if selectedEditToolNum != 1 {
            viewController.editNavBarLabel.text = "\(newValue > 0 ? editToolList[selectedEditToolNum].name + " +" : editToolList[selectedEditToolNum].name + " ")\(newValue)"
        } else {
            viewController.editNavBarLabel.text = "\(editToolList[selectedEditToolNum].name) \(newValue)"
        }
        updateValueGradientView(newValue: newValue)
    }
    
    //
    class func updateEditPanelPosition(y: CGFloat = maxY) {
        viewController.editPanelListView.frame = CGRect(x: (UIScreen.main.bounds.width - viewController.editPanelListView.frame.width) / 2.0, y: y, width: viewController.editPanelListView.frame.width, height: viewController.editPanelListView.frame.height)
    }
    
    //
    class func updateSelectedCell() {
        for cellIndexPath in viewController.editPanelTableView.indexPathsForVisibleRows! {
            let cell = viewController.editPanelTableView.cellForRow(at: cellIndexPath) as! EditToolTableViewCell
            let cellPosition = viewController.editPanelTableView.convert(cell.layer.position, to: viewController.view)
            if cellPosition.y <= (UIScreen.main.bounds.height / 2.0 + cellSize / 2.0) && cellPosition.y >= (UIScreen.main.bounds.height / 2.0 - cellSize / 2.0) {
                guard currentCell != cellIndexPath.row else { return }
                setSelectedEditTool(num: cellIndexPath.row, asNew: true)
            }
        }
    }
    
    //
    class func setSelectedEditTool(num: Int, asNew: Bool = false) {
        currentCell = num
        newSelectedEditToolNum = num
        updateEditPanelSelectView()
        guard asNew == false else { return }
        selectedEditToolNum = num
        updateEditNavBarValue()
    }
    
    //
    class func updateEditPanelSelectView() {
        viewController.editPanelSelectNameLabel.fadeTransition(0.15)
        viewController.editPanelSelectValueLabel.fadeTransition(0.15)
        viewController.editPanelSelectNameLabel.text = editToolList[newSelectedEditToolNum].name
        if newSelectedEditToolNum != 1 {
            viewController.editPanelSelectValueLabel.text = "\(editToolList[newSelectedEditToolNum].value > 0 ? "+" : "")\(editToolList[newSelectedEditToolNum].value)"
        } else {
            viewController.editPanelSelectValueLabel.text = "\(editToolList[newSelectedEditToolNum].value)"
        }
    }
    
    //
    class func updateValueGradientView(newValue: Int = Int(editToolList[selectedEditToolNum].value)) {
        let percentage = CGFloat(newValue) / CGFloat(editToolList[newSelectedEditToolNum].maxValue)
        viewController.editNavBarValueGradientMaskView.frame = CGRect(x: UIScreen.main.bounds.width / 2.0, y: 0, width: UIScreen.main.bounds.width / 2.0 * percentage, height: viewController.editNavBarValueGradientMaskView.frame.height)
        viewController.editNavBarValueGradientView.layer.mask = viewController.editNavBarValueGradientMaskView.layer
    }
}

