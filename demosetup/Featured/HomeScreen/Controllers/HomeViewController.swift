//
//  HomeViewController.swift
//  demosetup
//
//  Created by Nikunj on 17/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, FilterDelegate {
    // MARK: - OUTLETS -
    
    @IBOutlet weak var tbllist: UITableView!
    
    @IBOutlet weak var btnFilter: UIButton!
    
    // MARK: - VARIABLES -
    
    var stroj = TeacherList()
    
    var Mainstrobj = TeacherList()
    
    var isFilter = false
   
    var searchstr = ""
    
    var searchdays = ""
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btnFilter.layer.cornerRadius =  btnFilter.frame.size.height / 2
        self.tbllist.isHidden = true
        
        callAPI()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - VOID METHODS -
    
    func FilterStringSearch(is_Filter : Bool, str_obj : TeacherList, sort_strobj : TeacherList, str_string : String, days : String)
    {
        isFilter = is_Filter
        searchstr = str_string
        searchdays = days
        
        dismiss(animated: true, completion: nil)
        
        if is_Filter
        {
            if sort_strobj.objTeachlist.count > 0
            {
                stroj = sort_strobj
                self.tbllist.isHidden = false
                self.tbllist.reloadData()
                
            }else{
                self.tbllist.isHidden = true
                Utilities.showMessage(text: ValidMsg.noteachermatchingdetailsfound.rawValue)
            }
        }else{
            if str_obj.objTeachlist.count > 0
            {
                stroj = str_obj
                self.tbllist.isHidden = false
                self.tbllist.reloadData()
            }else{
                self.tbllist.isHidden = true
                Utilities.showMessage(text: ValidMsg.noteacherdetailsfound.rawValue)
            }
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tbllist.scrollToRow(at: indexPath, at: .top, animated: true)
        
    }
    
    
    func callAPI()
    {
        let param : [String : String] =
            [
                p_role : "teacher",
                p_status : "2"
              //  p_optional_status : "2"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.adminstudentlist.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            
            self.stroj = TeacherList()
            self.Mainstrobj = TeacherList()
            
            self.stroj.update(data: dict)
            
            if self.stroj.objTeachlist.count > 0
            {
                self.Mainstrobj = self.stroj
                self.tbllist.isHidden = false
                
                self.tbllist.reloadData()
                
            }else{
                self.tbllist.isHidden = true
            }
            
        })
    }
    
    
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        appInstance.LogoutPopup()
    }
    
  
    @IBAction func btnContactUsClicked(_ sender: UIButton) {
        //MapViewViewController
//        let VC = Utilities.viewController(name: "ContactUsViewController", onStoryboard: Sbname.Home.rawValue) as! ContactUsViewController
//        self.navigationController?.pushViewController(VC, animated: true)
        Utilities.showMessage(text: "Coming Soon")
        
      
    }
    
    
    @IBAction func btnProfileClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "StudentEditViewController", onStoryboard: Sbname.Home.rawValue) as! StudentEditViewController
        VC.userid = (kCurrentUser()?.userid)!
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    @IBAction func btnFilterClicked(_ sender: UIButton) {
        
        let VC = Utilities.viewController(name: "FilterViewController", onStoryboard: Sbname.Home.rawValue) as! FilterViewController
        VC.modalPresentationStyle = .overFullScreen
       
        VC.stroj = self.Mainstrobj
        
        if isFilter
        {
            VC.sortstrobj = self.stroj
            VC.str_string = self.searchstr
            VC.days = self.searchdays
        }
        
        
        VC.delegate = self
        VC.modalTransitionStyle = .crossDissolve
        self.present(VC, animated: true, completion: nil)
        

    }
   
}


extension HomeViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stroj.objTeachlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentListTableViewCell
        
        if self.stroj.objTeachlist[indexPath.row].profileImage != ""
        {
            cell.imgprofile.kf.indicatorType = .activity
            cell.imgprofile.kf.setImage(with: URL(string : self.stroj.objTeachlist[indexPath.row].profileImage))
        }else{
            cell.imgprofile.image = #imageLiteral(resourceName: "ic_userplaceholder")
        }
        
        
        Utilities.BorderForCellView(view: cell.viewmain)
        
        cell.imgprofile.layer.cornerRadius =  cell.imgprofile.frame.size.height / 2
        cell.imgprofile.clipsToBounds = true
        
        cell.viewimg.layer.cornerRadius = cell.viewimg.frame.size.height / 2
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.viewButton.frame
        rectShape.position = cell.viewButton.center
        rectShape.path = UIBezierPath(roundedRect: cell.viewButton.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        //Here I'm masking the textView's layer with rectShape layer
        cell.viewButton.layer.mask = rectShape
        
        
        cell.lblname.text = stroj.objTeachlist[indexPath.row].fullName
       
        cell.lblnearestrailwaystation.text = ValidMsg.nearestrailwaystation.rawValue + stroj.objTeachlist[indexPath.row].nearest_station
        
        cell.lblskills.text = ValidMsg.specialskills.rawValue + stroj.objTeachlist[indexPath.row].skills
        
        cell.btnViewteacher.tag = indexPath.row
       
        cell.btnViewteacher.addTarget(self, action: #selector(HomeViewController.ViewTeacherClicked(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    func ViewTeacherClicked(sender : UIButton)
    {
        
        let VC = Utilities.viewController(name: "TeacherEditViewController", onStoryboard: Sbname.Home.rawValue) as! TeacherEditViewController
        VC.userid = stroj.objTeachlist[sender.tag].userid
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
}

