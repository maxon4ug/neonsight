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

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate {
    
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
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var lightningButton: UIButton!
    
    
    // FILTERS PANEL
    
    @IBOutlet weak var filtersPanelUIVIew: UIView!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    @IBOutlet var filtersImageViewCollection: [UIImageView]!
    @IBOutlet var filtersTextFieldCollection: [UITextField]!
    @IBOutlet var filtersButtonCollection: [UIButton]!
    
    
    // MARK: - Methods
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CameraController.camera.stopCapture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            CameraController.startCameraSession(sender: self)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (authorized) in
                DispatchQueue.main.async {
                    if authorized {
                        CameraController.startCameraSession(sender: self)
                    }
                }
            })
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func photoButtonTapped(_ sender: Any) {
//        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    }
    
    @IBAction func filtersTabButtonTapped(_ sender: Any) {
        switch activeTab {
        case 0:
            activeTab = 1
            filtersTabButton.alpha = 1.0
            filtersPanelUIVIew.isHidden = false
        case 1:
            activeTab = 0
            filtersTabButton.alpha = 0.3
            filtersPanelUIVIew.isHidden = true
        case 2:
            activeTab = 1
            filtersTabButton.alpha = 1.0
            editTabButton.alpha = 0.3
        //editorsListUIView.isHidden = true
        default: break
        }
    }
    
    @IBAction func editTabButtonTapped(_ sender: Any) {
    }
    
    @IBAction func changeCameraButtonTapped(_ sender: Any) {
        CameraController.camera.location = .frontFacing
    }
    
    @IBAction func infoTabButtonTapped(_ sender: Any) {
    }
    
    @IBAction func lightningButtonTapped(_ sender: Any) {
        if lightningMode == 3 {
            lightningMode = 0
            lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        } else {
            lightningMode += 1
            lightningButton.setImage(UIImage(named: lightningModesList[lightningMode]), for: .normal)
        }
    }
    
    @IBAction func galleryButtonTapped(_ sender: Any) {
    }
    
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


