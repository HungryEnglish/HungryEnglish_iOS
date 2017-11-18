//
//  CommonData.swift
//  RMSLoyalty
//
//  Created by Peerbits on 26/08/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommonData: NSObject {

    var objdata = [DataDetails]()
    
  
    override init() {
        super.init()
    }
    
    init(response : JSON)
    {
        super.init()
        for (_, value) in response
        {
            let obj = DataDetails()
            obj.Update(data: value)
            objdata.append(obj)
        }
    }

}

class DataDetails
{

    var id = 0
    var name = ""
    
    func Update(data : JSON)
    {
        if let str = data["id"].int
        {
            id = str
        }
        if let str = data["name"].string
        {
            name = str
        }
    }
}

