//
//  ContactUsViewController.swift
//  demosetup
//
//  Created by A on 10/23/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    // MARK: - OUTLETS -
    
    
    
    
    
    // MARK: - VARIABLES -
    
    
    
    
    
    // MARK: - VIEW LIFECYLCES -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - CLICKED EVENTS -
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
}
