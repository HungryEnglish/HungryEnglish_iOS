//
//  TeacherEditViewController.swift
//  demosetup
//
//  Created by Nikunj on 30/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Photos
import PhotosUI
import Alamofire
import ReachabilitySwift
import CoreLocation
import FloatRatingView



class TeacherEditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate, HomeLocationDelegate {

    
    // MARK: - OUTLETS -
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var viewCanvas: UIView!
    
    @IBOutlet weak var viewimg: UIView!
    
    @IBOutlet weak var imgprofile: UIImageView!
    
    @IBOutlet weak var txtFullname: FloatLabelTextField!
    
    @IBOutlet weak var txtUsername: FloatLabelTextField!
   
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    
    @IBOutlet weak var txtRailway: FloatLabelTextField!
    
    @IBOutlet weak var lblavailabilitytext: UILabel!
    
    @IBOutlet weak var txtAvailability: UILabel!
    
    @IBOutlet weak var txtSkills: FloatLabelTextField!
    
    @IBOutlet weak var txtwechat: FloatLabelTextField!
    
    @IBOutlet weak var txtIDproof: FloatLabelTextField!
    
    @IBOutlet weak var txtCV: FloatLabelTextField!
    
    @IBOutlet weak var txtAudio: FloatLabelTextField!
    
    @IBOutlet weak var viewTeacherheader: UIView!
    
    @IBOutlet weak var viewID: UIView!
    
    @IBOutlet weak var viewCV: UIView!
    
    @IBOutlet weak var viewIDHeight: NSLayoutConstraint!//45
    
    @IBOutlet weak var viewCVHeight: NSLayoutConstraint! //45
    
    @IBOutlet weak var viewRateTeacher: UIView!
    
    @IBOutlet weak var viewrateteacherheight: NSLayoutConstraint!//139
    
    @IBOutlet weak var btnRateSubmit: UIButton!
    
    @IBOutlet weak var viewRating: FloatRatingView!
    
    @IBOutlet weak var btnProfile: UIButton!
    
    @IBOutlet weak var btnAudio: UIButton!
    
    @IBOutlet weak var viewTeacherRate: FloatRatingView!
    
    @IBOutlet weak var viewEmail: UIView!
    
    @IBOutlet weak var viewemailHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewWechat: UIView!
    
    @IBOutlet weak var viewWechatheight: NSLayoutConstraint!
    
    @IBOutlet weak var txthourlyrate: FloatLabelTextField!
    
    @IBOutlet weak var viewhourlyheight: NSLayoutConstraint!
    
    @IBOutlet weak var viewhourlyrate: UIView!
    
    @IBOutlet weak var txtnearestrailwaystation: FloatLabelTextField!
    
    @IBOutlet weak var viewAddrss: UIView!
    
    @IBOutlet weak var viewaddressheight: NSLayoutConstraint!
    
    
    // MARK: - VARIABLES -
    
    var uploadImage1 : UIImage!
    
    var imagePicker = UIImagePickerController()
    
    var fileID : NSURL!
    var fileCV : NSURL!
    var fileAudio : NSURL!
    
    var filetype = 0
    
    var userid = ""
    
    var stud_rate : Float = 0.0
    
    var stroj = TeacherList()
    
    var isfileCV = false
    var isfileID = false
    var isfileAudio = false
    var isProfileimage = false
    
    var _locationManager = CLLocationManager()
    
     var arravail = [[String : AnyObject]]()
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if kCurrentUser()?.role == "admin" || kCurrentUser()?.role == "student"
        {
            viewTeacherheader.isHidden = true
            
            if kCurrentUser()?.role == "student"
            {
                disablefieldsStudent()
            }else{
                viewRateTeacher.isHidden = true
                viewrateteacherheight.constant = 0.0
            }
            
            
        }else{
            
            viewRateTeacher.isHidden = true
            viewrateteacherheight.constant = 0.0
            
            if kCurrentUser()?.is_active == "2"
            {
                viewTeacherheader.isHidden = true
            }
            userid = (kCurrentUser()?.userid)!
            
        }
        txtEmail.isUserInteractionEnabled = false
        
