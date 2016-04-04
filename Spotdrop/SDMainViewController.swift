//
//  ViewController.swift
//  Spotdrop
//
//  Created by Erik Koebke on 1/9/16.
//  Copyright © 2016 Erik Koebke. All rights reserved.
//

import UIKit
import Mapbox

// pitch - viewing angle of camera in degrees
// altitude - meters above ground level
class SDMainViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MGLMapView!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var goToUserProfileView: UIView!
    @IBOutlet weak var goToCurrentPlaceView: UIView!
    @IBOutlet weak var upArrow: UIImageView!


    var locationManager: CLLocationManager?
    var currentUserLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentUserLocation()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        /*
            add shadow to activityBarView
         */
        let shadowPath = UIBezierPath(rect: promptView.bounds)
        promptView.layer.masksToBounds = false
        promptView.layer.shadowColor = UIColor(red: 58/255, green: 56/255, blue: 54/255, alpha: 0.98).CGColor
        promptView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        promptView.layer.shadowOpacity = 0.2
        promptView.layer.shadowPath = shadowPath.CGPath
    }
    
 
    /*
        Delegate Methods
     */
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // currentUserLocation is nil because the app is just loading
        if self.currentUserLocation == nil {
            manager.stopUpdatingLocation()
            self.currentUserLocation = locations.last
            createInitialMap()
        }
    }

    /*
        Helper Methods
     */
    
    func getCurrentUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }

    func createInitialMap() {
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: self.currentUserLocation!.coordinate.latitude, longitude: self.currentUserLocation!.coordinate.longitude),
                                    zoomLevel: 13, animated: false)
        
        let camera = MGLMapCamera(lookingAtCenterCoordinate: mapView.centerCoordinate, fromDistance: 1000, pitch: 62.5, heading: 0)
        mapView.setCamera(camera, animated: false)
        
        mapView.allowsTilting = false
        mapView.allowsRotating = false
        mapView.showsUserLocation = true
        mapView.compassView.hidden = true
        mapView.styleURL = NSURL(string: "mapbox://styles/erikk531/cimcobng600dka6m4yyzallot")
        mapView.attributionButton.hidden = false
        mapView.logoView.hidden = true
    }
}

