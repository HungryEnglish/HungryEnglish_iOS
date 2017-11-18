//
//  StudentList.swift
//  demosetup
//
//  Created by Nikunj on 17/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentList: NSObject {
  
    var objSingle = StudentDetails()
    var objStudlist = [StudentDetails]()
    
    func update(data: JSON)
    {
        for (_ ,value) in data["data"]
        {
            let obj = StudentDetails(response : value)
            objStudlist.append(obj)
        }
    }
    
    func updatesingle(data : JSON)
    {
        objSingle = StudentDetails(response: data["data"])
        objSingle.stud = "info"
        objSingle.update(response: data)
    }
    
    
}

class StudentDetails: NSObject
{
    var userid = ""
    var mob_no = ""
    var password = ""
    var total_ratings = "0.0"
    var device_id = ""
    var fullName = ""
    var username = ""
    var email = ""
    var role = ""
    var is_active = ""
    
    var stud = "studentInfo"
    var address = ""
    var available_time = ""
    var sex = ""
    var age = ""
    var studentId = ""
    var station = ""
    var skills = ""
    
    var longitude = ""
    var latitude = ""
    
    override init()
    {
        super.init()
    }
    
    init(response : JSON)
    {
        super.init()
        
        if let str = response["id"].string
        {
            userid = str
        }
        
        if let str = response["mob_no"].string
        {
            mob_no = str
        }
        if let str = response["password"].string
        {
            password = str
        }
        if let str = response["email"].string
        {
            email = str
        }
        if let str = response["fullName"].string
        {
            fullName = str
        }
        if let str = response["role"].string
        {
            role = str
        }
        if let str = response["total_ratings"].string
        {
            total_ratings = str
        }
        
        if let str = response["latitude"].string
        {
            latitude = str
        }
        
        if let str = response["longitude"].string
        {
            longitude = str
        }
        
        if let str = response["device_id"].string
        {
            device_id = str
        }
        if let str = response["username"].string
        {
            username = str
        }
        if let str = response["is_active"].string
        {
            is_active = str
        }
        
        if let str = response[stud]["address"].string
        {
            address = str
        }
        
        if let str = response[stud]["sex"].string
        {
            sex = str
        }
        
        if let str = response[stud]["available_time"].string
        {
            available_time = str
        }
        
        if let str = response[stud]["age"].string
        {
            age = str
        }
        if let str = response[stud]["studentId"].string
        {
            studentId = str
        }
        if let str = response[stud]["station"].string
        {
            station = str
        }
        if let str = response[stud]["skills"].string
        {
            skills = str
        }
        
    }
    
    func update(response : JSON)
    {
        if let str = response[stud]["address"].string
        {
            address = str
        }
        
        if let str = response[stud]["sex"].string
        {
            sex = str
        }
        
        if let str = response[stud]["available_time"].string
        {
            available_time = str
        }
        
        if let str = response[stud]["age"].string
        {
            age = str
        }
        if let str = response[stud]["studentId"].string
        {
            studentId = str
        }
        if let str = response[stud]["station"].string
        {
            station = str
        }
        if let str = response[stud]["skills"].string
        {
            skills = str
        }
    }
    
    
}
