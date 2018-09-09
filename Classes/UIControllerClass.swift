//
//  UIControllerClass.swift
//  Neonsight
//
//  Created by Max Surgai on 07.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class UIController {
    
    // MARK: - Properties
    
    static var viewController: ViewController!
    static var activeTab = 1
    static var lightningMode = 0
    static var lightningModesList = ["lightningOff","lightningA","lightning","lightningT"]
    
    
    // MARK: - Methods
    
    class func setupUI(sender: ViewController) {
        UIController.viewController = sender

        UIController.viewController.editNavBarLabelBGView.layer.cornerRadius = UIController.viewController.editNavBarLabelBGView.frame.height / 2.0
        UIController.viewController.galleryPanelView.subviews.first!.layer.cornerRadius = UIController.viewController.galleryPanelView.frame.height / 2.0
        UIController.viewController.lightningPanelView.subviews.first!.layer.cornerRadius = UIController.viewController.lightningPanelView.frame.height / 2.0
        GestureController.setupGestureRecognizer(sender: sender)
        
    }
    
    
    //
    class func moveView(view: UIView, x: CGFloat, y: CGFloat, isHidden: Bool, completion: @escaping () -> () = {}) {
        if isHidden == false {
            view.isHidden = isHidden
        }
        let originalTransform = view.transform
        let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: y)
        UIView.animate(withDuration: 0.2, animations: {
            view.transform = scaledAndTranslatedTransform
        }, completion: { (finished) in
            view.isHidden = isHidden
            completion()
        })
    }
    
    
    //
    class func switchTab(to tabNum: UInt) {
        switch tabNum {
        case 1:
            if UIController.activeTab == 0 {
                UIController.activeTab = 1
                UIController.viewController.filtersTabButton.alpha = 1.0
                moveView(view: UIController.viewController.filtersPanelView, x: 0.0, y: -(UIController.viewController.filtersPanelView.frame.height), isHidden: false)
            } else if UIController.activeTab == 1 {
                UIController.activeTab = 0
                UIController.viewController.filtersTabButton.alpha = 0.3
                moveView(view: UIController.viewController.filtersPanelView, x: 0.0, y: UIController.viewController.filtersPanelView.frame.height, isHidden: true)
            } else {
                UIController.activeTab = 1
                UIController.viewController.filtersTabButton.alpha = 1.0
                UIController.viewController.editTabButton.alpha = 0.3
                
                UIView.animate(withDuration: 0.2, animations: {
                    UIController.viewController.editNabBarView.alpha = 0.0
                }) { (finished) in
                    UIController.viewController.editNabBarView.isHidden = true
                }
                moveView(view: UIController.viewController.lightningPanelView, x: UIController.viewController.lightningPanelView.frame.width - 22.0, y: 0.0, isHidden: false)
                moveView(view: UIController.viewController.galleryPanelView, x: -(UIController.viewController.galleryPanelView.frame.width - 22.0), y: 0.0, isHidden: false)
                moveView(view: UIController.viewController.filtersPanelView, x: 0.0, y: -(UIController.viewController.filtersPanelView.frame.height), isHidden: false)
            }
        case 2:
            if UIController.activeTab == 1 {
                UIController.activeTab = 2
                UIController.viewController.editTabButton.alpha = 1.0
                UIController.viewController.filtersTabButton.alpha = 0.3
                UIController.viewController.filtersPanelView.isHidden = true
                moveView(view: UIController.viewController.filtersPanelView, x: 0.0, y: UIController.viewController.filtersPanelView.frame.height, isHidden: true)
                moveView(view: UIController.viewController.lightningPanelView, x: -(UIController.viewController.lightningPanelView.frame.width - 22.0), y: 0.0, isHidden: true)
                moveView(view: UIController.viewController.galleryPanelView, x: UIController.viewController.galleryPanelView.frame.width - 22.0, y: 0.0, isHidden: true)
                UIController.viewController.editNabBarView.alpha = 0.0
                UIController.viewController.editNabBarView.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    UIController.viewController.editNabBarView.alpha = 1.0
                }
                //panel.isHidden
            } else if UIController.activeTab == 2 {
                UIController.activeTab = 0
                UIView.animate(withDuration: 0.2, animations: {
                    UIController.viewController.editNabBarView.alpha = 0.0
                }) { (finished) in
                    UIController.viewController.editNabBarView.isHidden = true
                }
                moveView(view: UIController.viewController.lightningPanelView, x: UIController.viewController.lightningPanelView.frame.width - 22.0, y: 0.0, isHidden: false)
                moveView(view: UIController.viewController.galleryPanelView, x: -(UIController.viewController.galleryPanelView.frame.width - 22.0), y: 0.0, isHidden: false)
                UIController.viewController.editTabButton.alpha = 0.3
            } else {
                UIController.activeTab = 2
                UIController.viewController.editTabButton.alpha = 1.0
                moveView(view: UIController.viewController.lightningPanelView, x: -(UIController.viewController.lightningPanelView.frame.width - 22.0), y: 0.0, isHidden: true)
                moveView(view: UIController.viewController.galleryPanelView, x: UIController.viewController.galleryPanelView.frame.width - 22.0, y: 0.0, isHidden: true)
                
                UIController.viewController.editNabBarView.alpha = 0.0
                UIController.viewController.editNabBarView.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    UIController.viewController.editNabBarView.alpha = 1.0
                }
            }
        default: break
        }
    }
    
    //
    class func switchLightningMode() {
        if lightningMode == 3 {
            lightningMode = 0
            UIController.viewController.lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        } else {
            lightningMode += 1
            UIController.viewController.lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        }
    }
    
}
