//
//  HomeAdminViewController.swift
//  demosetup
//
//  Created by Nikunj on 17/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeAdminViewController: UIViewController {
    // MARK: - OUTLETS -
    
    @IBOutlet weak var viewstudentlist: UIView!
    
    @IBOutlet weak var viewteacherlist: UIView!
    
    @IBOutlet weak var viewAddLinks: UIView!
    
    
    @IBOutlet weak var viewReport: UIView!
    
    @IBOutlet weak var lblstudentlistcount: UILabel!
    
    @IBOutlet weak var lblteacherlist: UILabel!
    
    @IBOutlet weak var viewstudentcount: UIView!
    
    
    @IBOutlet weak var viewteachercount: UIView!
    
    
    // MARK: - VARIABLES -
    
    var msg = ""
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewstudentlist.layer.cornerRadius = viewstudentlist.frame.size.height / 2
        viewteacherlist.layer.cornerRadius = viewteacherlist.frame.size.height / 2
        viewReport.layer.cornerRadius = viewReport.frame.size.height / 2
        viewAddLinks.layer.cornerRadius = viewAddLinks.frame.size.height / 2

       self.lblteacherlist.isHidden = true
       self.lblstudentlistcount.isHidden = true
        viewstudentcount.isHidden = true
        viewteachercount.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.admincount.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
          
            if let str = dict["teacher_count"].string
            {
                 self.lblteacherlist.isHidden = false
                 self.viewteachercount.isHidden = false
                 self.lblteacherlist.text = str
            }
            if let str = dict["student_count"].string
            {
                self.lblstudentlistcount.isHidden = false
                self.viewstudentcount.isHidden = false
                self.lblstudentlistcount.text = str
            }
            
            self.updatecountslbl()
            
        })
    }
  
    
    func updatecountslbl()
    {
        lblstudentlistcount.layer.cornerRadius = lblstudentlistcount.frame.size.height / 2
       
        lblstudentlistcount.clipsToBounds = true
        
        
        viewstudentcount.layer.cornerRadius = viewstudentcount.frame.size.height / 2
        viewstudentcount.layer.borderColor = UIColor.white.cgColor
        viewstudentcount.layer.borderWidth = 2.0
        viewstudentcount.clipsToBounds = true
        
        lblteacherlist.layer.cornerRadius = lblteacherlist.frame.size.height / 2
        lblteacherlist.clipsToBounds = true
        
        viewteachercount.layer.cornerRadius = viewteachercount.frame.size.height / 2
        viewteachercount.layer.borderColor = UIColor.white.cgColor
        viewteachercount.layer.borderWidth = 2.0
        viewteachercount.clipsToBounds = true
    }
 
    
    // MARK: - CLICKED EVENTS -
    
    
    
    @IBAction func btnViewMapClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "MapRolewiseViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
    @IBAction func btnRateClicked(_ sender: UIButton) {
        
        
        let VC = Utilities.viewController(name: "RatingListViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
        
        
    }
    
    
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        
        appInstance.LogoutPopup()
        
    }

    @IBAction func btnStudentlistClicked(_ sender: UIButton) {
      
        let VC = Utilities.viewController(name: "StudentListViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
   
    @IBAction func btnTeacherListClicked(_ sender: UIButton) {
        
       let VC = Utilities.viewController(name: "TeacherListViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnReportClicked(_ sender: UIButton) {
        
       let VC = Utilities.viewController(name: "ReportGenerateViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnAddImageLinkClicked(_ sender: UIButton) {
       
        let VC = Utilities.viewController(name: "AddImageLinkViewController", onStoryboard: Sbname.Home.rawValue)
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
