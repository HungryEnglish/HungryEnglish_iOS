//
//  ReportGenerateViewController.swift
//  demosetup
//
//  Created by Nikunj on 05/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ReportGenerateViewController: UIViewController {

    // MARK: - VARIABLES -
    
    var objlist = ReportList()
    
    var dict = [Int : [String]]()
    
    
    // MARK: - OUTLETS -
    
    
    @IBOutlet weak var tbllist: UITableView!
    
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
                "" : "",
            ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.reportgenerate.rawValue, handler: { response in
            
            let dict = JSON(response)
            print(dict)
            
            self.objlist.update(data : dict)
            
            if self.objlist.objreport.count > 0
            {
                self.tbllist.reloadData()
            }else{
                self.tbllist.isHidden = true
            }
            
        })
    }
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController( animated: true)
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        var arrTeacher = [String]()
        var arrStudent = [String]()
        
        if self.objlist.objreport.count > 0
        {
        
            for i in 0..<self.objlist.objreport.count
            {
                arrTeacher.append("Teacher Email,\(self.objlist.objreport[i].teacherEmail)")
                arrTeacher.append("Teacher Full Name,\(self.objlist.objreport[i].teacherFullName)")
                arrTeacher.append("Teacher WeChat,\(self.objlist.objreport[i].teacherWeChat)")
                arrTeacher.append("Teacher Address,\(self.objlist.objreport[i].tAddress)")
                arrTeacher.append("Teacher Time,\(self.objlist.objreport[i].tTime)")
                arrTeacher.append("Teacher Skills,\(self.objlist.objreport[i].tSkills)")
            
                arrStudent.append("Student Email,\(self.objlist.objreport[i].stuEmail)")
                arrStudent.append("Student Full Name,\(self.objlist.objreport[i].stuFullName)")
                 arrStudent.append("Student WeChat,\(self.objlist.objreport[i].stuWeChat)")
                arrStudent.append("Student Sex,\(self.objlist.objreport[i].stuSex)")
                arrStudent.append("Student Age,\(self.objlist.objreport[i].stuAge)")
                arrStudent.append("Student Station,\(self.objlist.objreport[i].stuStation)")
                arrStudent.append("Student Skills,\(self.objlist.objreport[i].stuSkills)")
                arrStudent.append("Student Time,\(self.objlist.objreport[i].stuTime)")
            }
        
            dict = [0 : arrTeacher, 1 : arrStudent]
            
            let file_name = "SampleReport"
            
            let headerArr = ["Teacher,Details","Student,Details"]
            let anotherCSV = MakeCSV(headerTitle: headerArr, subHeaderTitle: [""], data: dict, fileName: file_name)
            let anotherMSG = anotherCSV.showSataus()
            print(anotherMSG)
            
            print(URL(string : anotherMSG)!)
            
            let DocPicker = UIDocumentPickerViewController(url: URL(string : anotherMSG)!, in: .exportToService)
            
            DocPicker.delegate = self
                
            self.present(DocPicker, animated: true, completion: nil)
        }else{
            Utilities.showMessage(text: ValidMsg.noteacherstudentavailable.rawValue)
        }
    }
    
   

}

// MARK: - EXTENSION -

extension ReportGenerateViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.objlist.objreport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReportTableViewCell
        
        
        cell.selectionStyle = .none
        
        Utilities.BorderForCellView(view: cell.viewMain)
        
        cell.lblteacher.text = self.objlist.objreport[indexPath.row].stuFullName  + " " + ValidMsg.testrequestto.rawValue + self.objlist.objreport[indexPath.row].teacherEmail
        
        return cell
        
    }
    
    
    
}

extension ReportGenerateViewController : UIDocumentPickerDelegate
{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if controller.documentPickerMode == .import
        {
            
        }else if controller.documentPickerMode == .exportToService
        {
            Utilities.showMessage(text: ValidMsg.reportdownloaded.rawValue)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancel")
    }
    
}


