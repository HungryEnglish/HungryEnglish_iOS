//
//  MakeCSV.swift
//  csvGenerator
//
//  Created by Irshad.
//  Copyright © 2017 peerbits. All rights reserved.
//

import Foundation

class MakeCSV {
    
    private var csvText : String = ""
    private var msg : String = ""
    // Single Header and Multiple Data
    
    init(headerTitle : String,subHeaderTitle : String,data : [String],fileName : String) {
        
        if headerTitle != ""
        {
         csvText = "\(headerTitle)\n"
        }
        
        if subHeaderTitle != ""
        {
         csvText.append("\(subHeaderTitle)\n")
        }
        
        for i in 0..<data.count
        {
            csvText.append("\(data[i])\n")
        }
        
        if fileName == ""
        {
          saveFile(fileName: "Irshad.xls")
        }
        else
        {
          saveFile(fileName: "\(fileName).xls")
        }
    }
    
    // Multiple Header and Multiple Data
    
    init(headerTitle : [String],subHeaderTitle : [String],data : [Int : Array<String>],fileName : String) {
       
        for i in 0..<headerTitle.count
        {
         if csvText == ""
         {
          csvText = "\(headerTitle[i])\n"
         }
         else
         {
          csvText.append("\(headerTitle[i])\n")
         }
            
         if subHeaderTitle.count != 0
         {
            if i < subHeaderTitle.count && subHeaderTitle[0] != ""
            {
             csvText.append("\(subHeaderTitle[i])\n")
            }
         }
        
         let arr = data[i]!
            
         for j in 0..<arr.count
         {
            csvText.append("\(arr[j])\n")
         }
        }
        
        if fileName == ""
        {
            saveFile(fileName: "Report.xls")
        }
        else
        {
            saveFile(fileName: "\(fileName).xls")
        }
    }
    
    // Saving File in Document Directory
    
    private func saveFile(fileName : String)
    {
        // Save csv to local
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        {
            let documentsFileName = documentDirectories + "/" + fileName
            let documentsFileNameURL = URL(fileURLWithPath: documentsFileName)
            
            do
            {
                try csvText.write(to: documentsFileNameURL, atomically: true, encoding: String.Encoding.utf8)
                msg = "\(documentsFileNameURL)"
            }
            catch{
                print(error)
                msg = error.localizedDescription
            }
            
            print()
        }
    }
    
    // Show Msg
    
    func showSataus() -> String {
        return msg
    }
}
