//
//  User.swift
//  BNHPavilion
//
//  Created by Peerbits on 10/08/17.
//  Copyright © 2017 Peerbits 8. All rights reserved.
//

import UIKit
import SwiftyJSON



class User: NSObject {

    
    //MARK : --- VARIABLES ---
    /*
     {
     "mob_no" : "0",
     "password" : "0b4e7a0e5fe84ad35fb5f95b9ceeac79",
     "id" : "61",
     "total_ratings" : "",
     "device_id" : "ABC",
     "fullName" : "aaa",
     "username" : "",
     "email" : "aaa@a.com",
     "role" : "student",
     "studentInfo" : {
     "address" : "",
     "skills" : "",
     "station" : "aaa",
     "studentId" : "61",
     "age" : "18",
     "sex" : "Male\/男",
     "available_time" : "a"
     },
     "is_active" : "1"
     },

     
     */
    var userid = ""
    var mob_no = ""
    var password = ""
    var total_ratings = ""
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
    
    
    
    
    //MARK: -- Initialization --
    
    override init() {
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
        
         saveToDefaults()
        
    }
    
  
    //MARK : -- DEFAULT STORAGE --
    
    func saveToDefaults()
    {
        Defaults.set(DictionaryUserDetails(), forKey: User_Details)
        Defaults.synchronize()
    }
    
    func DictionaryUserDetails() -> [String : Any]
    {
        var dicinfo = [String : Any]()
        
        dicinfo["id"] = userid
        dicinfo["mob_no"] = mob_no
        dicinfo["password"] = password
        dicinfo["total_ratings"] = total_ratings
        dicinfo["device_id"] = device_id
        dicinfo["fullName"] = fullName
        dicinfo["username"] = username
        dicinfo["email"] = email
        dicinfo["role"] = role
        dicinfo["is_active"] = is_active
        
        
        return dicinfo
    }
    
    
    // MARK: -- LOGOUT --
    
    func logout()
    {
        Defaults.removeObject(forKey: User_Details)
        
         userid = ""
         mob_no = ""
         password = ""
         total_ratings = ""
         device_id = ""
         fullName = ""
         username = ""
         email = ""
         role = ""
         is_active = ""
        
        //redirect_to_Login_Screen
       appInstance.GotocheckScreens()        
    }
    
    
    
    
    
}


