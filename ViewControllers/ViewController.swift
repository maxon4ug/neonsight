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

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    
    var importImage: UIImage!
    let imagePicker = UIImagePickerController()
    
    
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
    @IBOutlet weak var tabBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabBarTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabBarHeightConstraint: NSLayoutConstraint!
    
    // NAV BAR
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var lightningButton: UIButton!
    @IBOutlet weak var lightningPanelView: UIView!
    @IBOutlet weak var galleryPanelView: UIView!
    
    // FILTERS PANEL
    @IBOutlet weak var filtersPanelView: UIView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    // EDIT NAV BAR
    @IBOutlet weak var editNabBarView: UIView!
    @IBOutlet weak var editNavBarLabel: UILabel!
    @IBOutlet weak var editNavBarLabelBGView: UIView!
    @IBOutlet weak var editNavBarValueGradientView: UIView!
    @IBOutlet weak var editNavBarValueGradientMaskView: UIView!
    
    // EDIT PANEL
    @IBOutlet weak var editPanelView: UIView!
    @IBOutlet weak var editPanelTableView: UITableView!
    @IBOutlet weak var editPanelSelectNameLabel: UILabel!
    @IBOutlet weak var editPanelSelectValueLabel: UILabel!
    @IBOutlet weak var editPanelSelectNewNameLabel: UILabel!
    @IBOutlet weak var editPanelSelectNewValueLabel: UILabel!
    @IBOutlet weak var editPanelListView: UIView!
    
    
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
    @IBAction func changeCameraButtonTapped(_ sender: Any) { //export button
        if importImage != nil {
            changeCameraButton.alpha = 1.0
            IOController.exportImage(image: importImage, sender: self)
        } else {
            CameraController.camera.stopCapture()
            CameraController.camera.location = .frontFacing
        }
    }
    
    //
    @IBAction func infoTabButtonTapped(_ sender: Any) {
    }
    
    //
    @IBAction func lightningButtonTapped(_ sender: Any) {
        UIController.switchLightningMode()
    }
    
    //
    @IBAction func galleryButtonTapped(_ sender: Any) { //close button
        cameraImageView.fadeTransition(0.2)
        if importImage != nil { //close
            CameraController.camera.startCapture()
            cameraImageView.image = nil
            importImage = nil
            UIController.switchToImportMode()
            cameraImageView.alpha = 0.0
        } else {
            IOController.importImage(sender: self)
            CameraController.camera.stopCapture()
            cameraImageView.alpha = 1.0
        }
    }
    
    //
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let filter = SaturationAdjustment()
            filter.saturation = 0.1
            CameraController.camera --> filter
        default:
            print(sender.tag)
            break
        }
    }
    
    // MARK: - TableView setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditTabController.editToolList.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editCell", for: indexPath) as! EditToolTableViewCell
        cell.editTool = EditTabController.editToolList[indexPath.row]
        return cell
    }
    
    // MARK: - CollectionView setup
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Filter.filterList.count
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FiltersCollectionViewCell
        cell.filter = Filter.filterList[indexPath.row]
        cell.button.tag = indexPath.row
        return cell
    }
}



