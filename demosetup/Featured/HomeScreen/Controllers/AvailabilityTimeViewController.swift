//
//  AvailabilityTimeViewController.swift
//  demosetup
//
//  Created by Nikunj on 20/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
//import MaterialControls
import SwiftyJSON



class AvailabilityTimeViewController: UIViewController, WWCalendarTimeSelectorProtocol
{

    // MARK: - OUTLETS -
    
    @IBOutlet weak var btnSun: UIButton!
    
    @IBOutlet weak var btnMon: UIButton!
    
    @IBOutlet weak var btnTue: UIButton!
    
    @IBOutlet weak var btnWed: UIButton!
    
    @IBOutlet weak var btnThus: UIButton!
    
    @IBOutlet weak var btnFri: UIButton!
    
    @IBOutlet weak var btnSat: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var lblAvailabilityStr: UILabel!
    
    
    // MARK: - VARIABLES -
    
    var hourrr = 00
    var minnn = 00
    
    var isFirst = false
    var strDay = ""
    var tag = 0
    
    var strAvail = ""
  
    var arravail = [[String : AnyObject]]()
    
    var temp_dictavailability = [String:AnyObject]()
    
    let selector = WWCalendarTimeSelector.instantiate()
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblAvailabilityStr.text = strAvail
        
        selector.delegate = self
       
