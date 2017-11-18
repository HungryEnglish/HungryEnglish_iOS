//
//  FilterViewController.swift
//  demosetup
//
//  Created by A on 10/19/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func FilterStringSearch(is_Filter : Bool,str_obj : TeacherList,  sort_strobj : TeacherList , str_string : String, days : String)
}


class FilterViewController: UIViewController {

    
    // MARK: - OUTLETS -
    
    @IBOutlet weak var txtSkill: FloatLabelTextField!
    
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnSun: UIButton!
    
    @IBOutlet weak var btnMon: UIButton!
    
    @IBOutlet weak var btnTue: UIButton!
    
    @IBOutlet weak var btnWed: UIButton!
    
    @IBOutlet weak var btnThus: UIButton!
    
    @IBOutlet weak var btnFri: UIButton!
    
    @IBOutlet weak var btnSat: UIButton!
    
    
    // MARK: - VARIABLES -
    
    var stroj = TeacherList()
    var sortstrobj = TeacherList()
    
    var days = ""
    
    var delegate : FilterDelegate!
    
    var str_string = ""
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configbutton()
        
        if str_string.characters.count > 0
        {
            txtSkill.text = str_string
        }
            if days.characters.count > 0
            {
               
                    if days.range(of: "Sun") != nil{
                        
                        btnSun.setTitleColor(UIColor.white, for: .normal)
                        
                        btnSun.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
                    if days.range(of: "Mon") != nil{
                        
                        btnMon.setTitleColor(UIColor.white, for: .normal)
                        
                        
                        btnMon.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
                    if days.range(of: "Tue") != nil{
                        
                        btnTue.setTitleColor(UIColor.white, for: .normal)
                        
                        btnTue.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
                   if days.range(of: "Wed") != nil{
                  
                        btnWed.setTitleColor(UIColor.white, for: .normal)
                    
                         btnWed.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
               
                    if days.range(of: "Thu") != nil{
                        
                        btnThus.setTitleColor(UIColor.white, for: .normal)
                        
                        btnThus.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
               
                    if days.range(of: "Fri") != nil{
                        
                        btnFri.setTitleColor(UIColor.white, for: .normal)
                        
                        btnFri.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
            
                    if days.range(of: "Sat") != nil{
                        
                        btnSat.setTitleColor(UIColor.white, for: .normal)
                        
                        
                        btnSat.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                    }
            // }
            
        }
        
        self.modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - VOID METHODS -
 
    func configbutton()
    {
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height / 2
        btnClear.layer.cornerRadius = btnClear.frame.size.height / 2
        
        btnSun.layer.cornerRadius = btnSun.frame.size.height / 2
        btnSun.layer.borderWidth = 1.0
        btnSun.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnSun.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnSun.backgroundColor = UIColor.white
        
        btnSun.clipsToBounds = true
        
        
        btnMon.layer.cornerRadius = btnMon.frame.size.height / 2
        btnMon.layer.borderWidth = 1.0
        btnMon.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        
        btnMon.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnMon.backgroundColor = UIColor.white
        
        btnMon.clipsToBounds = true
        
        btnTue.layer.cornerRadius = btnTue.frame.size.height / 2
        btnTue.layer.borderWidth = 1.0
        btnTue.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        
        btnTue.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnTue.backgroundColor = UIColor.white
        btnTue.clipsToBounds = true
        
        btnWed.layer.cornerRadius = btnWed.frame.size.height / 2
        btnWed.layer.borderWidth = 1.0
        btnWed.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        
        btnWed.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnWed.backgroundColor = UIColor.white
        btnWed.clipsToBounds = true
        
        btnThus.layer.cornerRadius = btnThus.frame.size.height / 2
        btnThus.layer.borderWidth = 1.0
        btnThus.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        btnThus.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnThus.backgroundColor = UIColor.white
        
        
        btnThus.clipsToBounds = true
        
        btnFri.layer.cornerRadius = btnFri.frame.size.height / 2
        btnFri.layer.borderWidth = 1.0
        btnFri.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        
        btnFri.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnFri.backgroundColor = UIColor.white
        btnFri.clipsToBounds = true
        
        btnSat.layer.cornerRadius = btnSat.frame.size.height / 2
        btnSat.layer.borderWidth = 1.0
        btnSat.layer.borderColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        
        btnSat.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
        
        btnSat.backgroundColor = UIColor.white
        btnSat.clipsToBounds = true
        
        btnSun.tag = 0
        btnMon.tag = 1
        btnTue.tag = 2
        btnWed.tag = 3
        btnThus.tag = 4
        btnFri.tag = 5
        btnSat.tag = 6
        
        
    }
    
    
    // MARK: - CLICKED EVENTS -
    
    
    @IBAction func btnDayClicked(_ sender: UIButton) {
    
    
        switch sender.tag
        {
        case 0 :
            
            if days.range(of: "Sun") != nil{
                
                days = days.replacingOccurrences(of: "Sun", with: "")
                
                btnSun.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnSun.backgroundColor = UIColor.white
                
                
               // btnSun.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Sun"
                btnSun.setTitleColor(UIColor.white, for: .normal)
                
                
               btnSun.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
            
        case 1 :
            if days.range(of: "Mon") != nil{
                
                days = days.replacingOccurrences(of: "Mon", with: "")
                
                btnMon.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnMon.backgroundColor = UIColor.white
                
                //  btnMon.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Mon"
                
                btnMon.setTitleColor(UIColor.white, for: .normal)
                
                
               btnMon.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
            }
        case 2 :
            
            if days.range(of: "Tue") != nil{
                
                days = days.replacingOccurrences(of: "Tue", with: "")
                
                btnTue.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnTue.backgroundColor = UIColor.white
                
                
                // btnTue.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Tue"
                
                btnTue.setTitleColor(UIColor.white, for: .normal)
                
              btnTue.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
        case 3 :
            if days.range(of: "Wed") != nil{
                
                days = days.replacingOccurrences(of: "Wed", with: "")
                
                btnWed.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnWed.backgroundColor = UIColor.white
                
                // btnWed.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Wed"
                
                btnWed.setTitleColor(UIColor.white, for: .normal)
                
                
               btnWed.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
        case 4 :
            if days.range(of: "Thu") != nil{
                
                days = days.replacingOccurrences(of: "Thu", with: "")
                btnThus.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnThus.backgroundColor = UIColor.white
                
               // btnThus.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Thu"
                
                btnThus.setTitleColor(UIColor.white, for: .normal)
                
                btnThus.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
        case 5 :
            if days.range(of: "Fri") != nil{
                
                days = days.replacingOccurrences(of: "Fri", with: "")
                btnFri.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnFri.backgroundColor = UIColor.white
           //   btnFri.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Fri"
                
                btnFri.setTitleColor(UIColor.white, for: .normal)
                
                
              btnFri.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
        case 6 :
            if days.range(of: "Sat") != nil{
                
                days = days.replacingOccurrences(of: "Sat", with: "")
                
                btnSat.setTitleColor(UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1), for: .normal)
                
                btnSat.backgroundColor = UIColor.white
              // btnSat.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1)
                
            }else{
                
                days = days + " Sat"
              
                btnSat.setTitleColor(UIColor.white, for: .normal)
                
                
              btnSat.backgroundColor = UIColor(red: 1.0/255.0, green: 190.0/255.0, blue: 50.0/255.0, alpha: 1)
                
            }
        default :
            
            print("Nothing")
        }
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        sortstrobj = TeacherList()
           
        if stroj.objTeachlist.count > 0
        {
            for i in 0..<stroj.objTeachlist.count
            {
                
                let searchtext = txtSkill.text
                if !((txtSkill.text?.isEmpty)!)
                {
                    if stroj.objTeachlist[i].skills.lowercased().range(of: (searchtext?.lowercased())!) != nil
                    {
                        if days.trim() != "" && days.characters.count > 0
                        {
                                    print(days)
                                    print(stroj.objTeachlist[i].available_time)

                                    let strarray = days.components(separatedBy: " ")
                                    var isexist = false
                                    for j in 0..<strarray.count
                                    {
                                        if stroj.objTeachlist[i].available_time.range(of: strarray[j]) != nil
                                        {
                                            isexist = true
                                        }
                                    }
                                    if  isexist {
                                       sortstrobj.objTeachlist.append(stroj.objTeachlist[i])
                                    }
                                }else{
                                sortstrobj.objTeachlist.append(stroj.objTeachlist[i])
                            }
                        }
                    }else{
                        if searchtext?.trim().characters.count == 0
                        {
                            if days.trim() != "" && days.characters.count > 0
                            {
                                print(days)
                                print(stroj.objTeachlist[i].available_time)
                                
                                let strarray = days.components(separatedBy: " ")
                                var isexist = false
                                for j in 0..<strarray.count
                                {
                                    if stroj.objTeachlist[i].available_time.range(of: strarray[j]) != nil
                                    {
                                        isexist = true
                                    }
                                }
                                if  isexist {
                                    sortstrobj.objTeachlist.append(stroj.objTeachlist[i])
                                }
                            }
                       // }
                    }
                }
                
                
            }
            
            if delegate != nil
            {
                if sortstrobj.objTeachlist.count > 0 || days.trim() != "" || !((txtSkill.text?.isEmpty)!)
                {
                    
                    delegate.FilterStringSearch(is_Filter: true, str_obj : stroj, sort_strobj: sortstrobj, str_string: txtSkill.text!, days : days)
                }else{
                     delegate.FilterStringSearch(is_Filter: false, str_obj : stroj, sort_strobj: sortstrobj, str_string: "", days : "")
                }
            }
            
        }else{
            if delegate != nil
            {
                delegate.FilterStringSearch(is_Filter: false, str_obj : stroj, sort_strobj: sortstrobj, str_string: "", days : "")
            }
            //self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    @IBAction func btnClearClicked(_ sender: UIButton) {
        
        txtSkill.text = ""
        if delegate != nil
        {
            delegate.FilterStringSearch(is_Filter: false, str_obj : stroj, sort_strobj: sortstrobj, str_string: "", days : "")
        }
        //self.dismiss(animated: true, completion: nil)
        
    }
    

}
