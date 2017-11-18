//
//  StudentListViewController.swift
//  demosetup
//
//  Created by Nikunj on 17/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentListViewController: UIViewController {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var tblstudentlist: UITableView!
    
    // MARK: - VARIABLES -
    
    var stroj = StudentList()
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblstudentlist.estimatedRowHeight = 120.0
        tblstudentlist.rowHeight = UITableViewAutomaticDimension
        
        
         self.tblstudentlist.isHidden = true
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
                p_role : "student",
                p_status : "1",
                p_optional_status : "0"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.adminstudentlist.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            self.stroj = StudentList()
            
            self.stroj.update(data: dict)
            
            if self.stroj.objStudlist.count > 0
            {
                self.tblstudentlist.isHidden = false

                self.tblstudentlist.reloadData()
                
            }else{
                self.tblstudentlist.isHidden = true
                Utilities.showMessage(text: ValidMsg.nostudentfound.rawValue)
            }
            
        })
    }
    
    func callDeleteAPI(sender : UIButton)
    {
        let param : [String : String] =
            [
                p_id : stroj.objStudlist[sender.tag].userid,
                p_role : "student"
        ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.deleteuser.rawValue, handler: { response in
            
            print(JSON(response))
            
            let dict = JSON(response)
            
            print(dict)
            
            self.stroj.objStudlist.remove(at: sender.tag)
            
            if self.stroj.objStudlist.count > 0
            {
                self.tblstudentlist.isHidden = false
                
                self.tblstudentlist.reloadData()
                
            }else{
                self.tblstudentlist.isHidden = true
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
   
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    

}


// MARK: - EXTENSION -

extension StudentListViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stroj.objStudlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentListTableViewCell
        
        Utilities.BorderForCellView(view: cell.viewmain)
        
        cell.imgprofile.layer.cornerRadius =  cell.imgprofile.frame.size.height / 2
        cell.imgprofile.clipsToBounds = true
        
        cell.viewimg.layer.cornerRadius = cell.viewimg.frame.size.height / 2
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.viewButton.frame
        rectShape.position = cell.viewButton.center
        rectShape.path = UIBezierPath(roundedRect: cell.viewButton.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        //cell.viewButton.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        cell.viewButton.layer.mask = rectShape
        
        
        cell.lblname.text = stroj.objStudlist[indexPath.row].fullName
        cell.lblemail.text = ValidMsg.email_lbl.rawValue + stroj.objStudlist[indexPath.row].email
        cell.lblmobileno.text = ValidMsg.mobile_lbl.rawValue + stroj.objStudlist[indexPath.row].mob_no
        
        
        if stroj.objStudlist[indexPath.row].available_time != ""
        {
            let strdata : Data = stroj.objStudlist[indexPath.row].available_time.data(using: .utf8)!
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
        
        cell.btnEdit.addTarget(self, action: #selector(StudentListViewController.EditClicked(sender:)), for: .touchUpInside)
       
        cell.btnDelete.addTarget(self, action: #selector(StudentListViewController.DeleteClicked(sender:)), for: .touchUpInside)
 
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    func EditClicked(sender : UIButton)
    {
        let VC = Utilities.viewController(name: "StudentEditViewController", onStoryboard: Sbname.Home.rawValue) as! StudentEditViewController
        VC.userid = stroj.objStudlist[sender.tag].userid
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func DeleteClicked(sender : UIButton)
    {
        showDeletePopup(sender : sender)
    }
    
    
}
