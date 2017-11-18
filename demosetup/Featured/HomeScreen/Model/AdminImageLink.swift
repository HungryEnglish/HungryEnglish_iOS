//
//  AdminImageLink.swift
//  demosetup
//
//  Created by Nikunj on 22/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class AdminImageLink: NSObject {
    /*  /*{
     "info" : {
     "image1" : "Banner\/4mdrhobm.png",
     "image2" : "Banner\/_20160614_092147.JPG",
     "image3" : "Banner\/1557653_1064956596920666_3783627813045999004_n.jpg",
     "link1" : "Teacher Resource 1--www.play.com--www.play.com",
     "link3" : "Teacher Resource 3--www.play.com--www.play.com",
     "link5" : "Teacher Resource 5--www.play.com",
     "link2" : "Teacher Resource 2--www.play.com--www.play.com",
     "link4" : "Teacher Resource 4--www.play.com",
     "link6" : "Teacher Resource 6--www.play.com"
     },
     "status" : "true",
     "msg" : "Information get sucessfully"
     }
     */
     **/
    
    var image1 = ""
    var image2 = ""
    var image3 = ""
    
    var imglink1 = ""
    var imglink2 = ""
    var imglink3 = ""
    
    var link1 = ""
    var link2 = ""
    var link3 = ""
    var link4 = ""
    var link5 = ""
    var link6 = ""
    
    var title1 = ""
    var title2 = ""
    var title3 = ""
    var title4 = ""
    var title5 = ""
    var title6 = ""
    
    override init()
    {
        super.init()
    }
    
    init(data: JSON)
    {
        super.init()
        
        if let str = data["image1"].string
        {
            if str != ""
            {
                image1 = baseURL + "api/" + str
            }
            
        }
        if let str = data["image2"].string
        {
            if str != ""
            {
                image2 = baseURL + "api/" + str
            }
        }
        if let str = data["image3"].string
        {
            if str != ""
            {
                image3 = baseURL + "api/" + str
            }
        }
        if let str = data["link1"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    if strarr.count == 3
                    {
                        imglink1 = strarr[2]
                    }
                    title1 = strarr[0]
                    link1 = strarr[1]
                }
            }
        }
        if let str = data["link2"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    if strarr.count == 3
                    {
                        imglink2 = strarr[2]
                    }
                    title2 = strarr[0]
                    link2 = strarr[1]
                }
            }
        }
        if let str = data["link3"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    if strarr.count == 3
                    {
                        imglink3 = strarr[2]
                    }
                    title3 = strarr[0]
                    link3 = strarr[1]
                }
            }
        }
        if let str = data["link4"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    title4 = strarr[0]
                    link4 = strarr[1]
                }
            }
        }
        if let str = data["link5"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    title5 = strarr[0]
                    link5 = strarr[1]
                }
            }
        }
        if let str = data["link6"].string
        {
            if str != ""
            {
                let strarr = str.components(separatedBy: "--")
                if strarr.count > 0
                {
                    title6 = strarr[0]
                    link6 = strarr[1]
                }
            }
        }
    }
    
    
}