        setBordertoView()
        
        callAPI()
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
        
        if kCurrentUser()?.role == "admin" || kCurrentUser()?.role == "teacher"
        {
            if homeaddress != ""
            {
                txtRailway.text = homeaddress
                homeaddress = ""
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - VOID METHODS -
    
    func GetHomeLocation(isYes: Bool, straddress: String) {
        if isYes
        {
            txtRailway.text = straddress
        }else{
            txtRailway.text = ""
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func disablefieldsStudent()
    {
        viewID.isHidden = true
        viewCV.isHidden = true
        viewIDHeight.constant = 0.0
        viewCVHeight.constant = 0.0
        viewhourlyheight.constant = 0.0
        viewaddressheight.constant = 0.0
        
        viewAddrss.isHidden = true
        viewhourlyrate.isHidden = true
        viewEmail.isHidden = true
        viewWechat.isHidden = true
        viewemailHeight.constant = 0.0
        viewWechatheight.constant = 0.0
        
        
        viewRating.delegate = self
        viewRating.editable = true
        viewRating.emptyImage = #imageLiteral(resourceName: "ic_StarUnSelected")
        viewRating.fullImage = #imageLiteral(resourceName: "ic_StarSelected")
        viewRating.floatRatings = true
        viewRating.maxRating = 5
        
        
        btnSubmit.setTitle(ValidMsg.requestteacher.rawValue, for: .normal)
        
        btnProfile.isUserInteractionEnabled = false
        btnAudio.isUserInteractionEnabled = false
        
        txthourlyrate.isUserInteractionEnabled = false
        txtnearestrailwaystation.isUserInteractionEnabled = false
        txtFullname.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtSkills.isUserInteractionEnabled = false
        txtwechat.isUserInteractionEnabled = false
        txtRailway.isUserInteractionEnabled = false
        txtUsername.isUserInteractionEnabled = false
        txtAvailability.isUserInteractionEnabled = false
        txtCV.isUserInteractionEnabled = false
        txtAudio.isUserInteractionEnabled = false
        txtIDproof.isUserInteractionEnabled = false
        
        
}
    
    
    
    func setBordertoView()
    {
        
        viewTeacherRate.editable = false
        viewTeacherRate.emptyImage = #imageLiteral(resourceName: "ic_StarUnSelected")
        viewTeacherRate.fullImage = #imageLiteral(resourceName: "ic_StarSelected")
        viewTeacherRate.floatRatings = true
        viewTeacherRate.maxRating = 5
        
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        btnSubmit.clipsToBounds = true
        
        
        btnRateSubmit.layer.cornerRadius = btnRateSubmit.frame.size.height/2
        btnRateSubmit.clipsToBounds = true
        
        viewCanvas.layer.cornerRadius = viewCanvas.frame.size.height/2
        viewCanvas.clipsToBounds = true
        
        
        viewimg.layer.cornerRadius = viewimg.frame.size.height/2
        viewimg.clipsToBounds = true
        
        imgprofile.layer.cornerRadius = imgprofile.frame.size.height/2
        imgprofile.clipsToBounds = true
        
        
    }
    
    func callAPI()
    {
        var param : [String : String] =
            [
                p_role : "teacher",
                p_uId : userid,
            ]
        
        if kCurrentUser()?.role == "student"
        {
            param[p_stu_id] = kCurrentUser()?.userid
        }
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getProfile.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            self.stroj.updatesingle(data: dict)
            
            print(self.stroj.objSingle.userid)
            
            self.updatefields()
            
        })
    }
    
    func callRatingSubmitAPI()
    {
        let param : [String : String] =
            [
                p_teacherId : userid,
                p_studentId : (kCurrentUser()?.userid)!,
                p_action : "rating",
                p_rating : stud_rate.description
            ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.getaddress.rawValue, handler: { response in
            
            print(JSON(response))
            
            Utilities.showMessage(text: ValidMsg.thankyouforrating.rawValue + " \(self.stroj.objSingle.fullName)")
            
        })
    }
    
    func callRequestSubmitAPI()
    {
        let param : [String : String] =
            [
                p_teacherId : userid,
                p_studentId : (kCurrentUser()?.userid)!,
        ]
        //teacherId , studentId , add_request.php
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.requestTeacher.rawValue, handler: { response in
            
            print(JSON(response))
            
            Utilities.showMessage(text: ValidMsg.requesthasbeen.rawValue + " \(self.stroj.objSingle.fullName)")
            
        })
    }
    
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
             }
            
        })
    }
    
   
    func updatefields()
    {
       
        if stroj.objSingle.is_active == "1" && kCurrentUser()?.role != "admin" && kCurrentUser()?.role != "student"
        {
            _locationManager = CLLocationManager()
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.requestWhenInUseAuthorization()
            _locationManager.startUpdatingLocation()
            
        }else{
            
            if kCurrentUser()?.role == "student"
            {
                stud_rate = Float(stroj.objSingle.rating)!
                viewRating.rating = Float(stud_rate)
            }else{
                if stroj.objSingle.latitude != "" &&  stroj.objSingle.longitude != ""
                {
                    curr_lat = Double(stroj.objSingle.latitude)!
                    curr_long = Double(stroj.objSingle.longitude)!
                }
            }
            
            txtRailway.text = stroj.objSingle.address
        }
        
        
       
        
        
        if stroj.objSingle.total_ratings != ""
        {
            viewTeacherRate.rating = Float(stroj.objSingle.total_ratings)!
        }else{
            viewTeacherRate.rating = 0.0
        }
        
        txtUsername.isUserInteractionEnabled = false
        
        txtnearestrailwaystation.text = stroj.objSingle.nearest_station
        txthourlyrate.text = stroj.objSingle.hourly_rate
        
        txtFullname.text = stroj.objSingle.fullName
        txtUsername.text = stroj.objSingle.username
        txtEmail.text = stroj.objSingle.email
       
        txtwechat.text = stroj.objSingle.mob_no
        
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
        
        txtSkills.text = stroj.objSingle.skills
        
        if stroj.objSingle.resume != ""
        {
            txtCV.text = stroj.objSingle.fullName + "-" + "CV"
            
            fileCV = NSURL(string: stroj.objSingle.resume)
        }
        
        if stroj.objSingle.profileImage != ""
        {
            imgprofile.contentMode = .scaleAspectFit
            
            imgprofile.kf.indicatorType = .activity
            imgprofile.kf.setImage(with: URL(string : stroj.objSingle.profileImage) )
            
            uploadImage1 = imgprofile.image
        }
        
        if stroj.objSingle.idImage != ""
        {
            txtIDproof.text = stroj.objSingle.fullName + "-" + "ID"
            fileID = NSURL(string: stroj.objSingle.idImage)
        }
        
        if stroj.objSingle.audioFile != ""
        {
            txtAudio.text = stroj.objSingle.fullName + "-" + "Audio File"
            fileAudio = NSURL(string: stroj.objSingle.audioFile)
        }
        
    }
    
    func Validate() -> Bool
    {
        if (txtRailway.text?.isEmpty)! || curr_lat == 0.0 || curr_long == 0.0
        {
            Utilities.showMessage(text: ValidMsg.addressvalid.rawValue)
            return false
        }
        return true
    }

    
    func CallUploadAPI()
    {
        //lat=10.121212&lng=23.132213
        
        var param : [String : String] =
            [
                p_fullname : txtFullname.text!,
                p_uId : userid,
               // p_available_time : txtAvailability.text!,
                p_address : txtRailway.text!,
                p_mob_no : txtwechat.text!,
                p_skill : txtSkills.text!,
                p_nearest_railway : txtnearestrailwaystation.text!,
                p_hourly_rate : txthourlyrate.text!,
                p_lat : String(curr_lat),
                p_lng : String(curr_long),
            ]
     
        if !((txtAvailability.text?.isEmpty)!)
        {
            if arravail.count != 0
            {
                let json = JSON(arravail)
                let strjson : String = json.rawString()!
                param[p_available_time] = String(strjson.characters.filter { !" \n\t\r".characters.contains($0) })
            }else{
                 Utilities.showMessage(text: ValidMsg.reenteravailbility.rawValue)
                return
            }
        }else{
            param[p_available_time] = ""
        }
        print(param)
        
     
        
        
    if !self.isProfileimage && !self.isfileAudio && !self.isfileCV && !self.isfileID
    {
       
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.update_teacher.rawValue, handler: { response in
            
            print(JSON(response))
            
            Utilities.showMessage(text: ValidMsg.detailsupdated.rawValue)
            
            curr_lat = 0.0
            curr_long = 0.0
            
            if kCurrentUser()?.role == "admin"
            {
                _ = self.navigationController?.popViewController(animated : true)
            }else{
                
                if kCurrentUser()?.role == "teacher"
                {
                    let user = kCurrentUser()
                    
                    if kCurrentUser()?.is_active == "1"
                    {
                        user?.is_active = "2"
                    }
                    user?.saveToDefaults()
                }
                appInstance.GotocheckScreens()
            }
            
        })
        
    }else{
    
        let reachablecheck = Reachability()
        
        if (reachablecheck?.isReachable)!
        {
    
            var imageData1 : Data!
            
            var fileDocID : Data!
            var fileDocCV : Data!
            var fileDocAudio : Data!
            
            if uploadImage1 != nil
            {
                imageData1 =  UIImageJPEGRepresentation(imgprofile.image!, 0)
            }
            if fileID != nil
            {
                fileDocID = NSData(contentsOf: fileID as URL)! as Data
            }
            if fileCV != nil
            {
                fileDocCV = NSData(contentsOf: fileCV as URL)! as Data
            }
            if fileAudio != nil
            {
                fileDocAudio = NSData(contentsOf: fileAudio as URL)! as Data
            }
            
            appInstance.showLoader()
            
            Alamofire.upload(multipartFormData:
                {
                    
                    (multipartFormData) in
                    
                    if imageData1 != nil
                    {
                        if self.isProfileimage
                        {
                            multipartFormData.append(imageData1!, withName: "proImage", fileName: "file1.jpg", mimeType: "image/png")
                        }
                    }
                    
                    if fileDocID != nil
                    {
                        if self.isfileID
                        {
                            
                            let strtype : NSString = self.fileID.path! as NSString
                            
                            if strtype.pathExtension == "pdf"
                            {
                                multipartFormData.append(fileDocID!, withName: "idProof", fileName: "file2.pdf", mimeType: "application/pdf")
                            }else if strtype.pathExtension == "doc"
                            {
                                multipartFormData.append(fileDocID!, withName: "idProof", fileName: "file2.doc", mimeType: "application/msword")
                            }else{
                                 multipartFormData.append(fileDocID!, withName: "idProof", fileName: "file2.jpg", mimeType: "image/png")
                            }
                           
                        }
                    }
                    
                    if fileDocCV != nil
                    {
                        if self.isfileCV
                        {
                            let strtype : NSString = self.fileCV.path! as NSString
                            
                            if strtype.pathExtension == "pdf"
                            {
                                multipartFormData.append(fileDocCV!, withName: "resume", fileName: "DocCV.pdf", mimeType: "application/pdf")
                            }else if strtype.pathExtension == "doc"
                            {
                                multipartFormData.append(fileDocCV!, withName: "resume", fileName: "DocCV.doc", mimeType: "application/msword")
                            }else{
                                multipartFormData.append(fileDocCV!, withName: "resume", fileName: "DocCV.jpg", mimeType: "image/png")
                            }
                         
                        }
                    }
                    
                    if fileDocAudio != nil
                    {
                        if self.isfileAudio
                        {
                            multipartFormData.append(fileDocAudio!, withName: "audioFile", fileName: "DocAudio.mp3", mimeType: "audio/mpeg")
                        }
                    }
                    
                    
                    for (key, value) in param
                    {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
            },  to: (baseURL + APIAction.update_teacher.rawValue), encodingCompletion:
                {
                    encodingResult in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure:
                            {
                                (Progress) in
                                
                        })
                        upload.responseJSON
                            {
                                response in
                                
                                appInstance.hideLoader()
                                
                                if response.result.isSuccess
                                {
                                    if response.response!.statusCode == 200
                                    {
                                        if (response.result.value != nil)
                                        {
                                            let dict = JSON(response)
                                            
                                            print(dict)
                                            
                                            Utilities.showMessage(text: ValidMsg.teacherupdated.rawValue)
                                            
                                            
                                            curr_lat = 0.0
                                            curr_long = 0.0
                                            
                                            if kCurrentUser()?.role == "admin"
                                            {
                                                _ = self.navigationController?.popViewController(animated : true)
                                            }else{
                                                
                                                if kCurrentUser()?.role == "teacher"
                                                {
                                                    let user = kCurrentUser()
                                                    
                                                    if kCurrentUser()?.is_active == "1"
                                                    {
                                                        user?.is_active = "2"
                                                    }
                                                    user?.saveToDefaults()
                                                }
                                                appInstance.GotocheckScreens()
                                            }
                                            
                                        }
                                    }else
                                    {
                                        print("Error")
                         
                                    }
                                }
                                
                        }
                        
                    case .failure( _):
                        appInstance.hideLoader()
                    }
            })
        }else{
            Utilities.showMessage(text: ValidMsg.noInternetConnection.rawValue)
        }
        }
        
    }
    
    
    
    // MARK: - CLICKED EVENTS -
    
    
    @IBAction func btnAddressClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "MapViewViewController", onStoryboard: Sbname.Home.rawValue) as! MapViewViewController
        VC.lat = curr_lat
        VC.long = curr_long
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        appInstance.LogoutPopup()
        
    }
    
    @IBAction func btnAvailabilityClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if kCurrentUser()?.role != "student"
        {
           
            let VC = Utilities.viewController(name: "AvailabilityTimeViewController", onStoryboard: Sbname.Home.rawValue) as! AvailabilityTimeViewController
            VC.strAvail = txtAvailability.text!
            VC.arravail = arravail
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        curr_long = 0.0
        curr_lat = 0.0
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if kCurrentUser()?.role == "student"
        {
            
           callRequestSubmitAPI()
            
        }else{
            if Validate()
            {
                CallUploadAPI()
            }
        }
    }
    
    @IBAction func btnUploadIDClicked(_ sender: UIButton) {
        
        let DocPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf","com.microsoft.word.doc","public.image"], in: .import)
        DocPicker.delegate = self
        filetype = 1
        self.present(DocPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnUploadCVClicked(_ sender: UIButton) {
        
        let DocPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf","com.microsoft.word.doc", "public.image"], in: .import)
        DocPicker.delegate = self
        filetype = 2
        self.present(DocPicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnUploadAudioClicked(_ sender: UIButton) {
        
        let DocPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        DocPicker.delegate = self
        filetype = 3
        self.present(DocPicker, animated: true, completion: nil)
        
        txtAudio.text = stroj.objSingle.fullName + "-" + "Audio File"
        
        
    }
    
    @IBAction func btnDownloadCV(_ sender: UIButton) {
        
        if fileCV != nil
        {
            
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

            appInstance.showLoader()
            Alamofire.download(fileCV as URL, to: destination).responseData { response in
                
                appInstance.hideLoader()
                    if let str = response.destinationURL {
                        let DocPicker = UIDocumentPickerViewController(url: str as URL, in: .exportToService)
                        DocPicker.delegate = self
                        
                        self.present(DocPicker, animated: true, completion: nil)
                    }
            }
        }
        
    }
    
    
    @IBAction func btnDownloadAudioClicked(_ sender: UIButton) {
       
        if fileAudio != nil
        {
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            appInstance.showLoader()
            Alamofire.download(fileAudio as URL, to: destination).responseData { response in
                
                appInstance.hideLoader()
                if let str = response.destinationURL {
                    let DocPicker = UIDocumentPickerViewController(url: str as URL, in: .exportToService)
                    DocPicker.delegate = self
                    
                    self.present(DocPicker, animated: true, completion: nil)
                }
            }
          
        }
    }
    
    @IBAction func btnImgUploadClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
      
        pickerimageview()
        
    }
    
    
    
    @IBAction func btnRateSubmitClicked(_ sender: UIButton) {
        
        //getaddress
        callRatingSubmitAPI()
        
    }
    
    
    
    // MARK: - IMAGE UPLOAD -
    
    func takePhotoWithCamera() {
        
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if status == .authorized {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            imagePicker.view.tintColor = view.tintColor
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        else if status == .denied || status == .restricted{
            
            let alertController = UIAlertController (title: "Please provide Camera access permission by going into Settings", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
            
        else{
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {(granted: Bool) -> Void in
                if granted {
                    
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true
                    imagePicker.view.tintColor = self.view.tintColor
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
                else {
                }
            })
            
        }
        
    }
    
    func choosePhotoFromLibrary() {
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.view.tintColor = view.tintColor
            present(imagePicker, animated: true, completion: nil)
        }
        else if (status == PHAuthorizationStatus.denied) || (status == PHAuthorizationStatus.restricted) {
            let alertController = UIAlertController (title: "Please provide Gallery access permission by going into Settings", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
            
        else{
            PHPhotoLibrary.requestAuthorization({(status: PHAuthorizationStatus) -> Void in
                if status == .authorized {
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.view.tintColor = self.view.tintColor
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                        if imagePicker.responds(to: #selector(getter: UIViewController.popoverPresentationController))
                        {
                            imagePicker.popoverPresentationController?.sourceView = self.view
                        }
                    }
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            })
            
        }
    }
    
    
    // MARK:  Imagepicker Method
    func pickerimageview() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in self.takePhotoWithCamera()})
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Photo Library" , style: .default, handler: {_ in self.choosePhotoFromLibrary()})
        alertController.addAction(chooseFromLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
            alertController.popoverPresentationController!.sourceView = self.view
            alertController.popoverPresentationController!.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0 )
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            self.present(alertController, animated: true,
                         completion: nil)
        }
    }
    
    
    //MARK: ----------------- ACTION SHEET DELEGATE -------------------------
    
    func actionSheet(_ sheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 1 :
            let status : PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            if (status == PHAuthorizationStatus.authorized) {
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.imagePicker.allowsEditing = false
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                    self.presentedViewController!.dismiss(animated: true, completion: { _ in })
                    
                    self.present(self.imagePicker, animated: true,
                                 completion: nil)
                }
                else
                {
                    self.present(self.imagePicker, animated: true,
                                 completion: nil)
                }
                
            }
                
            else if (status == PHAuthorizationStatus.denied) {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                    PHPhotoLibrary.requestAuthorization({ (status) in
                        if (status == PHAuthorizationStatus.authorized) {
                            self.imagePicker =  UIImagePickerController()
                            self.imagePicker.delegate = self
                            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                            self.imagePicker.allowsEditing = false
                            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                                self.present(self.imagePicker, animated: true,
                                             completion: nil)
                            }
                            else
                            {
                                self.present(self.imagePicker, animated: true,
                                             completion: nil)
                            }
                        }
                        else {
                            
                        }
                    })
                    
                }
                let alertController = UIAlertController (title: "Please provide Photos Access", message: "", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
            }
                
            else if (status == PHAuthorizationStatus.notDetermined) {
                PHPhotoLibrary.requestAuthorization({ (status) in
                    if (status == PHAuthorizationStatus.authorized) {
                        self.imagePicker =  UIImagePickerController()
                        self.imagePicker.delegate = self
                        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                        self.imagePicker.allowsEditing = false
                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                            self.present(self.imagePicker, animated: true,
                                         completion: nil)
                        }
                        else
                        {
                            self.present(self.imagePicker, animated: true,
                                         completion: nil)
                        }
                    }
                        
                    else {
                        
                    }
                })
                
            }
                
            else if (status == PHAuthorizationStatus.restricted) {
            }
        case 2 :
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                if status == .authorized {
                    imagePicker =  UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                        self.presentedViewController!.dismiss(animated: true, completion: { _ in })
                        
                        self.present(self.imagePicker, animated: true,
                                     completion: nil)
                    }
                    else
                    {
                        present(imagePicker, animated: true, completion: nil)
                    }
                    
                }
                else if status == .denied {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                        Utilities.showMessage(text: "Please provide camera Access")
                    }
                    let alertController = UIAlertController (title: "Please provide camera Access", message: "", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true,
                                 completion: nil)
                }
                else if status == .restricted {
                }
                else if status == .notDetermined {
                    AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {(granted: Bool) -> Void in
                        if granted {
                            self.imagePicker =  UIImagePickerController()
                            self.imagePicker.delegate = self
                            self.imagePicker.sourceType = .camera
                            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
                                self.present(self.imagePicker, animated: true,
                                             completion: nil)
                            }
                            else
                            {
                                self.present(self.imagePicker, animated: true, completion: nil)
                            }
                        }
                        else {
                        }
                    })
                }
            }
            else
            {
                Utilities.showMessage(text: "Camera not found")
            }
        default :
            print("default")
        }
    }
    
    
    
    
    // MARK: -ImagePicker Delegate-
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            isProfileimage = true
            uploadImage1 = pickedImage
            imgprofile.contentMode = .scaleAspectFit
            imgprofile.image = pickedImage
            
        }
        dismiss(animated:
            true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}




