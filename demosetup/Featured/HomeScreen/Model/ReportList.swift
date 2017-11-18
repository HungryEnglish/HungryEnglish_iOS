//
//  ReportList.swift
//  demosetup
//
//  Created by Nikunj on 05/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportList: NSObject {

    var objreport = [ReportDetails]()
    
    func update(data : JSON)
    {
        for (_ ,value) in data["data"]
        {
            let obj = ReportDetails(data : value)
            objreport.append(obj)
        }
    }
}

class ReportDetails : NSObject
{
    
    var teacherFullName = ""
    var tSkills = ""
    var teacherWeChat = ""
    var teacherEmail = ""
    
    var stuSex = ""
    var stuWeChat = ""
    var stuAge = ""
    var stuFullName = ""
    var stuEmail = ""
    var stuSkills = ""
    var stuTime = ""
    var tProfileImage = ""
    var tResume = ""
    var tAudioFile = ""
    var tIdImage = ""
    var tAddress = ""
    var tTime = ""
    var stuStation = ""
    
    override init()
    {
        super.init()
    }
    
    init(data : JSON)
    {
        super.init()
        
        if let str = data["teacherFullName"].string
        {
            teacherFullName = str
        }
        if let str = data["tSkills"].string
        {
            tSkills = str
        }
        if let str = data["teacherWeChat"].string
        {
            teacherWeChat = str
        }
        if let str = data["teacherEmail"].string
        {
            teacherEmail = str
        }
        if let str = data["stuSex"].string
        {
            stuSex = str
        }
        if let str = data["stuWeChat"].string
        {
            stuWeChat = str
        }
        if let str = data["stuAge"].string
        {
            stuAge = str
        }
        if let str = data["stuFullName"].string
        {
            stuFullName = str
        }
        if let str = data["stuEmail"].string
        {
            stuEmail = str
        }
        if let str = data["stuSkills"].string
        {
            stuSkills = str
        }
        if let str = data["stuTime"].string
        {
            stuTime = str
        }
        if let str = data["tProfileImage"].string
        {
            tProfileImage = baseURL + "api/" + str
        }
        if let str = data["tResume"].string
        {
            tResume = baseURL + "api/" + str
        }
        if let str = data["tAudioFile"].string
        {
             tAudioFile = baseURL + "api/" + str
        }
        if let str = data["tIdImage"].string
        {
            tIdImage = baseURL + "api/" + str
        }
        if let str = data["tAddress"].string
        {
            tAddress = str
        }
        if let str = data["tTime"].string
        {
            tTime = str
        }
        if let str = data["stuStation"].string
        {
            stuStation = str
        }
    }
  
    
}

/**{
 "status" : "true",
 "data" : [
 {
 "tSkills" : "java",
 "teacherFullName" : "rujul teacher",
 "teacherWeChat" : "2147483647",
 "teacherEmail" : "rujul.teacher@gmail.com",
 "stuSex" : "Male\/男",
 "stuWeChat" : "2147483647",
 "stuAge" : "25",
 "stuFullName" : "Rujul students",
 "stuEmail" : "rujul.student@gmail.com",
 "stuSkills" : "Android",
 "stuTime" : "In early morning",
 "tProfileImage" : "",
 "tResume" : "",
 "tAudioFile" : "",
 "tIdImage" : "IdProof\/idProof_59d51d4c515fa.jpg",
 "tAddress" : "Kankaria",
 "tTime" : "Noon",
 "stuStation" : "kankaria"
 }
 ],
 "msg" : "Report data gets sucessfully."
 }
*/
