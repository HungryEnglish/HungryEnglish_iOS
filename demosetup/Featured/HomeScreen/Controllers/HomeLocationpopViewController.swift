//
//  HomeLocationpopViewController.swift
//  demosetup
//
//  Created by A on 10/30/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

protocol HomeLocationDelegate {
    func GetHomeLocation(isYes : Bool, straddress: String)
}


class HomeLocationpopViewController: UIViewController {

    // MARK: - OUTLETS
    
    @IBOutlet weak var lbltext: UILabel!
    
    @IBOutlet weak var btnYes: UIButton!
    
    
    @IBOutlet weak var btnNo: UIButton!
    
    
    // MARK: - VARIABLES
    
    var delegate : HomeLocationDelegate!
    
    var straddress = ""
    
    // MARK: - METHODS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configbutton()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configbutton()
    {
        
        btnYes.layer.cornerRadius = btnYes.frame.size.height / 2
        btnNo.layer.cornerRadius = btnNo.frame.size.height / 2
        
        lbltext.text = "Do you want to set \(straddress) address as your Home Location ?"
    }
    
    // MARK: - CLICKED EVENTS
    
    @IBAction func btnYesClicked(_ sender: UIButton) {
        
        if delegate != nil
        {
            delegate.GetHomeLocation(isYes: true, straddress: straddress)
        }
        
    }
    
    
    @IBAction func btnNoClicked(_ sender: UIButton) {
        
        if delegate != nil
        {
            delegate.GetHomeLocation(isYes: false, straddress: "")
        }
        
    }
    
    
}
