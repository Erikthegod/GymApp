//
//  ViewController.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 04/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

class MainCameraViewController: CameraViewController {

    
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var captureModeControl: UISegmentedControl!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var livePhotoModeButton: UIButton!
    @IBOutlet weak var depthDataDeliveryButton: UIButton!
    @IBOutlet weak var capturingLivePhotoLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    override func viewDidLoad() {
        super._previewView = self.previewView
        
        super._captureModeControl = self.captureModeControl
        self.captureModeControl.addTarget(self, action: #selector(toggleCaptureMode), for: .valueChanged)
        
        super._cameraButton = self.cameraButton
        self.cameraButton.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        
        super._photoButton = self.photoButton
        self.photoButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        
        super._livePhotoModeButton = self.livePhotoModeButton
        self.livePhotoModeButton.addTarget(self, action: #selector(toggleLivePhotoMode), for: .touchUpInside)
        
        super._depthDataDeliveryButton = self.depthDataDeliveryButton
        self.depthDataDeliveryButton.addTarget(self, action: #selector(toggleDepthDataDeliveryMode), for: .touchUpInside)
        
        super._recordButton = self.recordButton
        self.recordButton.addTarget(self, action: #selector(toggleMovieRecording), for: .touchUpInside)
        
        super._resumeButton = self.resumeButton
        self.resumeButton.addTarget(self, action: #selector(resumeInterruptedSession), for: .touchUpInside)
        
        super._cameraUnavailableLabel = self.cameraUnavailableLabel
        super._capturingLivePhotoLabel = self.capturingLivePhotoLabel
        
        self.cameraUnavailableLabel.alpha = 0.0
        self.capturingLivePhotoLabel.alpha = 0.0

        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        performSegue(withIdentifier: "showLoginVC", sender: nil)
        
//        guard Auth.auth().currentUser != nil else {
//            performSegue(withIdentifier: "showLoginVC", sender: nil)
//            return
//        }
    }


}

