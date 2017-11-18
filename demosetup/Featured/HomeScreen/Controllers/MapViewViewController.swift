//
//  MapViewViewController.swift
//  demosetup
//
//  Created by Nikunj on 09/11/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class MapViewViewController: UIViewController, HomeLocationDelegate {

    
    // MARK: - OUTLETS
    
    @IBOutlet weak var MKView: MGLMapView!
    
    // MARK: -
    
    // MARK: - VARIABLES

    var lat = 0.0
    var long = 0.0
    
    var _locationManager = CLLocationManager()
    
    
    // MARK: -
    
    
    // MARK: - LIFECYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if lat == 0.0 && long == 0.0
        {
            _locationManager = CLLocationManager()
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.requestWhenInUseAuthorization()
            _locationManager.startUpdatingLocation()
        }else{
             self.MKView.setCenter(CLLocationCoordinate2D(latitude: self.lat, longitude: self.long), zoomLevel: 20.0, animated: false)
        }
        
        MKView.styleURL = MGLStyle.satelliteStreetsStyleURL()
        
        MKView.attributionButton.isHidden = true
        
        // Set the map’s center coordinate and zoom level.
        //MKView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: long), zoomLevel: 16.0, animated: false)
        
        // Set the delegate property of our map view to `self` after instantiating it.
        MKView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    // MARK: - VOID METHOD
    
    func callGetAddressAPI(lat : Double, long : Double)
    {
        let param : [String : String] =
            [
                p_action : "get_address",
                p_lat : lat.description,
                p_lng : long.description
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getaddress.rawValue, showloader : true, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            //address
            
            if let str = dict["address"].string
            {
                let VC = Utilities.viewController(name: "HomeLocationpopViewController", onStoryboard: Sbname.Home.rawValue) as! HomeLocationpopViewController
                VC.modalPresentationStyle = .overFullScreen
                VC.straddress = str
                VC.delegate = self
                VC.modalTransitionStyle = .crossDissolve
                self.present(VC, animated: true, completion: nil)
            }
            
        })
    }
    
    
    func GetHomeLocation(isYes: Bool, straddress: String) {
        if isYes
        {
            print(straddress)
            
            homeaddress = straddress
            
        }else{
            print("no")
        }
        dismiss(animated: true, completion: nil)
       
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: -

    // MARK: - CLICKED EVENTS
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    
    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        
         self.callGetAddressAPI(lat : lat, long : long)
        
    }
    // MARK: -
    
}


// MARK: - EXTENSION
extension MapViewViewController : MGLMapViewDelegate
{
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        print("region changes")
        
        print(mapView.centerCoordinate.latitude)
        print(mapView.centerCoordinate.longitude)
        
        curr_lat = mapView.centerCoordinate.latitude
        curr_long = mapView.centerCoordinate.longitude
        
        lat = mapView.centerCoordinate.latitude
        long = mapView.centerCoordinate.longitude
    }
}



extension MapViewViewController : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let loc = locations.last
      
        if loc != nil
        {
            if let strlat = loc?.coordinate.latitude, let strlong = loc?.coordinate.longitude
            {
//                if kCurrentUser()?.role != "student"
//                {
                   // self.callGetAddressAPI(lat : strlat, long : strlong)
                self.lat = strlat
                self.long = strlong
                
                self.MKView.setCenter(CLLocationCoordinate2D(latitude: self.lat, longitude: self.long), zoomLevel: 20.0, animated: false)
                
//                }
            }
        }
        
        _locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
        
        _locationManager.stopUpdatingLocation()
        
    }
}

