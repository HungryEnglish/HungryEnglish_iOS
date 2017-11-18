 //
 //  WelcomeViewController.swift
 //  BNHPavilion
 //
 //  Created by Dipen on 03/05/17.
 //  Copyright © 2017 Peerbits 8. All rights reserved.
 //
 
 import UIKit
 import Alamofire
 import Foundation
 import SwiftyJSON
 import ReachabilitySwift
 
 class AlamofireModel: BaseValidationViewController
 {
    typealias CompletionHandler = (_ response:AnyObject) -> Void
    typealias ErrorHandler = (_ error : NSError) -> Void
    
    //POSt
    class func alamofireMethod(methods: Alamofire.HTTPMethod , url : URLConvertible , parameters : [String : String],Header: [String: String],handler:@escaping CompletionHandler,errorhandler : @escaping ErrorHandler)
    {
        
        print(parameters)
        
        var alamofireManager : Alamofire.SessionManager?
        
        var UrlFinal = ""
        do
        {
            try UrlFinal = baseURL + url.asURL().absoluteString
        }catch{}
        print(UrlFinal)
        
        appInstance.showLoader()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 25
        configuration.timeoutIntervalForRequest = 25
        
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager = Alamofire.SessionManager.default
        
        
       
        alamofireManager?.request(UrlFinal, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: Header).responseJSON(queue: nil, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
  
            appInstance.hideLoader()
            
            if response.result.isSuccess
            {
                if response.response!.statusCode == 200
                {
                    if (response.result.value != nil)
                    {
                        handler(response.result.value! as AnyObject)
                    }
                }else if response.response!.statusCode == 401
                {
                    _ = JSON(response.result.value! as AnyObject)
                    
                 //   appInstance.logoutpopupuser(str : dict["message"].string!)
                }
            }
            else
            {
                errorhandler(response.result.error! as NSError)
            }
            
        })
    }
    
    
    
    //GET
    class func alamofireMethodGET(methods: Alamofire.HTTPMethod , url : URLConvertible, showloader : Bool , parameters : [String : String],Header: [String: String],handler:@escaping CompletionHandler,errorhandler : @escaping ErrorHandler)
    {
        
        print(parameters)
        
        var alamofireManager : Alamofire.SessionManager?
        
        var UrlFinal = ""
        do
        {
            try UrlFinal = baseURL + url.asURL().absoluteString
        }catch{}
        print(UrlFinal)
        
        if showloader
        {
            appInstance.showLoader()
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 25
        configuration.timeoutIntervalForRequest = 25
        
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager = Alamofire.SessionManager.default
        
        
        
        alamofireManager?.request(UrlFinal, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: Header).responseJSON(queue: nil, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
            
            appInstance.hideLoader()
            
            if response.result.isSuccess
            {
                if response.response!.statusCode == 200
                {
                    if (response.result.value != nil)
                    {
                        handler(response.result.value! as AnyObject)
                    }
                }else if response.response!.statusCode == 401
                {
                    let dict = JSON(response.result.value! as AnyObject)
                    
                    //   appInstance.logoutpopupuser(str : dict["message"].string!)
                }
            }
            else
            {
                errorhandler(response.result.error! as NSError)
            }
            
        })
    }
    
    
    
    class func alamofireMethodupdatelocation(methods: Alamofire.HTTPMethod , url : URLConvertible , parameters : [String : String],Header: [String: String],handler:@escaping CompletionHandler,errorhandler : @escaping ErrorHandler)
    {
        
        var alamofireManager : Alamofire.SessionManager?
        
        var UrlFinal = ""
        do
        {
            try UrlFinal = baseURL + url.asURL().absoluteString
        }catch{}
        print(UrlFinal)
        
        // appInstance.showLoader()
        //  DELEGATE.showLoader()
        
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "test.example.com": .pinCertificates(
//                certificates: ServerTrustPolicy.certificates(),
//                validateCertificateChain: true,
//                validateHost: true
//            ),
//            "insecure.expired-apis.com": .disableEvaluation
//        ]
//
//        let sessionManager = SessionManager(
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
        
        
        
        
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 25
        configuration.timeoutIntervalForRequest = 25
        
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager = Alamofire.SessionManager.default
        
        alamofireManager?.request(UrlFinal, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: Header).responseJSON(queue: nil, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
            
            //   DELEGATE.hideLoader()
            // appInstance.hideLoader()
            
            if response.result.isSuccess
            {
                if (response.result.value != nil)
                {
                    handler(response.result.value! as AnyObject)
                }
            }
            else
            {
                errorhandler(response.result.error! as NSError)
            }
            
        })
    }
    
    //POST
    // GETDATA FROM SERVER
    class func GetDataFromServer(parameter : NSDictionary, URL : URLConvertible, handler:@escaping CompletionHandler)
    {
        let reachablecheck = Reachability()
        
        if (reachablecheck?.isReachable)!
        {
//            if kCurrentUser()?.userid != nil
//            {
//              //  header[p_Authorization] = GetUserToken()
//            }
            
                AlamofireModel.alamofireMethod(methods: .post , url: URL, parameters: parameter as! [String : String], Header: header, handler: { (response) in
                    
                    if response["success"] as! Bool == true {
                        
                        handler(response as AnyObject)
                        
                    }else{
                        
                        if let message = response["message"] as? String
                        {
                            Utilities.showMessage(text: message)
                        }
                        else
                        {
                            Utilities.showMessage(text: SomethingWentWrong)
                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
                
           
        }else
        {
            Utilities.showMessage(text: ValidMsg.noInternetConnection.rawValue)
        }
    }
    
    //GETT
    class func GetDataFromServerGET(parameter : NSDictionary, URL : URLConvertible, showloader : Bool = true, handler:@escaping CompletionHandler)
    {
        let reachablecheck = Reachability()
        
        if (reachablecheck?.isReachable)!
        {
//            if kCurrentUser()?.userid != nil
//            {
//                header[p_Authorization] = GetUserToken()
//            }
            
            AlamofireModel.alamofireMethodGET(methods: .get, url: URL, showloader : showloader, parameters: parameter as! [String : String], Header: header, handler: { (response) in
                
                let dict = JSON(response)
                
                if dict["status"].boolValue == true {
                    
                    handler(response as AnyObject)
                    
                }else{

                    if let message = response["msg"] as? String
                    {
                        Utilities.showMessage(text: message)
                    }
                    else
                    {
                        Utilities.showMessage(text: SomethingWentWrong)
                    }
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
        }else
        {
            Utilities.showMessage(text: ValidMsg.noInternetConnection.rawValue)
        }
    }
    
    
    
    //LOCATION UPDATE CALL
    class func GetUpdateLocationtoServer(parameter : NSDictionary, URL : URLConvertible, handler:@escaping CompletionHandler)
    {
        let reachablecheck = Reachability()
        
        if (reachablecheck?.isReachable)!
        {
            AlamofireModel.alamofireMethodupdatelocation(methods: .post , url: URL, parameters: parameter as! [String : String], Header: header, handler: { (response) in
                
                
                if response["code"] as! Int == 200 {
                    handler(response as AnyObject)
                }else{
                    
                    print("Updating time error :: \(response["message"] as? String ?? SomethingWentWrong)")
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }else
        {
            Utilities.showMessage(text: ValidMsg.noInternetConnection.rawValue)
        }
        
    }
 }
