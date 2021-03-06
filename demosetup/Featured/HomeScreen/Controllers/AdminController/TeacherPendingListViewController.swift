//
//  TeacherPendingListViewController.swift
//  demosetup
//
//  Created by Nikunj on 18/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class TeacherPendingListViewController: UIViewController {

    // MARK: - OUTLETS -
    
    
    @IBOutlet weak var tblteacherlist: UITableView!
    
   
    
    // MARK: - VARIABLES -
    
    var stroj = TeacherList()
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // callAPI()
        self.tblteacherlist.isHidden = true
        
        tblteacherlist.estimatedRowHeight = 120.0
        tblteacherlist.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        callAPI()
        
    }

    // MARK: - VOID METHODS -
    
    func callAPI()
    {
        let param : [String : String] =
            [
                p_role : "teacher",
                p_status : "0"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.adminstudentlist.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            self.stroj = TeacherList()
            
            self.stroj.update(data: dict)
            
            if self.stroj.objTeachlist.count > 0
            {
                self.tblteacherlist.isHidden = false
                
                self.tblteacherlist.reloadData()
                
            }else{
                self.tblteacherlist.isHidden = true
                Utilities.showMessage(text: ValidMsg.noteacherdetailsfound.rawValue)
            }
            
        })
    }
    
    func callDeleteAPI(sender : UIButton)
    {
        let param : [String : String] =
            [
                p_id : stroj.objTeachlist[sender.tag].userid,
                p_role : "teacher"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.deleteuser.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            
            self.stroj.objTeachlist.remove(at: sender.tag)
            
            if self.stroj.objTeachlist.count > 0
            {
                self.tblteacherlist.isHidden = false
                
                self.tblteacherlist.reloadData()
                
            }else{
                self.tblteacherlist.isHidden = true
            }
            
        })
    }
    
    func callAcceptAPI(sender : UIButton)
    {
        let param : [String : String] =
            [
                p_id : stroj.objTeachlist[sender.tag].userid,
                p_status : "1"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.adminaccept.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            
            self.stroj.objTeachlist.remove(at: sender.tag)
            
            if self.stroj.objTeachlist.count > 0
            {
                self.tblteacherlist.isHidden = false
                
                self.tblteacherlist.reloadData()
                
            }else{
                self.tblteacherlist.isHidden = true
            }
            
        })
    }
    
    
    func showDeletePopup(sender : UIButton)
    {
        let alertpopup = UIAlertController(title: ValidMsg.alert.rawValue, message: ValidMsg.deletepopup.rawValue, preferredStyle: .alert)
        
        alertpopup.addAction(UIAlertAction(title: ValidMsg.no.rawValue, style: .cancel, handler: { action in
            
            switch action.style{
            case .cancel:
                print("cancel")
                
            case .default:
                print("default")
            case .destructive:
                print("destructive")
            }
            
        }))
        
        alertpopup.addAction(UIAlertAction(title: ValidMsg.yes.rawValue, style: .default, handler: { action in
            
            switch action.style
            {
            case .default :
                print("Yes")
                
                self.callDeleteAPI(sender: sender)
                
            case .cancel :
                print("cancel")
            case .destructive:
                print("destructive")
                
            }
        }))
        
        self.present(alertpopup, animated: true, completion: nil)
    }
    
    func showAcceptPopup(sender : UIButton)
    {
        let alertpopup = UIAlertController(title: ValidMsg.alert.rawValue, message: ValidMsg.acceptpopup.rawValue, preferredStyle: .alert)
        
        alertpopup.addAction(UIAlertAction(title: ValidMsg.no.rawValue, style: .cancel, handler: { action in
            
            switch action.style{
            case .cancel:
                print("cancel")
                
            case .default:
                print("default")
            case .destructive:
                print("destructive")
            }
            
        }))
        
        alertpopup.addAction(UIAlertAction(title: ValidMsg.yes.rawValue, style: .default, handler: { action in
            
            switch action.style
            {
            case .default :
                print("Yes")
                
                self.callAcceptAPI(sender: sender)
                
            case .cancel :
                print("cancel")
            case .destructive:
                print("destructive")
                
            }
        }))
        
        self.present(alertpopup, animated: true, completion: nil)
    }
    
    
    
    // MARK: - CLICKED EVENTS -
    

}

// MARK: - EXTENSION -

extension TeacherPendingListViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stroj.objTeachlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPending", for: indexPath) as! StudentListTableViewCell
        
        Utilities.BorderForCellView(view: cell.viewmain)
        
        if self.stroj.objTeachlist[indexPath.row].profileImage != ""
        {
            cell.imgprofile.kf.indicatorType = .activity
            cell.imgprofile.kf.setImage(with: URL(string : self.stroj.objTeachlist[indexPath.row].profileImage))
        }else{
            cell.imgprofile.image = #imageLiteral(resourceName: "ic_userplaceholder")
        }
       
        cell.imgprofile.layer.cornerRadius =  cell.imgprofile.frame.size.height / 2
        cell.imgprofile.clipsToBounds = true
        
        
        
        cell.viewimg.layer.cornerRadius = cell.viewimg.frame.size.height / 2
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.viewButton.frame
        rectShape.position = cell.viewButton.center
        rectShape.path = UIBezierPath(roundedRect: cell.viewButton.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
       cell.viewButton.layer.mask = rectShape
        
        
        cell.lblname.text = stroj.objTeachlist[indexPath.row].fullName
        cell.lblemail.text = ValidMsg.email_lbl.rawValue + stroj.objTeachlist[indexPath.row].email
        cell.lblmobileno.text = ValidMsg.mobile_lbl.rawValue + stroj.objTeachlist[indexPath.row].mob_no
        
        if stroj.objTeachlist[indexPath.row].available_time != ""
        {
            let strdata : Data = stroj.objTeachlist[indexPath.row].available_time.data(using: .utf8)!
            let dict_arravail = JSON(strdata)
            
            var teststr = ""
            for (_, value) in dict_arravail
            {
                
                print(value)
                teststr = teststr + "\(value["dayString"].string!):\(value["startTime"].string!)-\(value["endTime"].string!)" + ","
            }
            
            cell.lblavailability.text =  ValidMsg.availability_lbl.rawValue + teststr
        }else{
            cell.lblavailability.text = ValidMsg.availability_lbl.rawValue
        }
        
        
        
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnAccept.tag = indexPath.row
        
        cell.btnEdit.addTarget(self, action: #selector(TeacherPendingListViewController.EditClicked(sender:)), for: .touchUpInside)
        
        cell.btnDelete.addTarget(self, action: #selector(TeacherPendingListViewController.DeleteClicked(sender:)), for: .touchUpInside)
        
         cell.btnAccept.addTarget(self, action: #selector(TeacherPendingListViewController.AcceptClicked(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func EditClicked(sender : UIButton)
    {
        
        let VC = Utilities.viewController(name: "TeacherEditViewController", onStoryboard: Sbname.Home.rawValue) as! TeacherEditViewController
        VC.userid = stroj.objTeachlist[sender.tag].userid
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    func DeleteClicked(sender : UIButton)
    {
        showDeletePopup(sender : sender)
    }
    
    func AcceptClicked(sender : UIButton)
    {
        showAcceptPopup(sender : sender)
    }
    
}