        selector.optionTopPanelBackgroundColor = UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 33.0/255.0, alpha: 1)
    
        selector.optionSelectorPanelBackgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
        
        selector.optionBottomPanelBackgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
        selector.optionButtonFontColorDone = UIColor.white
        selector.optionButtonFontColorCancel = UIColor.white
        selector.optionClockBackgroundColorAMPMHighlight  = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
        selector.optionClockBackgroundColorHourHighlight = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
        selector.optionClockBackgroundColorMinuteHighlight = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
        
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        
        configbutton()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - VOID METHODS -
    
    func configbutton()
    {
        
        btnSun.layer.cornerRadius = btnSun.frame.size.height / 2
        btnSun.layer.borderWidth = 1.0
        btnSun.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnSun.clipsToBounds = true
        
        
        btnMon.layer.cornerRadius = btnMon.frame.size.height / 2
        btnMon.layer.borderWidth = 1.0
        btnMon.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnMon.clipsToBounds = true
        
        btnTue.layer.cornerRadius = btnTue.frame.size.height / 2
        btnTue.layer.borderWidth = 1.0
        btnTue.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnTue.clipsToBounds = true
        
        btnWed.layer.cornerRadius = btnWed.frame.size.height / 2
        btnWed.layer.borderWidth = 1.0
        btnWed.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnWed.clipsToBounds = true
        
        btnThus.layer.cornerRadius = btnThus.frame.size.height / 2
        btnThus.layer.borderWidth = 1.0
        btnThus.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnThus.clipsToBounds = true
        
        btnFri.layer.cornerRadius = btnFri.frame.size.height / 2
        btnFri.layer.borderWidth = 1.0
        btnFri.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnFri.clipsToBounds = true
        
        btnSat.layer.cornerRadius = btnSat.frame.size.height / 2
        btnSat.layer.borderWidth = 1.0
        btnSat.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnSat.clipsToBounds = true
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height / 2
       
        btnSun.tag = 0
        btnMon.tag = 1
        btnTue.tag = 2
        btnWed.tag = 3
        btnThus.tag = 4
        btnFri.tag = 5
        btnSat.tag = 6
        
        if strAvail.characters.count > 0
        {
            if strAvail.range(of: "Mon") != nil{
                
               btnMon.setTitleColor(UIColor.white, for: .normal)
                
               btnMon.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                  btnMon.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                 btnMon.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Tue") != nil{
                
                btnTue.setTitleColor(UIColor.white, for: .normal)
                
                btnTue.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                  btnTue.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnTue.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Wed") != nil{
                
                btnWed.setTitleColor(UIColor.white, for: .normal)
                
                btnWed.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                  btnWed.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                btnWed.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Thu") != nil{
                
                btnThus.setTitleColor(UIColor.white, for: .normal)
                
                
                btnThus.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                
                  btnThus.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                btnThus.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Fri") != nil{
                
                btnFri.setTitleColor(UIColor.white, for: .normal)
                
                
                btnFri.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                  btnFri.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnFri.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Sat") != nil{
                
                btnSat.setTitleColor(UIColor.white, for: .normal)
                
                
                btnSat.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                
                  btnSat.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                btnSat.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
            
            if strAvail.range(of: "Sun") != nil{
                
                btnSun.setTitleColor(UIColor.white, for: .normal)
                
                
                btnSun.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }else{
                
                  btnSun.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnSun.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
            }
        }
    }
    
    
    func timeSelect(tag : Int, str_dict: [String:String], is_last : Bool)
    {
        
//        let timepicker = MDTimePickerDialog()
//
//        timepicker.delegate = self
//        timepicker.theme = .light
        
 
        if !is_last
        {
           temp_dictavailability["dayString"] = str_dict["dayString"] as AnyObject
            temp_dictavailability["startTime"] = str_dict["startTime"] as AnyObject
            
            //timepicker.show()
            dismiss(animated: true, completion: nil)
            
            let selector2 = WWCalendarTimeSelector.instantiate()
            
            selector2.optionTopPanelTitle = "Select End Time"
            selector2.delegate = self
            selector2.optionTopPanelBackgroundColor = UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 33.0/255.0, alpha: 1)
            
            selector2.optionSelectorPanelBackgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            
           selector2.optionBottomPanelBackgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            selector2.optionButtonFontColorDone = UIColor.white
            selector2.optionButtonFontColorCancel = UIColor.white
            selector2.optionClockBackgroundColorAMPMHighlight  = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            selector2.optionClockBackgroundColorHourHighlight = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            selector2.optionClockBackgroundColorMinuteHighlight = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            
            
            selector2.optionStyles.showDateMonth(false)
            selector2.optionStyles.showMonth(false)
            selector2.optionStyles.showYear(false)
            selector2.optionStyles.showTime(true)
            
            present(selector2, animated: true, completion: nil)
            
        }else{
            
            temp_dictavailability["endTime"] = str_dict["endTime"] as AnyObject
            temp_dictavailability["priority"] = tag as AnyObject
            
            switch tag
            {
            case 0 :
                
                btnSun.setTitleColor(UIColor.white, for: .normal)
                
                btnSun.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 1 :
                
                btnMon.setTitleColor(UIColor.white, for: .normal)
                
                 btnMon.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 2 :
                
                btnTue.setTitleColor(UIColor.white, for: .normal)
                
                 btnTue.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 3 :
                
                btnWed.setTitleColor(UIColor.white, for: .normal)
                
                 btnWed.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 4 :
                
                btnThus.setTitleColor(UIColor.white, for: .normal)
                
                 btnThus.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 5 :
                
                btnFri.setTitleColor(UIColor.white, for: .normal)
                
                 btnFri.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            case 6 :
                
                btnSat.setTitleColor(UIColor.white, for: .normal)
                
                 btnSat.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            default :
                print("Nothing")
            }
            
            strAvail = strAvail + "\(temp_dictavailability["dayString"] ?? "" as AnyObject):\(temp_dictavailability["startTime"] ?? "" as AnyObject)-\(temp_dictavailability["endTime"] ?? "" as AnyObject)" + ","
            lblAvailabilityStr.text = strAvail
            arravail.append(temp_dictavailability)
            temp_dictavailability = [String : AnyObject]()
        }
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date24 = formatter.string(from: date)
        
        print(date24)
        print("yes")
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hour = comp.hour
        let min = comp.minute
        
        if isFirst
        {
            
            isFirst = false
            temp_dictavailability = [String:AnyObject]()
            hourrr = hour!
            minnn = min!
            timeSelect(tag : tag, str_dict: ["dayString" : strDay, "startTime" : "\(String(format: "%02d", hour!)):\(String(format: "%02d", min!))"], is_last : false)
            
        }else{
            
            var boolkey = true
            if hourrr > hour!
            {
                boolkey = false
                
            }else if hourrr == hour
            {
                if minnn >= min!
                {
                    boolkey = false
                }
            }
            if boolkey
            {
                hourrr = 00
                minnn = 00
                timeSelect(tag : tag, str_dict : ["endTime" : "\(String(format: "%02d", hour!)):\(String(format: "%02d", min!))"], is_last : true)
            }else{
                Utilities.showMessage(text: "Start time must be before end time./开始时间必须在结束时间之前。")
            }
        }
        
        
    }
    
    func WWCalendarTimeSelectorCancel(_ selector: WWCalendarTimeSelector, date: Date) {
        print("cancel")
        isFirst = false
        strDay = ""
        tag = 0
        temp_dictavailability = [String : AnyObject]()
    }

    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        if !((lblAvailabilityStr.text?.isEmpty)!)
        {
            Availabilityarr = arravail
            
            _ = self.navigationController?.popViewController(animated : true)
            
        }
    }
    
    
   
    
    
    
    @IBAction func btnDayClicked(_ sender: UIButton) {

     //   let selector = WWCalendarTimeSelector.instantiate()
        
       // selector.delegate = self
        selector.optionTopPanelTitle = "Select Start Time"
//        selector.optionTopPanelBackgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
//        selector.optionStyles.showDateMonth(false)
//        selector.optionStyles.showMonth(false)
//        selector.optionStyles.showYear(false)
//        selector.optionStyles.showTime(true)
        
        
        switch sender.tag
        {
            case 0 :
            
                if strAvail.range(of: "Sun") != nil
                {
                    
                     lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                    btnSun.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    btnSun.backgroundColor = UIColor.white //UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                   
                }else{
                    
                    isFirst = true
                    strDay = "Sun"
                    tag = sender.tag
                   // timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
                }
            
            case 1 :
                if strAvail.range(of: "Mon") != nil{
                    
                    lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                      btnMon.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    btnMon.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Mon"
                    tag = sender.tag
                   // timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
                }
            case 2 :
            
                if strAvail.range(of: "Tue") != nil{
                    
                    lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                      btnTue.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    btnTue.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Tue"
                    tag = sender.tag
                   // timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
            }
            case 3 :
                if strAvail.range(of: "Wed") != nil{
                    
                   lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                      btnWed.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    
                    btnWed.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Wed"
                    tag = sender.tag
                  //  timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
            }
            case 4 :
                if strAvail.range(of: "Thu") != nil{
                    
                     lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                      btnThus.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    
                    btnThus.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Thu"
                    tag = sender.tag
                  //  timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
            }
            case 5 :
                if strAvail.range(of: "Fri") != nil{
                    
                  lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                    
                      btnFri.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    
                    btnFri.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Fri"
                    tag = sender.tag
                  //  timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
            }
            case 6 :
                if strAvail.range(of: "Sat") != nil{
                    
                   lblAvailabilityStr.text = removefromarray(temp: sender.tag)
                   
                    
                      btnSat.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                    
                    btnSat.backgroundColor = UIColor.white//UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                    
                }else{
                    
                    isFirst = true
                    strDay = "Sat"
                    tag = sender.tag
                   // timepicker.show()
                    present(selector, animated: true, completion: nil)
                    
            }
            default :
                
            print("Nothing")
        }
        
    }
    
    
    func removefromarray(temp : Int) -> String
    {
        let arr_dict = JSON(arravail)
        arravail = [[String:AnyObject]]()
        strAvail = ""
        
        for (_, value) in arr_dict
        {
            if value["priority"].int != temp
            {
                arravail.append(["dayString" : value["dayString"].string! as AnyObject, "endTime" : value["endTime"].string! as AnyObject, "startTime" : value["startTime"].string! as AnyObject, "priority" : value["priority"].int as AnyObject])
                
                strAvail = strAvail + "\(value["dayString"].string!):\(value["startTime"].string!)-\(value["endTime"].string!)" + ","
                
            }
            
        }
        return strAvail
    }
    
    
}

