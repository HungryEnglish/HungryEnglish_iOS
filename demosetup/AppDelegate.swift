//
//  AppDelegate.swift
//  demosetup
//
//  Created by Peerbits on 06/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


var Availabilityarr = [[String : AnyObject]]()

var curr_lat = 0.0
var curr_long = 0.0

var homeaddress = ""

@UIApplicationMain
class AppDelegate: BaseValidationViewController, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //IQKeyboardmanager
        IQKeyboardManager.sharedManager().enable = true
        //IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        //Hide Status bar
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        GotocheckScreens()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // MARK: - NAVIGATE SCREENS -
    
    func GotocheckScreens()
    {
        if kCurrentUser()?.userid != nil
        {
            GotoHome()
        }else{
            GotoLogin()
        }
    }
    
    
    func GotoLogin()
    {
        let VC = Utilities.viewController(name: "NavAuthen", onStoryboard: Sbname.Authen.rawValue)
        window!.rootViewController = VC
    }
    
    func GotoHome()
    {
        if kCurrentUser()?.role == "admin"
        {
            
            let VC = Utilities.viewController(name: "NavAdminHome", onStoryboard: Sbname.Home.rawValue)
            window!.rootViewController = VC
            
        }else if kCurrentUser()?.role == "teacher"
        {
            if kCurrentUser()?.is_active == "0"
            {
                kCurrentUser()?.logout()
                Utilities.showMessage(text: "Admin will approve your request")
                
            }else if kCurrentUser()?.is_active == "1"
            {
              
                let VC = Utilities.viewController(name: "NavEditTeacher", onStoryboard: Sbname.Home.rawValue)
                window!.rootViewController = VC
                
            }else{
                
                let VC = Utilities.viewController(name: "NavHometeacher", onStoryboard: Sbname.Home.rawValue)
                window!.rootViewController = VC
                
            }
            
        }else{
            
            if kCurrentUser()?.is_active == "0"
            {
               
                let VC = Utilities.viewController(name: "NavEditStudent", onStoryboard: Sbname.Home.rawValue)
                window!.rootViewController = VC
                
            }else if kCurrentUser()?.is_active == "1"
            {
                let VC = Utilities.viewController(name: "NavHome", onStoryboard: Sbname.Home.rawValue)
                window!.rootViewController = VC
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

