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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIController.setupUI(sender: self)
        CameraController.startCameraSession(sender: self)
    }
    
    //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CameraController.camera.stopCapture()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func photoButtonTapped(_ sender: Any) {
        //        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    }
    
    //
    @IBAction func filtersTabButtonTapped(_ sender: Any) {
        UIController.switchTab(to: 1)
    }
    
    //
    @IBAction func editTabButtonTapped(_ sender: Any) {
        UIController.switchTab(to: 2)
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
        UIController.switchLightningMode()
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



