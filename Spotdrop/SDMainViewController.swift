//
//  ViewController.swift
//  Spotdrop
//
//  Created by Erik Koebke on 1/9/16.
//  Copyright © 2016 Erik Koebke. All rights reserved.
//

import UIKit
import Mapbox
import Alamofire
import AlamofireImage

// pitch - viewing angle of camera in degrees
// altitude - meters above ground level
// CLLocationManagerDelegate
class SDMainViewController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet var mapView: MGLMapView!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var goToUserProfileView: UIView!
    @IBOutlet weak var goToCurrentPlaceView: UIView!
    @IBOutlet weak var goToCurrentPlaceLogo: UIImageView!
    
    @IBOutlet weak var upArrow: UIImageView!

    var currentUserLocation: MGLUserLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        createActivityBarShadow()
    }
    
 
    /*
        Delegate Methods
     */
    
    func mapView(mapView: MGLMapView, didUpdateUserLocation userLocation: MGLUserLocation?) {
        // createInitialMap() if the app is launching for the first time - currentUserLocation will be nil
        if self.currentUserLocation == nil {
            self.currentUserLocation = userLocation
            createInitialMap()
        }
        
        self.currentUserLocation = userLocation
    }

    /*
        Helper Methods
     */

    func createInitialMap() {
        mapView.delegate = self
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
        
        getCurrentPlaceLogo()
    }
    
    func getCurrentPlaceLogo() {
        var addressName: String?
        let userLocation = CLLocation(latitude: self.currentUserLocation!.coordinate.latitude, longitude: self.currentUserLocation!.coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let address = placemarks![0] as CLPlacemark
                addressName = address.name
            } else {
                print("problem with data received from geocoder")
            }
            
            var possibleCurrentPlaceId: String!
            FBSDKGraphRequest(graphPath: "search", parameters: ["fields":"", "type":"place", "q":"", "center":"38.886687,-77.096388", "distance": 50]).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                // no error
                // "\(self.currentUserLocation!.coordinate.latitude),\(self.currentUserLocation!.coordinate.longitude)"
                if (error == nil){
                    let resultDictionary = result as! [String: AnyObject]
                    let results = resultDictionary["data"] as! NSArray
                    let possibleCurrentPlace = results[0]
                    possibleCurrentPlaceId = possibleCurrentPlace["id"] as! String
                    
                } else {
                    print(error)
                }
                
            })
            
            FBSDKGraphRequest(graphPath: "\(possibleCurrentPlaceId)", parameters: nil).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                // no error
                if (error == nil){
                    print(result)
                } else {
                    print(error)
                }
                
            })
        })
        

    }
    
    func createActivityBarShadow() {
        /*
            add shadow to promptView
         */
        let promptViewPath = UIBezierPath(rect: promptView.bounds)
        promptView.layer.masksToBounds = false
        promptView.layer.shadowColor = UIColor.blackColor().CGColor
        promptView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        promptView.layer.shadowOpacity = 0.2
        promptView.layer.shadowPath = promptViewPath.CGPath
        
        /*
            add shadow to goToUserProfileView
         */
        let goToUserProfileViewPath = UIBezierPath(rect: goToUserProfileView.bounds)
        goToUserProfileView.layer.masksToBounds = false
        goToUserProfileView.layer.shadowColor = UIColor.blackColor().CGColor
        goToUserProfileView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        goToUserProfileView.layer.shadowOpacity = 0.2
        goToUserProfileView.layer.shadowPath = goToUserProfileViewPath.CGPath
        
        /*
            add shadow to goToCurrentPlaceView
         */
        let goToCurrentPlaceViewPath = UIBezierPath(rect: goToCurrentPlaceView.bounds)
        goToCurrentPlaceView.layer.masksToBounds = false
        goToCurrentPlaceView.layer.shadowColor = UIColor.blackColor().CGColor
        goToCurrentPlaceView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        goToCurrentPlaceView.layer.shadowOpacity = 0.2
        goToCurrentPlaceView.layer.shadowPath = goToCurrentPlaceViewPath.CGPath
        
    }
}

