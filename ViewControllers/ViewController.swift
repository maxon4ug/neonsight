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
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var filtersTabButton: UIButton!
    @IBOutlet weak var editTabButton: UIButton!
    @IBOutlet weak var changeCameraButton: UIButton!
    @IBOutlet weak var infoTabButton: UIButton!
    
    // NAV BAR
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var lightningButton: UIButton!
    
    // EDIT NAV BAR
    
    @IBOutlet weak var editNabBarView: UIView!
//    @IBOutlet weak var editNavBarScaleBGView: UIView!
    @IBOutlet weak var editNavBarLabel: UILabel!
    
    // FILTERS PANEL
    
    @IBOutlet weak var filtersPanelView: UIView!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    @IBOutlet var filtersImageViewCollection: [UIImageView]!
    @IBOutlet var filtersNameLableCollection: [UILabel]!
    @IBOutlet var filtersButtonCollection: [UIButton]!
    
    
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
        GestureController.setupGestureRecognizer(sender: self)
    }
    
    //
    func switchTab(to tabNum: UInt) {
        switch tabNum {
        case 1:
            if activeTab == 0 {
                activeTab = 1
            filtersTabButton.alpha = 1.0
            filtersPanelView.isHidden = false
            } else if activeTab == 1 {
                activeTab = 0
                filtersTabButton.alpha = 0.3
                filtersPanelView.isHidden = true
            } else {
                activeTab = 1
                filtersTabButton.alpha = 1.0
                editTabButton.alpha = 0.3
                editNabBarView.isHidden = true
                navBarView.isHidden = false
                filtersPanelView.isHidden = false
            }
        case 2:
            if activeTab == 1 {
                activeTab = 2
                editTabButton.alpha = 1.0
                filtersTabButton.alpha = 0.3
                filtersPanelView.isHidden = true
                editNabBarView.isHidden = false
                navBarView.isHidden = true
                //panel.isHidden
            } else if activeTab == 2 {
                activeTab = 0
                navBarView.isHidden = false
                editTabButton.alpha = 0.3
                editNabBarView.isHidden = true
            } else {
                activeTab = 2
                editTabButton.alpha = 1.0
                navBarView.isHidden = true
                editNabBarView.isHidden = false
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


