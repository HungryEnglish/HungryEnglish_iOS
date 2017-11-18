//
//  AddImageLinkViewController.swift
//  demosetup
//
//  Created by Nikunj on 22/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Photos
import PhotosUI
import Alamofire
import ReachabilitySwift

class AddImageLinkViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var viewimg1: UIView!
    
    @IBOutlet weak var viewimg1link: UIView!
    
    @IBOutlet weak var viewimg2: UIView!
    
    @IBOutlet weak var viewimg2link: UIView!
    
    @IBOutlet weak var viewimg3: UIView!
    
    @IBOutlet weak var viewlink1: UIView!
    
    @IBOutlet weak var viewlink2: UIView!
    
    @IBOutlet weak var viewlink3: UIView!
    
    @IBOutlet weak var viewlink4: UIView!
    
    @IBOutlet weak var viewlink5: UIView!
    
    @IBOutlet weak var viewlink6: UIView!
    
    @IBOutlet weak var viewbtnadd: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var txtimg1link: FloatLabelTextField!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var txtimg2link: FloatLabelTextField!
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var viewimg3link: UIView!
    
    @IBOutlet weak var txtimg3link: FloatLabelTextField!
    
    @IBOutlet weak var txtlink1title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink1: FloatLabelTextField!
    
    @IBOutlet weak var txtlink2title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink2: FloatLabelTextField!
    
    @IBOutlet weak var txtlink3title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink3: FloatLabelTextField!
    
    @IBOutlet weak var viewlink4height: NSLayoutConstraint!//90
    
    @IBOutlet weak var txtlink4title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink4: FloatLabelTextField!
    
    @IBOutlet weak var viewlink5height: NSLayoutConstraint!
    
    @IBOutlet weak var txtlink5title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink5: FloatLabelTextField!
    
    @IBOutlet weak var viewlink6height: NSLayoutConstraint!
    
    @IBOutlet weak var txtlink6title: FloatLabelTextField!
    
    @IBOutlet weak var txtlink6: FloatLabelTextField!
    
    @IBOutlet weak var viewaddbtnheight: NSLayoutConstraint!//30
    
    @IBOutlet weak var btnAddmore: UIButton!
    
    
    // MARK: - VARIABLES -
    
    var uploadImage1 : UIImage!
    var uploadImage2 : UIImage!
    var uploadImage3 : UIImage!
    
    var imagePicker = UIImagePickerController()
    
    var obj  = AdminImageLink()
    
    var imgclicked = 10
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - VOID METHODS -
    
    func callAPI()
    {
        let param : [String : String] =
            [
                "": ""
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.admingetimglink.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            self.obj = AdminImageLink(data: dict["info"])
          
            self.updatedetails()
        })
    }
    
    
    func updatedetails()
    {
        
        if obj.title1 == ""
        {
            txtlink1title.text = ""
            txtlink1.text = ""
            txtlink1title.placeholder = ValidMsg.title1.rawValue
            txtlink1.placeholder = ValidMsg.link1.rawValue
        }else{
            txtlink1title.text = obj.title1
            txtlink1.text = obj.link1
        }
        
        if obj.title2 == ""
        {
            txtlink2title.text = ""
            txtlink2.text = ""
            txtlink2title.placeholder = ValidMsg.title2.rawValue
            txtlink2.placeholder = ValidMsg.link2.rawValue
        }else{
            txtlink2title.text = obj.title2
            txtlink2.text = obj.link2
        }
        
        if obj.title3 == ""
        {
            txtlink3title.text = ""
            txtlink3.text = ""
            txtlink3title.placeholder = ValidMsg.title3.rawValue
            txtlink3.placeholder = ValidMsg.link3.rawValue
        }else{
            txtlink3title.text = obj.title3
            txtlink3.text = obj.link3
        }
        
        if obj.title4 == ""
        {
            viewlink4.isHidden = true
            viewlink4height.constant = 0.0
            txtlink4title.text = ""
            txtlink4.text = ""
            txtlink4title.placeholder = ValidMsg.title4.rawValue
            txtlink4.placeholder = ValidMsg.link4.rawValue
            viewbtnadd.isHidden = false
            
        }else{
          
            viewlink4.isHidden = false
            viewlink4height.constant = 90.0
            
            txtlink4title.text = obj.title4
            txtlink4.text = obj.link4
        }
        
        if obj.title5 == ""
        {
            
            viewlink5.isHidden = true
            
            viewlink5height.constant = 0.0
            txtlink5title.text = ""
            txtlink5.text = ""
            txtlink5title.placeholder = ValidMsg.title5.rawValue
            txtlink5.placeholder = ValidMsg.link5.rawValue
            viewbtnadd.isHidden = false
            
        }else{
            viewlink5.isHidden = false
            
            viewlink5height.constant = 90.0
            
            txtlink5title.text = obj.title5
            txtlink5.text = obj.link5
        }
        
        if obj.title6 == ""
        {
            viewlink6.isHidden = true
            
            viewlink6height.constant = 0.0
            txtlink6title.text = ""
            txtlink6.text = ""
            txtlink6title.placeholder = ValidMsg.title6.rawValue
            txtlink6.placeholder = ValidMsg.link6.rawValue
            viewbtnadd.isHidden = false
            
        }else{
           
            viewlink6.isHidden = false
            
            viewbtnadd.isHidden = true
            viewlink6height.constant = 90.0
            txtlink6title.text = obj.title6
            txtlink6.text = obj.link6
        }
        
       if obj.image1 == ""
       {
            txtimg1link.text = ""
            txtimg1link.placeholder = ValidMsg.imglink1.rawValue
        
       }else{
        
            img1.contentMode = .scaleAspectFit
        
            img1.kf.indicatorType = .activity
            img1.kf.setImage(with: URL(string : obj.image1) )
        
            uploadImage1 = img1.image
            txtimg1link.text = obj.imglink1
        
       }
        if obj.image2 == ""
        {
            txtimg2link.text = ""
            txtimg2link.placeholder = ValidMsg.imglink2.rawValue
            
        }else{
            
            img2.contentMode = .scaleAspectFit
            img2.kf.indicatorType = .activity
            img2.kf.setImage(with: URL(string : obj.image2) )
            
            uploadImage2 = img2.image
            
            txtimg2link.text = obj.imglink2
            
        }
        
        if obj.image3 == ""
        {
            txtimg3link.text = ""
            txtimg3link.placeholder = ValidMsg.imglink3.rawValue
        }else{
          
            img3.contentMode = .scaleAspectFit
            img3.kf.indicatorType = .activity
            img3.kf.setImage(with: URL(string : obj.image3))
            
            uploadImage3 = img3.image
            
            txtimg3link.text = obj.imglink3
        }
    }
    
    
    
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
            
            let alertController = UIAlertController (title: ValidMsg.pleaseprovideaccesscamera.rawValue, message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: ValidMsg.ok.rawValue, style: .default, handler: nil)
            
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
            let alertController = UIAlertController (title: ValidMsg.pleaseprovideaccessgallery.rawValue, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: ValidMsg.ok.rawValue, style: .default, handler: nil)
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
        
        let takePhotoAction = UIAlertAction(title: ValidMsg.camera.rawValue, style: .default, handler: { _ in self.takePhotoWithCamera()})
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: ValidMsg.photolibrary.rawValue , style: .default, handler: {_ in self.choosePhotoFromLibrary()})
        alertController.addAction(chooseFromLibraryAction)
        
        let cancelAction = UIAlertAction(title: ValidMsg.cancel.rawValue, style: .cancel, handler: nil)
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
                let alertController = UIAlertController (title: ValidMsg.providephotosaccess.rawValue, message: "", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: ValidMsg.ok.rawValue , style: .default, handler: nil)
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
                        Utilities.showMessage(text: ValidMsg.cameraaccess.rawValue)
                    }
                    let alertController = UIAlertController (title:ValidMsg.cameraaccess.rawValue, message: "", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: ValidMsg.ok.rawValue, style: .default, handler: nil)
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
                Utilities.showMessage(text: ValidMsg.cameranotfound.rawValue)
            }
        default :
            print("default")
        }
    }
    
    
    
    
    // MARK: -ImagePicker Delegate-
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if imgclicked == 0
            {
                uploadImage1 = pickedImage
                img1.contentMode = .scaleAspectFit
                img1.image = pickedImage
            }else if imgclicked == 1
            {
                 uploadImage2 = pickedImage
                img2.contentMode = .scaleAspectFit
                img2.image = pickedImage
            }else if imgclicked == 2
            {
                uploadImage3 = pickedImage
                img3.contentMode = .scaleAspectFit
                img3.image = pickedImage
            }else{
                
            }
         
            
        }
        dismiss(animated:
            true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func validate() -> Bool
    {
        if uploadImage1 == nil && obj.image1 == ""
        {
            Utilities.showMessage(text : ValidMsg.img1.rawValue)
        }else if txtimg1link.text == ""
        {
            Utilities.showMessage(text : ValidMsg.enterimglink1.rawValue)
            
        }else if uploadImage2 == nil && obj.image2 == ""
        {
            Utilities.showMessage(text : ValidMsg.img2.rawValue)

        }else if txtimg2link.text == ""
        {
            Utilities.showMessage(text : ValidMsg.enterimglink2.rawValue)
            
        }else if uploadImage3 == nil && obj.image3 == ""
        {
            Utilities.showMessage(text : ValidMsg.img3.rawValue)
        }else if txtimg3link.text == ""
        {
            Utilities.showMessage(text : ValidMsg.enterimglink3.rawValue)
            
        }else if txtlink1title.text == ""
        {
            Utilities.showMessage(text : ValidMsg.entertitle1.rawValue)
            
        }else if txtlink1.text == ""
        {
            Utilities.showMessage(text : ValidMsg.titlelink1.rawValue)
            
        }else if txtlink2title.text == ""
        {
            Utilities.showMessage(text : ValidMsg.entertitle2.rawValue)
            
        }else if txtlink2.text == ""
        {
            Utilities.showMessage(text : ValidMsg.titlelink2.rawValue)
            
        }else if txtlink3title.text == ""
        {
            Utilities.showMessage(text : ValidMsg.entertitle3.rawValue)
            
        }else if txtlink3.text == ""
        {
            Utilities.showMessage(text : ValidMsg.titlelink3.rawValue)
        }
        else{
            return true
        }
        
        return false
    }
    
    
    func CallUploadAPI()
    {
        let reachablecheck = Reachability()
        
        if (reachablecheck?.isReachable)!
        {
        
        var parameters : [String : String] =
            [
                p_link1 : txtlink1title.text! + "--" + txtlink1.text! + "--" + txtimg1link.text! ,
                p_link2 : txtlink2title.text! + "--" + txtlink2.text! + "--" + txtimg2link.text! ,
                p_link3 : txtlink3title.text! + "--" + txtlink3.text! + "--" + txtimg3link.text! ,
                
            ]
        
        if txtlink4title.text != "" && txtlink4.text != ""
        {
            parameters[p_link4] = txtlink4title.text! + "--" + txtlink4.text!
        }
        
        if txtlink5title.text != "" && txtlink5.text != ""
        {
            parameters[p_link5] = txtlink5title.text! + "--" + txtlink5.text!
        }
        
        if txtlink6title.text != "" && txtlink6.text != ""
        {
            parameters[p_link6] = txtlink6title.text! + "--" + txtlink6.text!
        }
        
        print(parameters)
        
        
        let imageData1 =  UIImageJPEGRepresentation(img1.image!, 0)
        let imageData2 =  UIImageJPEGRepresentation(img2.image!, 0)
        let imageData3 =  UIImageJPEGRepresentation(img3.image!, 0)
        
        
        appInstance.showLoader()
        
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(imageData1!, withName: "image1", fileName: "file1.jpg", mimeType: "image/png")
                multipartFormData.append(imageData2!, withName: "image2", fileName: "file2.jpg", mimeType: "image/png")
                multipartFormData.append(imageData3!, withName: "image3", fileName: "file3.jpg", mimeType: "image/png")
                
                for (key, value) in parameters
                {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
        },
                         to: (baseURL + APIAction.adminupdateimglink.rawValue), encodingCompletion:
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
                                        
                                        Utilities.showMessage(text: ValidMsg.detailsupdated.rawValue)
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
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddMoreClicked(_ sender: UIButton) {
    
        if txtlink3title.text != "" && txtlink3.text != "" && txtlink2.text != "" && txtlink2title.text != "" && txtlink1.text != "" && txtlink1title.text != ""
        {
            viewlink4.isHidden = false
            viewlink4height.constant = 90.0
            
            if txtlink4.text != "" && txtlink4title.text != ""
            {
                viewlink5.isHidden = false
                viewlink5height.constant = 90.0
                
                if txtlink5.text != "" && txtlink5title.text != ""
                {
                    viewlink6.isHidden = false
                    viewlink6height.constant = 90.0
                    
                    viewbtnadd.isHidden = true
                }
            }
         }
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
    
        if validate()
        {
            CallUploadAPI()
        }
        
    }
    
    
    @IBAction func btnimgClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if sender.tag == 0
        {
            imgclicked = 0
        }else if sender.tag == 1
        {
            imgclicked = 1
        }else if sender.tag == 2
        {
            imgclicked = 2
        }
        pickerimageview()
        
    }
    
}
