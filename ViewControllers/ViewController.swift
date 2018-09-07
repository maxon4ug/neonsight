//
//  ViewController.swift
//  Neonsight
//
//  Created by Max Surgai on 01.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var activeTab = 1
    var lightningMode = 0
    var lightningModesList = ["lightningOff","lightningA","lightning","lightningT"]
    
    // MARK: IBOutlets
    
    @IBOutlet weak var cameraView: RenderView!
    @IBOutlet weak var cameraImageView: UIImageView!
    
    // TAB BAR
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var filtersTabButton: UIButton!
    @IBOutlet weak var editTabButton: UIButton!
    @IBOutlet weak var changeCameraButton: UIButton!
    @IBOutlet weak var infoTabButton: UIButton!
    
    // NAV BAR
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var lightningButton: UIButton!
    @IBOutlet weak var lightningPanelView: UIView!
    @IBOutlet weak var galleryPanelView: UIView!
    
    // EDIT NAV BAR
    
    @IBOutlet weak var editNabBarView: UIView!
    //    @IBOutlet weak var editNavBarScaleBGView: UIView!
    @IBOutlet weak var editNavBarLabel: UILabel!
    @IBOutlet weak var editNavBarLabelBGView: UIView!
    
    // FILTERS PANEL
    
    @IBOutlet weak var filtersPanelView: UIView!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    @IBOutlet var filtersImageViewCollection: [UIImageView]!
    @IBOutlet var filtersNameLableCollection: [UILabel]!
    @IBOutlet var filtersButtonCollection: [UIButton]!
    
    
    // EDIT PANEL
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var editPanelView: UIView!
    
    
    // MARK: - Methods
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CameraController.camera.stopCapture()
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        CameraController.startCameraSession(sender: self)
    }
    
    
    // MARK: - UI
    
    func setupUI() {
        //        let editNavBarScaleBGGradient = CAGradientLayer()
        //        editNavBarScaleBGGradient.colors = [UIColor(named: "neonPink")!, UIColor(named: "neonBlue")!]
        //        editNavBarScaleBGView.layer.insertSublayer(editNavBarScaleBGGradient, at: 0)
        editNavBarLabelBGView.layer.cornerRadius = editNavBarLabelBGView.frame.height / 2.0
        galleryPanelView.subviews.first!.layer.cornerRadius = galleryPanelView.frame.height / 2.0
        lightningPanelView.subviews.first!.layer.cornerRadius = lightningPanelView.frame.height / 2.0
        GestureController.setupGestureRecognizer(sender: self)
    }
    
    //
    func moveView(view: UIView, x: CGFloat, y: CGFloat, isHidden: Bool, completion: @escaping () -> () = {}) {
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
    func switchTab(to tabNum: UInt) {
        switch tabNum {
        case 1:
            if activeTab == 0 {
                activeTab = 1
                filtersTabButton.alpha = 1.0
                moveView(view: filtersPanelView, x: 0.0, y: -(filtersPanelView.frame.height), isHidden: false)
            } else if activeTab == 1 {
                activeTab = 0
                filtersTabButton.alpha = 0.3
                moveView(view: filtersPanelView, x: 0.0, y: filtersPanelView.frame.height, isHidden: true)
            } else {
                activeTab = 1
                filtersTabButton.alpha = 1.0
                editTabButton.alpha = 0.3
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.editNabBarView.alpha = 0.0
                }) { (finished) in
                    self.editNabBarView.isHidden = true
                }
                moveView(view: lightningPanelView, x: lightningPanelView.frame.width - 22.0, y: 0.0, isHidden: false)
                moveView(view: galleryPanelView, x: -(galleryPanelView.frame.width - 22.0), y: 0.0, isHidden: false)
                moveView(view: filtersPanelView, x: 0.0, y: -(filtersPanelView.frame.height), isHidden: false)
            }
        case 2:
            if activeTab == 1 {
                activeTab = 2
                editTabButton.alpha = 1.0
                filtersTabButton.alpha = 0.3
                filtersPanelView.isHidden = true
                moveView(view: filtersPanelView, x: 0.0, y: filtersPanelView.frame.height, isHidden: true)
                moveView(view: lightningPanelView, x: -(lightningPanelView.frame.width - 22.0), y: 0.0, isHidden: true)
                moveView(view: galleryPanelView, x: galleryPanelView.frame.width - 22.0, y: 0.0, isHidden: true)
                editNabBarView.alpha = 0.0
                editNabBarView.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.editNabBarView.alpha = 1.0
                }
                //panel.isHidden
            } else if activeTab == 2 {
                activeTab = 0
                UIView.animate(withDuration: 0.2, animations: {
                    self.editNabBarView.alpha = 0.0
                }) { (finished) in
                    self.editNabBarView.isHidden = true
                }
                moveView(view: lightningPanelView, x: lightningPanelView.frame.width - 22.0, y: 0.0, isHidden: false)
                moveView(view: galleryPanelView, x: -(galleryPanelView.frame.width - 22.0), y: 0.0, isHidden: false)
                editTabButton.alpha = 0.3
            } else {
                activeTab = 2
                editTabButton.alpha = 1.0
                moveView(view: lightningPanelView, x: -(lightningPanelView.frame.width - 22.0), y: 0.0, isHidden: true)
                moveView(view: galleryPanelView, x: galleryPanelView.frame.width - 22.0, y: 0.0, isHidden: true)
                
                editNabBarView.alpha = 0.0
                editNabBarView.isHidden = false
                UIView.animate(withDuration: 0.2) {
                    self.editNabBarView.alpha = 1.0
                }
            }
        default: break
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func photoButtonTapped(_ sender: Any) {
        //        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    }
    
    //
    @IBAction func filtersTabButtonTapped(_ sender: Any) {
        switchTab(to: 1)
    }
    
    //
    @IBAction func editTabButtonTapped(_ sender: Any) {
        switchTab(to: 2)
    }
    
    //
    @IBAction func changeCameraButtonTapped(_ sender: Any) {
        CameraController.camera.location = .frontFacing
    }
    
    //
    @IBAction func infoTabButtonTapped(_ sender: Any) {
    }
    
    //
    @IBAction func lightningButtonTapped(_ sender: Any) {
        if lightningMode == 3 {
            lightningMode = 0
            lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        } else {
            lightningMode += 1
            lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        }
    }
    
    //
    @IBAction func galleryButtonTapped(_ sender: Any) {
    }
    
    //
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            let filter = SaturationAdjustment()
            filter.saturation = 0.1
            CameraController.camera --> filter
        default:
            break
        }
    }
    
}



