//
//  StudentEditViewController.swift
//  demosetup
//
//  Created by Nikunj on 28/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class StudentEditViewController: UIViewController, HomeLocationDelegate {

    
    // MARK: - OUTLETS -
    
    @IBOutlet weak var txtFullname: FloatLabelTextField!
    
    @IBOutlet weak var txtUsername: FloatLabelTextField!
    
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    
    @IBOutlet weak var imgGenderMale: UIImageView!
    
    @IBOutlet weak var imgGenderFemale: UIImageView!
    
    @IBOutlet weak var txtWechatID: FloatLabelTextField!
    
    @IBOutlet weak var txtAgeStudent: FloatLabelTextField!
    
    @IBOutlet weak var txtAddress: FloatLabelTextField!
    
    @IBOutlet weak var lblavailabilitytext: UILabel!
    
    
    @IBOutlet weak var txtAvailability: UILabel!
    
    @IBOutlet weak var txtSpecialSkill: FloatLabelTextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var viewStudentHeader: UIView!
    
    // MARK: - VARIABLES -
    
    var gender = "Male"
    
    var userid = ""
    
    var stroj = StudentList()
    
    var _locationManager = CLLocationManager()
    
    var arravail = [[String : AnyObject]]()
    
    
    // MARK: - METHODS -
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBordertoView()
    
        if kCurrentUser()?.role == "admin"
        {
            viewStudentHeader.isHidden = true
            
        }else{
            
            if kCurrentUser()?.is_active == "1"
            {
                viewStudentHeader.isHidden = true
            }
            userid = (kCurrentUser()?.userid)!
            
        }
        
        callAPI()
     
        txtEmail.isUserInteractionEnabled = false
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Availabilityarr.count > 0
        {
           let dict_arravail = JSON(Availabilityarr.sorted {($0["priority"] as! Int) < ($1["priority"] as! Int)})
            
            arravail = [[String: AnyObject]]()
            var teststr = ""
            for (_, value) in dict_arravail
            {
                arravail.append(["dayString" : value["dayString"].string! as AnyObject, "endTime" : value["endTime"].string! as AnyObject, "startTime" : value["startTime"].string! as AnyObject, "priority" : value["priority"].int as AnyObject])
                
                teststr = teststr + "\(value["dayString"].string!):\(value["startTime"].string!)-\(value["endTime"].string!)" + ","
            }
            
            if teststr != ""
            {
                lblavailabilitytext.textColor = UIColor.black
            }
            
            txtAvailability.text = teststr
            Availabilityarr = [[String: AnyObject]]()
        }
        
        if kCurrentUser()?.role == "admin" || kCurrentUser()?.role == "student"
        {
            if homeaddress != ""
            {
                txtAddress.text = homeaddress
                homeaddress = ""
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - VOID METHODS -
    
    func callGetAddressAPI(lat : Double, long : Double)
    {
        let param : [String : String] =
            [
                p_action : "get_address",
                p_lat : lat.description,
                p_lng : long.description
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getaddress.rawValue, showloader : false, handler: { response in
            
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
               // self.AddressPopup(straddress: str)
            }
            
        })
    }
    
    func setBordertoView()
    {
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        // btnLogin.layer.borderColor = UIColor(colorLiteralRed: 60.0/255, green: 194.0/255, blue: 38.0/255, alpha: 1.0).cgColor
        //btnLogin.layer.borderWidth = 1.0
        btnSubmit.clipsToBounds = true
        
    }
    
    
    func GetHomeLocation(isYes: Bool, straddress: String) {
        if isYes
        {
             self.txtAddress.text = straddress
        }else{
             self.txtAddress.text = ""
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    //profile.php?uId=55&role=student
    
    func callAPI()
    {
        let param : [String : String] =
            [
                p_role : "student",
                p_uId : userid,
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getProfile.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            self.stroj.updatesingle(data: dict)
            
            print(self.stroj.objSingle.userid)

            print(self.stroj.objSingle.sex)

            self.updatefields()
            
        })
    }
    
    func updatefields()
    {
        
        
        if kCurrentUser()?.is_active == "0" && kCurrentUser()?.role == "student"
        {
            _locationManager = CLLocationManager()
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.requestWhenInUseAuthorization()
            _locationManager.startUpdatingLocation()
            
        }else{
            
            if stroj.objSingle.latitude != "" &&  stroj.objSingle.longitude != ""
            {
                curr_lat = Double(stroj.objSingle.latitude)!
                curr_long = Double(stroj.objSingle.longitude)!
            }
            
            txtAddress.text = stroj.objSingle.station
        }
        
        txtFullname.text = stroj.objSingle.fullName
        txtUsername.text = stroj.objSingle.username
        txtEmail.text = stroj.objSingle.email
        
        if stroj.objSingle.sex.uppercased() == gender.uppercased()
        {
            
            imgGenderMale.image = #imageLiteral(resourceName: "ic_genderSelected")
            imgGenderFemale.image = #imageLiteral(resourceName: "ic_genderUnSelected")
            
        }else{
            gender = "Female"
            imgGenderMale.image = #imageLiteral(resourceName: "ic_genderUnSelected")
            imgGenderFemale.image = #imageLiteral(resourceName: "ic_genderSelected")
        }
        txtWechatID.text = stroj.objSingle.mob_no
        txtAgeStudent.text = stroj.objSingle.age
        
        if stroj.objSingle.available_time != ""
        {
            let strdata : Data = stroj.objSingle.available_time.data(using: .utf8)!
            let dict_arravail = JSON(strdata)
            arravail = [[String: AnyObject]]()

            var teststr = ""
            for (_, value) in dict_arravail
            {
              
                print(value)
            
                arravail.append(["dayString" : value["dayString"].string! as AnyObject, "endTime" : value["endTime"].string! as AnyObject, "startTime" : value["startTime"].string! as AnyObject, "priority" : value["priority"].int as AnyObject])

                teststr = teststr + "\(value["dayString"].string!):\(value["startTime"].string!)-\(value["endTime"].string!)" + ","
            }
            if teststr != ""
            {
                lblavailabilitytext.textColor = UIColor.black
                txtAvailability.text = teststr
            }else{
                lblavailabilitytext.textColor = UIColor.black
                txtAvailability.text = stroj.objSingle.available_time
            }
        }
        txtSpecialSkill.text = stroj.objSingle.skills
  
    }
   
    
    func Validate() -> Bool{
        
        if (txtFullname.text?.isEmpty)!
        {
            Utilities.showMessage(text: ValidMsg.pleaseenter.rawValue + txtFullname.placeholder!)
        }else if (txtUsername.text?.isEmpty)!
        {
            Utilities.showMessage(text: ValidMsg.pleaseenter.rawValue + txtUsername.placeholder!)
        }else if (txtAvailability.text?.isEmpty)!
        {
            Utilities.showMessage(text: ValidMsg.pleaseenter.rawValue + lblavailabilitytext.text!)
        }else if (txtWechatID.text?.isEmpty)!
        {
            Utilities.showMessage(text: ValidMsg.pleaseenter.rawValue + txtWechatID.placeholder!)
            
        }else if (txtAddress.text?.isEmpty)! || curr_lat == 0.0 || curr_long == 0.0
            {
                Utilities.showMessage(text: ValidMsg.addressvalid.rawValue)
                
        }else{
            return true
        }
        
        return false
    }
    
    
    func callUpdateAPI()
    {
      
        var param : [String : String] =
            [
                p_fullname : txtFullname.text!,
                p_uId : userid,
                p_age : txtAgeStudent.text!,
                p_mobile : txtWechatID.text!,
                p_station : txtAddress.text!,
                p_skill : txtSpecialSkill.text!,
                p_sex : gender,
                p_username : txtUsername.text!,
                p_lat : String(curr_lat),
                p_lng : String(curr_long),
            ]
        
        if !((txtAvailability.text?.isEmpty)!)
        {
            if arravail.count != 0
            {
                let json = JSON(arravail)
                let strjson : String = json.rawString()!
                param[p_available_time] = String(strjson.characters.filter { !" \n\t\r\\".characters.contains($0) })
            }else{
                Utilities.showMessage(text: ValidMsg.reenteravailbility.rawValue)
                return
            }
        }else{
            param[p_available_time] = ""
        }
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.update_studprof.rawValue, handler: { response in
            
            print(JSON(response))
            
            Utilities.showMessage(text: ValidMsg.detailsupdated.rawValue)
            
            curr_lat = 0.0
            curr_long = 0.0
            
            if kCurrentUser()?.role == "admin"
            {
                _ = self.navigationController?.popViewController(animated : true)
            }else{
               
                if kCurrentUser()?.role == "student"
                {
                  
                    if kCurrentUser()?.is_active == "0"
                    {
                        let user = kCurrentUser()
                        user?.is_active = "1"
                        user?.saveToDefaults()
                        appInstance.GotocheckScreens()
                    }else{
                          _ = self.navigationController?.popViewController(animated : true)
                    }
                    
                }
                
            }
            
        })
    }
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        
        appInstance.LogoutPopup()
        
    }
    
    @IBAction func btnaddressClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "MapViewViewController", onStoryboard: Sbname.Home.rawValue) as! MapViewViewController
        VC.lat = curr_lat
        VC.long = curr_long
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        curr_long = 0.0
        curr_lat = 0.0
        
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        
        if sender.tag == 0
        {
            gender = "Male"
            
            imgGenderMale.image = #imageLiteral(resourceName: "ic_genderSelected")
            imgGenderFemale.image = #imageLiteral(resourceName: "ic_genderUnSelected")
            
        }else{
            
            gender = "Female"
            
            imgGenderMale.image = #imageLiteral(resourceName: "ic_genderUnSelected")
            imgGenderFemale.image = #imageLiteral(resourceName: "ic_genderSelected")
            
        }
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if Validate()
        {
            callUpdateAPI()
        }
        
    }
   
    
    @IBAction func btnAvailabilityClicked(_ sender: UIButton) {

        let VC = Utilities.viewController(name: "AvailabilityTimeViewController", onStoryboard: Sbname.Home.rawValue) as! AvailabilityTimeViewController
        VC.strAvail = txtAvailability.text!
        VC.arravail = arravail
        self.navigationController?.pushViewController(VC, animated: true)

    }
    
}



// MARK: - TEXTFIELDS DELEGATE -
extension StudentEditViewController : UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if txtAgeStudent == textField
        {
            if string == ""
            {
                return true
            }
            if (!Utilities.isValidRegex(testStr: string, regex: "^[0-9]"))
            {
                return false
            }
            
        }
        return true
    }
    
}

extension StudentEditViewController : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loc = locations.last
        
        if loc != nil
        {
            if let strlat = loc?.coordinate.latitude, let strlong = loc?.coordinate.longitude
            {
                self.callGetAddressAPI(lat : strlat, long : strlong)
            }
        }
        _locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
        
        _locationManager.stopUpdatingLocation()
        
    }
    
    

    
}


