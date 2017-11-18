//
//  BaseValidationViewController.swift
//  Leazzer
//
//  Created by Manoj MacMini12 on 24/08/16.
//  Copyright © 2016 Manoj MacMini12. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftyJSON


class BaseValidationViewController : UIViewController, NVActivityIndicatorViewable {
    
    var isApiInCall : Bool = false
   
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: - LOADEr -
    func showLoader() {
        isApiInCall = true
        stopAnimating()
        self.view.isUserInteractionEnabled = false
        NVActivityIndicatorView.DEFAULT_COLOR  = UIColor.green
        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotate
        
        startAnimating()
    }
    
    func hideLoader() {
        
        isApiInCall = false
        self.view.isUserInteractionEnabled = true
        stopAnimating()
    }
    
    
    // MARK: - LOCATION API -
    func locationapi(lat : Double , long : Double)
    {
//        let param : [String : String] =
//            [
//                p_userid : (GetUserDetails()?.userid.description)!,
//                p_latitude : lat.description,
//                p_longitude : long.description,
//                p_trip_id : "17",//tripidstart
//        ]
//        AlamofireModel.GetUpdateLocationtoServer(parameter: param as NSDictionary,URL:Endpoint.setupdateLocation.rawValue, handler: {(response) in
//            //   let data = JSON(response)
//            
//            print("Loc Updated Successfully")
//            
//        })
    }

    
    // MARK: - FETCH COUNTRY CODE FROM STATIC JSON -
    
//    func CountryListJSONparse(dial : CountryList, controller : UIViewController)
//    {
//        if let urlPath = Bundle.main.url(forResource: "countries", withExtension: "json")
//        {
//            do {
//                let jsonData = try Data(contentsOf: urlPath, options: .mappedIfSafe)
//
//                let jsonResult = CountryCode(data: JSON(data: jsonData))
//
//                print(jsonResult)
//
//                jsonResult.objcodelist.sort(by: { (first: CountryList, second: CountryList) -> Bool in
//                    first.name < second.name
//                })
//
//                if jsonResult.objcodelist.count > 0
//                {
//
//                    let resultVC = Utilities.viewController(name: VCname.countrycode.rawValue, onStoryboard: Sbname.Authen.rawValue) as? CountryListPopupController
//
//                    resultVC?.dataArray = jsonResult.objcodelist
//                    resultVC?.dialcodevalue = dial
//
//                    controller.present(resultVC!, animated: true, completion: nil)
//
//                }
//
//            }
//
//            catch let jsonError {
//                print(jsonError)
//            }
//
//        }
//
//    }

    
    //GETEMAIL from POPUP
    func LogoutPopup()
    {
        let alertpopup = UIAlertController(title: "Hungry English", message: ValidMsg.logout.rawValue, preferredStyle: .alert)
        
        alertpopup.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
        
            switch action.style{
                case .cancel:
                    print("cancel")
                
                case .default:
                    print("default")
            case .destructive:
                print("destructive")
            }
         
        }))
        
        alertpopup.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
           
            switch action.style
            {
                case .default :
                    print("Yes")
                
                    kCurrentUser()?.logout()
             
                case .cancel :
                    print("cancel")
                case .destructive:
                    print("destructive")
                
            }
        }))
    
        UIApplication.shared.keyWindow?.rootViewController?.present(alertpopup, animated: true, completion: nil)
        
    }
    
    
    func NavigateEmailPopup(is_FB: Bool, controller : UIViewController)
    {
//        let viewVC : EmailPopupViewController = Utilities.viewController(name: VCname.emailpopup.rawValue, onStoryboard: Sbname.Authen.rawValue) as! EmailPopupViewController
//        viewVC.modalPresentationStyle = .overFullScreen
//        viewVC.is_FB = is_FB
//        viewVC.controller = controller
//        UIApplication.shared.keyWindow?.rootViewController?.present(viewVC, animated: true, completion: nil)
    }
    
   
    
}