// MARK: - EXTENSION -

extension TeacherEditViewController : UIDocumentPickerDelegate
{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
      
        print(url)
        
        if controller.documentPickerMode == .import
        {
            if filetype == 1
            {
                isfileID = true
                txtIDproof.text = stroj.objSingle.fullName + "-" + "ID"
                fileID = url as NSURL
            }else if filetype == 2
            {
                isfileCV = true
                txtCV.text = stroj.objSingle.fullName + "-" + "CV"
                fileCV = url as NSURL
            }else if filetype == 3
            {
                isfileAudio = true
                txtAudio.text = stroj.objSingle.fullName + "-" + "Audio File"
                fileAudio = url as NSURL
            }
        }else if controller.documentPickerMode == .exportToService
        {
            Utilities.showMessage(text: ValidMsg.filesdownloaded.rawValue)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancel")
        filetype = 0
    }
    
}


extension TeacherEditViewController : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let loc = locations.last
        
//        print("Lat :: \(loc?.coordinate.latitude)")
//        print("Long :: \(loc?.coordinate.longitude)")

        if loc != nil
        {
            if let strlat = loc?.coordinate.latitude, let strlong = loc?.coordinate.longitude
            {
                if kCurrentUser()?.role != "student"
                {
                    //self.callGetAddressAPI(lat : strlat, long : strlong)
                    curr_lat = strlat
                    curr_long = strlong
                    
                }
            }
        }
        
        _locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
        
        _locationManager.stopUpdatingLocation()
        
    }
}

extension TeacherEditViewController : FloatRatingViewDelegate
{
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        print("**\(rating)")
        
        stud_rate = rating
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float) {
        print("%%%\(rating)")
    }
    
}

extension TeacherEditViewController : UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if txthourlyrate == textField
        {
            if string == ""
            {
                return true
            }
            if (Utilities.isValidRegex(testStr: string, regex: "^[0-9]")) || string == "."
            {
                return true
            }else{
                return false
            }
            
        }
        return true
    }
    
}

