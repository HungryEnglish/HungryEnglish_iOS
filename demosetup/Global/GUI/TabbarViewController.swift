//
//  TabbarViewController.swift
//  Gifmos
//
//  Created by macmini3 on 28/03/16.
//  Copyright © 2016 peerbits. All rights reserved.
//

import UIKit


let hidden : Bool = false

class TabbarViewController: UITabBarController
{

    @IBOutlet var TabarRms: UITabBar!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(red: 39.0/255.0, green: 43.0/255.0, blue: 51.0/255.0, alpha: 1)
        //self.tabBar.tintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.1)
        self.tabBar.shadowImage = UIImage()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 255.0/255.0, green: 102.0/255.0, blue: 52.0/255.0, alpha: 1)], for: .selected)
        self.tabBar.backgroundImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TabbarViewController.hideTabbar), name: NSNotification.Name(rawValue: "hidetabbar"), object: nil)
        
        self.tabBar.tintColor = UIColor(red: 148.0/255.0, green: 158.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
       /* for ttbar in self.Tabardujour.items! {
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad)
            {
                (ttbar as UITabBarItem).imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: -1, right: 0)
                //ttbar.setTitleTextAttributes([NSFontAttributeName : UIFont(name: "NotoSans", size: 9.0)!], for: UIControlState())
            }
            else
            {
                
                (ttbar as UITabBarItem).imageInsets = UIEdgeInsets(top: 3, left: -1, bottom: -3, right: 1)
            }
        } */
 
        // Do any additional setup after loading the view.
    }
    
    
    func hideTabbar()
    {
    
        if hidden != false {
        
            self.tabBar.isHidden = true
        }
        else{
        
            self.tabBar.isHidden = false
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        for item in self.tabBar.items! {
            (item ).image! = (item ).image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            (item ).selectedImage! = (item ).selectedImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
