//
//  MapRolewiseViewController.swift
//  demosetup
//
//  Created by A on 11/15/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class MapRolewiseViewController: UIViewController, MGLMapViewDelegate {

    // MARK: - OUTLETS
    
    @IBOutlet weak var mapview: MGLMapView!
    
    
    @IBOutlet weak var switchteacher: UISwitch!
    
    @IBOutlet weak var switchstudent: UISwitch!
    
    // MARK: -
    
    // MARK: - VARIABLES
    
    var objlist = StudentList()
    
    var pin = [MGLPointAnnotation()]
    
    var flag = "B"
    
    // MARK:-
    
    // MARK: - LIFECYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapview.delegate = self
        mapview.styleURL = MGLStyle.satelliteStreetsStyleURL()
        
        mapview.attributionButton.isHidden = true
        
        callAPILoad()

        switchteacher.tag = 1
        switchstudent.tag = 2
        
        switchteacher.addTarget(self, action : #selector(switchChanged), for: .valueChanged)
        
        switchstudent.addTarget(self, action : #selector(switchChanged), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - VOID METHODS
    
    func callAPILoad()
    {
        let param : [String : String] =
            [
                "" : ""
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getlatnlong.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            
            self.objlist.update(data: dict)
     
            self.flag = "B"
            self.setpinonmap(is_teacher: true, is_stud: true)
        })
    }
   
    
    func switchChanged(mySwitch: UISwitch) {
        
            if mySwitch.tag == 1
            {
                //teacher
                if mySwitch.isOn
                {
                    if flag == "O"
                    {
                        flag = "T"
                        self.setpinonmap(is_teacher: true, is_stud: false)
                    }else
                    if flag == "S"
                    {
                        flag = "B"
                        self.setpinonmap(is_teacher: true, is_stud: true)
                    }
                    
                }else{
                    if flag == "B"
                    {
                        flag = "S"
                        self.setpinonmap(is_teacher: false, is_stud: true)
                    }else if flag == "T"
                    {
                        flag = "O"
                        self.setpinonmap(is_teacher: false, is_stud: false)
                    }
                }
                
            }else if mySwitch.tag == 2
            {
                //student
                if mySwitch.isOn
                {
                    if flag == "O"
                    {
                        flag = "S"
                        self.setpinonmap(is_teacher: false, is_stud: true)
                    }else if flag == "T"
                    {
                        flag = "B"
                        self.setpinonmap(is_teacher: true, is_stud: true)
                    }
                    
                }else{
                    if flag == "B"
                    {
                        flag = "T"
                        self.setpinonmap(is_teacher: true, is_stud: false)
                    }else
                        if flag == "S"
                        {
                            flag = "O"
                            self.setpinonmap(is_teacher: false, is_stud: false)
                    }
                }
            }
       
    }
    
    
    func setpinonmap(is_teacher : Bool = true, is_stud : Bool = true)
    {
        mapview.removeAnnotations(pin)
        
        if is_teacher
        {
            showpins(str : "teacher")
        }
        
        if is_stud
        {
             showpins(str : "student")
        }
        
    }
    
    func showpins(str : String)
    {
        for i in 0..<objlist.objStudlist.count
        {
            if objlist.objStudlist[i].role == str
            {
                if objlist.objStudlist[i].latitude != "" && objlist.objStudlist[i].longitude != ""
                {
                    let pinnew = MGLPointAnnotation()
                    
                    pinnew.coordinate = CLLocationCoordinate2D(latitude: Double(objlist.objStudlist[i].latitude)!, longitude: Double(objlist.objStudlist[i].longitude)!)
                    pinnew.title = objlist.objStudlist[i].fullName
                    pinnew.subtitle = objlist.objStudlist[i].role
                    
                    // Add marker `hello` to the map.
                    mapview.addAnnotation(pinnew)
                    
                    pin.append(pinnew)
                }
            }
        }
    }
    
    // MARK: -
    
    // MARK: - DELEGATE METHODS
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {


        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "pisa")
        
        if annotationImage == nil {
            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
           
            
           
           // image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            
            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
            annotationImage = MGLAnnotationImage(image: #imageLiteral(resourceName: "ic_deletered"), reuseIdentifier: "pisa")
        }
        return annotationImage

    }
    
    // MARK: -
    
    
    // MARK: - CLICKED EVENTS
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
}
