//
//  RegisterViewController.swift
//  demosetup
//
//  Created by Nikunj on 08/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController {

    
    // MARK: - OUTLETS -
    
    
    @IBOutlet weak var txtfullname: FloatLabelTextField!
    
    @IBOutlet weak var txtemail: FloatLabelTextField!
    
    @IBOutlet weak var txtusername: FloatLabelTextField!
    
    @IBOutlet weak var txtpassword: FloatLabelTextField!
    
    @IBOutlet weak var txtwechatid: FloatLabelTextField!
    
    @IBOutlet weak var btnRole: UIButton!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    // MARK: - VARIABLES -
    
    var role = "student"
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnRole.isSelected = false
        
        setBordertoView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - VOID METHODS -
    
    func setBordertoView()
    {
        
        btnSignUp.layer.cornerRadius = btnSignUp.frame.size.height/2
        // btnLogin.layer.borderColor = UIColor(colorLiteralRed: 60.0/255, green: 194.0/255, blue: 38.0/255, alpha: 1.0).cgColor
        //btnLogin.layer.borderWidth = 1.0
        btnSignUp.clipsToBounds = true
      
    }
    
    
    func validate() -> Bool
    {
        if (txtfullname.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter " + txtfullname.placeholder!)
        }else
        if (txtusername.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter " + txtusername.placeholder!)
        }else if (txtemail.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter " + txtemail.placeholder!)
        }else if !Utilities.isValidEmail(testStr: txtemail.text!)
        {
            Utilities.showMessage(text: "Please enter valid " + txtemail.placeholder!)
        }else if (txtpassword.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter Password/密码")
        }else if (txtwechatid.text?.isEmpty)!
        {
        
            Utilities.showMessage(text: "Please enter " + txtwechatid.placeholder!)
       
        }else{
            return true
        }
        return false
    }
    
    
    func callAPI()
    {
        let param : [String : String] =
            [
                p_username : txtusername.text!,
                p_email : txtemail.text!,
                p_password : txtpassword.text!,
                p_mob_no : txtwechatid.text!,
                p_fullName : txtfullname.text!,
                p_role : role,
            ]
        
        print(param)
        
        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.register.rawValue, handler: { response in
            
            print(JSON(response))
            
            Utilities.showMessage(text: "You have successfully registered, Please login")
            
             _ = self.navigationController?.popViewController(animated: true)
       
        })
    }
    
    
    
    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnRoleClicked(_ sender: UIButton) {
        
        if btnRole.isSelected
        {
            btnRole.isSelected = false
            role = "student"
        }else{
            btnRole.isSelected = true
            role = "teacher"
        }
        
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton)
    {
        self.view.endEditing(true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if validate()
        {
            callAPI()
        }
        
    }
    
}
