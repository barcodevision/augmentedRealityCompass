//
//  ViewController.swift
//  augmentedRealityCompass
//
//  Created by Bryan Ayllon on 8/4/16.
//  Copyright © 2016 Bryan Ayllon. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {

    var overlayView: UIView!
    var locationManager: CLLocationManager!
    var theCompass: UIImageView!
    var imagePickerViewController :UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerViewController = UIImagePickerController()
        self.imagePickerViewController.delegate = self
        self.imagePickerViewController.sourceType = .Camera
        
        self.overlayView = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.height)))
        
        
        self.theCompass = UIImageView(image: UIImage(named:"compass.png"))
        theCompass.frame = CGRect(x: (self.view.frame.size.width/2)-50 , y: 200, width: 75, height: 100)

        let north = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-10, y: 100, width: 100, height: 20))
        north.text = "North"
        north.textColor = UIColor.whiteColor()
        
        let south = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-10, y: 400, width: 100, height: 20))
        south.text = "South"
        south.textColor = UIColor.whiteColor()
        
        let west = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-150, y: 240, width: 100, height: 20))
        west.text = "West"
        west.textColor = UIColor.whiteColor()
        
        let east = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)+100, y: 240, width: 100, height: 20))
        east.text = "East"
        east.textColor = UIColor.whiteColor()
        
        self.overlayView = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.height)))
        
        
        
        overlayView.addSubview(north)
        overlayView.addSubview(south)
        overlayView.addSubview(east)
        overlayView.addSubview(west)
        overlayView.addSubview(theCompass)
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.startUpdatingHeading()

        self.imagePickerViewController.cameraOverlayView = overlayView

    }
    
    @IBAction func launchARButtonPressed() {
        
        self.presentViewController(self.imagePickerViewController, animated: true, completion: nil)
    }

    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        let degrees = newHeading.magneticHeading
        let radians = degrees * M_PI / 180
        
        self.theCompass.transform = CGAffineTransformMakeRotation(CGFloat(-radians))
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

