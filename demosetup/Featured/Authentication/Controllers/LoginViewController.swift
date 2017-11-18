//
//  LoginViewController.swift
//  demosetup
//
//  Created by Nikunj on 08/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var txtusername: FloatLabelTextField!
    
    @IBOutlet weak var txtpassword: FloatLabelTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    @IBOutlet weak var btnForgotpassword: UIButton!
    
    @IBOutlet weak var viewheader: UIView!
    @IBOutlet weak var viewmain: UIView!
    
    
    // MARK: - VARIABLES -
    
    
    
    // MARK: - METHODS -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBordertoView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        txtusername.text = ""
        txtpassword.text = ""
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - VOID METHODS -
    
    func setBordertoView()
    {
        viewheader.layer.cornerRadius = viewheader.frame.size.height/2
        viewheader.clipsToBounds = true
        
        
        Utilities.BorderForView(view: viewmain)
        
        btnLogin.layer.cornerRadius = btnLogin.frame.size.height/2
       // btnLogin.layer.borderColor = UIColor(colorLiteralRed: 60.0/255, green: 194.0/255, blue: 38.0/255, alpha: 1.0).cgColor
        //btnLogin.layer.borderWidth = 1.0
        btnLogin.clipsToBounds = true
        
        btnCreateAccount.layer.cornerRadius = btnCreateAccount.frame.size.height/2
       // btnCreateAccount.layer.borderColor = UIColor(colorLiteralRed: 60.0/255, green: 194.0/255, blue: 38.0/255, alpha: 1.0).cgColor
        //btnCreateAccount.layer.borderWidth = 1.0
        btnCreateAccount.clipsToBounds = true
        
    }
    
    
    func validate() -> Bool
    {
        if (txtusername.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter Username/Email - 用户名/邮箱")
        }else if (txtpassword.text?.isEmpty)!
        {
            Utilities.showMessage(text: "Please enter Password/密码")
        }else{
            return true
        }
        return false
    }
    
    
    func callAPI()
    {
        let param : [String : String] =
            [
                p_u_name : txtusername.text!,
                p_u_pass : txtpassword.text!,
           ]

        print(param)

        AlamofireModel.GetDataFromServerGET(parameter: param as NSDictionary, URL: APIAction.login.rawValue, handler: { response in

            print(JSON(response))
            
            //let dict = JSON(response)
           
            _ = User(response: JSON(response["data"]!!))

            appInstance.GotocheckScreens()

        })
    }
    
    // MARK: - CLICKED EVENTS -
    
    
    @IBAction func btnForgotPasswordClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        Utilities.showMessage(text : "Coming Soon")
    }
    
    @IBAction func btnCreateAccountClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let VC = Utilities.viewController(name: "RegisterViewController", onStoryboard: Sbname.Authen.rawValue)
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if validate()
        {
            callAPI()
        }
        
        
//        let VC = Utilities.viewController(name: "LoadingViewController", onStoryboard: Sbname.Authen.rawValue)
//        VC.modalPresentationStyle = .fullScreen
//
//        self.present(VC, animated: false, completion: nil)
        
        //self.navigationController?.pushViewController(VC, animated: true)
        
    }
}