//extension AvailabilityTimeViewController : MDTimePickerDialogDelegate
//{
//    func timePickerDialog(_ timePickerDialog: MDTimePickerDialog, didSelectHour hour: Int, andMinute minute: Int) {
//
//        var min = minute
//
//        if min == 60 {
//            min = 00
//        }
//
//        print("yes")
//        if isFirst
//        {
//
//            isFirst = false
//            temp_dictavailability = [String:AnyObject]()
//            hourrr = hour
//            minnn = min
//            timeSelect(tag : tag, str_dict: ["dayString" : strDay, "startTime" : "\(String(format: "%02d", hour)):\(String(format: "%02d", min))"], is_last : false)
//
//        }else{
//
//            var boolkey = true
//            if hourrr > hour
//            {
//                boolkey = false
//
//            }else if hourrr == hour
//            {
//                if minnn >= minute
//                {
//                    boolkey = false
//                }
//            }
//            if boolkey
//            {
//                hourrr = 00
//                minnn = 00
//                timeSelect(tag : tag, str_dict : ["endTime" : "\(String(format: "%02d", hour)):\(String(format: "%02d", min))"], is_last : true)
//            }else{
//                Utilities.showMessage(text: "Start time cannot be  greater than end time.")
//            }
//        }
//
//    }
//
//    func timePickerDialogdidCancel(_ timePickerDialog: MDTimePickerDialog)
//    {
//        print("cancel")
//
//        isFirst = false
//        strDay = ""
//        tag = 0
//        temp_dictavailability = [String : AnyObject]()
//    }
//
//
//
//}

