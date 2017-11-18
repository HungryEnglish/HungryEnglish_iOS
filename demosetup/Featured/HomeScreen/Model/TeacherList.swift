//
//  TeacherList.swift
//  demosetup
//
//  Created by Nikunj on 18/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeacherList: NSObject {

    var objTeachlist = [TeacherDetails]()
    var objSingle = TeacherDetails()
    
    func update(data: JSON)
    {
        for (_ ,value) in data["data"]
        {
            let obj = TeacherDetails(response : value)
            objTeachlist.append(obj)
        }
    }
    
    func updatesingle(data : JSON)
    {
        objSingle = TeacherDetails(response: data["data"])
        objSingle.teacher = "info"
        objSingle.update(response: data)
    }
    
}

class TeacherDetails: NSObject
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
    var hourly_rate = ""
    var nearest_station = ""
    var rating = "0.0"
    
   
    var longitude = ""
    var latitude = ""
    
    var teacher = "teacherInfo"
    var address = ""
    var available_time = ""
    var resume = ""
    var profileImage = ""
    var skills = ""
    var idImage = ""
    var audioFile = ""
    var teacherid = ""
    
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
        if let str = response[teacher]["hourly_rate"].string
        {
            hourly_rate = str
        }
        
        if let str = response[teacher]["nearest_station"].string
        {
            nearest_station = str
        }
        if let str = response[teacher]["address"].string
        {
            address = str
        }
        
        if let str = response[teacher]["resume"].string
        {
            if str != ""
            {
                resume = baseURL + "api/" + str
            }
        }
        
        if let str = response[teacher]["available_time"].string
        {
            available_time = str
        }
        
        if let str = response[teacher]["profileImage"].string
        {
            if str != ""
            {
                profileImage = baseURL + "api/" + str
            }
            
        }
        if let str = response[teacher]["uId"].string
        {
            teacherid = str
        }
        if let str = response[teacher]["idImage"].string
        {
            if str != ""
            {
                 idImage = baseURL + "api/" + str
            }
           
        }
        if let str = response[teacher]["skills"].string
        {
            skills = str
        }
        if let str = response[teacher]["audioFile"].string
        {
            if str != ""
            {
                audioFile = baseURL + "api/" + str
            }
            
        }
    }
    
    func update(response : JSON)
    {
        if let str = response[teacher]["address"].string
        {
            address = str
        }
        
        if let str = response[teacher]["resume"].string
        {
            if str != ""
            {
                resume = baseURL + "api/" + str
            }
        }
        
        if let str = response[teacher]["available_time"].string
        {
            available_time = str
        }
        
        if let str = response[teacher]["profileImage"].string
        {
            if str != ""
            {
                profileImage = baseURL + "api/" + str
            }
            
        }
        if let str = response[teacher]["hourly_rate"].string
        {
            hourly_rate = str
        }
        
        if let str = response[teacher]["nearest_station"].string
        {
            nearest_station = str
        }
        
        
        if let str = response[teacher]["rating"].string
        {
            rating = str
        }
        
        if let str = response[teacher]["uId"].string
        {
            teacherid = str
        }
        if let str = response[teacher]["idImage"].string
        {
            if str != ""
            {
                idImage = baseURL + "api/" + str
            }
        }
        if let str = response[teacher]["skills"].string
        {
            skills = str
        }
        if let str = response[teacher]["audioFile"].string
        {
            if str != ""
            {
                audioFile = baseURL + "api/" + str
            }
        }
    }
    
}
