//
//  RateList.swift
//  demosetup
//
//  Created by Nikunj on 14/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class RateList: NSObject {
/*
     {"status":"true","msg":"Rating data gets sucessfully.","data":[{"stu_username":"rujul.student","stu_id":"81","stu_email":"rujul.student@gmail.com","tea_username":"rujul.teacher","tea_id":"82","tea_email":"rujul.teacher@gmail.com","rate_id":"11","is_approved":"1","rate":"5"}]}
     */
    
    var stu_username = ""
    var stu_id = ""
    var stu_email = ""
    var tea_username = ""
    var tea_id = ""
    var tea_email = ""
    var rate_id = ""
    var is_approved = ""
    var rate = "0"
    
    override init()
    {
        super.init()
    }
    
    init(data : JSON)
    {
        if let str = data["stu_username"].string
        {
            stu_username = str
        }
        if let str = data["stu_email"].string
        {
            stu_email = str
        }
        if let str = data["stu_id"].string
        {
            stu_id = str
        }
        if let str = data["tea_username"].string
        {
            tea_username = str
        }
        if let str = data["tea_id"].string
        {
            tea_id = str
        }
        if let str = data["tea_email"].string
        {
            tea_email = str
        }
        if let str = data["rate_id"].string
        {
            rate_id = str
        }
        if let str = data["is_approved"].string
        {
            is_approved = str
        }
        if let str = data["rate"].string
        {
            rate = str
        }
    }
}
